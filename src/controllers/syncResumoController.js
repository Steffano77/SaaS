const db = require('../database/connection');

// Recebe o resumo do dia mandado pelo servidor LOCAL (rodando na padaria) — não é
// dado bruto (comanda por comanda), só os números finais. Idempotente: pode mandar
// de novo o mesmo dia várias vezes (a cada X minutos), sempre sobrescreve com o
// valor mais atual em vez de somar/duplicar.
exports.salvar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { data, total_vendas, qtd_comandas_fechadas, qtd_comandas_abertas, qtd_notas_problema } = req.body;

  const dia = data || new Date().toISOString().slice(0, 10);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(dia)) return res.status(400).json({ erro: 'Data inválida.' });

  await db.query(
    `INSERT INTO sync_resumo_local (padaria_id, data, total_vendas, qtd_comandas_fechadas, qtd_comandas_abertas, qtd_notas_problema)
     VALUES (?, ?, ?, ?, ?, ?)
     ON DUPLICATE KEY UPDATE
       total_vendas = VALUES(total_vendas),
       qtd_comandas_fechadas = VALUES(qtd_comandas_fechadas),
       qtd_comandas_abertas = VALUES(qtd_comandas_abertas),
       qtd_notas_problema = VALUES(qtd_notas_problema),
       atualizado_em = NOW()`,
    [padaria_id, dia, parseFloat(total_vendas) || 0, parseInt(qtd_comandas_fechadas) || 0, parseInt(qtd_comandas_abertas) || 0, parseInt(qtd_notas_problema) || 0]
  );

  res.json({ ok: true });
};

// Devolve o resumo mais recente (hoje, por padrão) — usado pelo dono acompanhando
// de casa/celular, logado normal na nuvem.
exports.buscar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const dia = req.query.data || new Date().toISOString().slice(0, 10);

  const [[resumo]] = await db.query(
    `SELECT data, total_vendas, qtd_comandas_fechadas, qtd_comandas_abertas, qtd_notas_problema, atualizado_em
     FROM sync_resumo_local WHERE padaria_id = ? AND data = ?`,
    [padaria_id, dia]
  );

  if (!resumo) return res.json({ existe: false, data: dia });
  res.json({ existe: true, ...resumo });
};

// Exporta o catálogo de produtos completo dessa padaria — usado pelo servidor LOCAL
// pra puxar cadastro/preço atualizado da nuvem (nunca o contrário: o local nunca manda
// produto pra cá, só lê). Não inclui estoque de propósito — estoque é sempre controlado
// localmente pelo sistema que está de fato vendendo, puxar o número da nuvem aqui
// sobrescreveria um estoque que já está desatualizado no momento em que chega.
exports.catalogoProdutos = async (req, res) => {
  const padaria_id = req.padaria.id;
  // Categorias vêm junto — produtos referenciam categoria_id com FK no banco local,
  // então o produto não pode ser salvo se a categoria dele ainda não existir localmente
  // (bug real: gravar produto antes de garantir a categoria travava com erro de FK).
  const [categorias] = await db.query(
    `SELECT id, nome FROM categorias WHERE padaria_id = ?`, [padaria_id]
  );
  const [produtos] = await db.query(
    `SELECT id, categoria_id, codigo_barras, codigo_balanca, nome, unidade, custo_unitario,
            preco_venda, estoque_minimo, validade, ativo, fornecedor_id, embalagem_preco,
            embalagem_qtd, venda_rapida, controla_estoque, ncm, origem_producao,
            situacao_icms, cest
     FROM produtos WHERE padaria_id = ?`,
    [padaria_id]
  );
  // Funcionários (atendentes) e clientes faturado também são cadastro que precisa existir
  // localmente pra comanda funcionar igual (escolher atendente, faturar pra cliente/CPF).
  // pin_hash já vem criptografado (hash), seguro de copiar como está.
  const [atendentes] = await db.query(
    `SELECT id, nome, ativo, pin_hash, role FROM atendentes WHERE padaria_id = ?`, [padaria_id]
  );
  const [clientesFaturado] = await db.query(
    `SELECT id, cnpj, nome, endereco, telefone, tipo, limite FROM clientes_faturado WHERE padaria_id = ?`,
    [padaria_id]
  );
  res.json({ categorias, produtos, atendentes, clientesFaturado });
};
