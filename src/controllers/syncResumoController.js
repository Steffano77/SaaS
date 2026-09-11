const db = require('../database/connection');

// Recebe o resumo do dia mandado pelo servidor LOCAL (rodando na padaria) — não é
// dado bruto (comanda por comanda), só os números finais. Idempotente: pode mandar
// de novo o mesmo dia várias vezes (a cada X minutos), sempre sobrescreve com o
// valor mais atual em vez de somar/duplicar.
exports.salvar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { data, total_vendas, qtd_comandas_fechadas, qtd_comandas_abertas } = req.body;

  const dia = data || new Date().toISOString().slice(0, 10);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(dia)) return res.status(400).json({ erro: 'Data inválida.' });

  await db.query(
    `INSERT INTO sync_resumo_local (padaria_id, data, total_vendas, qtd_comandas_fechadas, qtd_comandas_abertas)
     VALUES (?, ?, ?, ?, ?)
     ON DUPLICATE KEY UPDATE
       total_vendas = VALUES(total_vendas),
       qtd_comandas_fechadas = VALUES(qtd_comandas_fechadas),
       qtd_comandas_abertas = VALUES(qtd_comandas_abertas),
       atualizado_em = NOW()`,
    [padaria_id, dia, parseFloat(total_vendas) || 0, parseInt(qtd_comandas_fechadas) || 0, parseInt(qtd_comandas_abertas) || 0]
  );

  res.json({ ok: true });
};

// Devolve o resumo mais recente (hoje, por padrão) — usado pelo dono acompanhando
// de casa/celular, logado normal na nuvem.
exports.buscar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const dia = req.query.data || new Date().toISOString().slice(0, 10);

  const [[resumo]] = await db.query(
    `SELECT data, total_vendas, qtd_comandas_fechadas, qtd_comandas_abertas, atualizado_em
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
  const [produtos] = await db.query(
    `SELECT id, categoria_id, codigo_barras, codigo_balanca, nome, unidade, custo_unitario,
            preco_venda, estoque_minimo, validade, ativo, fornecedor_id, embalagem_preco,
            embalagem_qtd, venda_rapida, controla_estoque, ncm, origem_producao,
            situacao_icms, cest
     FROM produtos WHERE padaria_id = ?`,
    [padaria_id]
  );
  res.json({ produtos });
};
