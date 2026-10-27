const db = require('../database/connection');

const LIMITE_PADRAO_FUNCIONARIO = 500;

// Só dígitos — pra comparar CNPJ/CPF digitado/bipado sem depender de máscara igual.
function limparDoc(doc) {
  return String(doc || '').replace(/\D/g, '');
}

function formatarCnpj(cnpj) {
  const d = limparDoc(cnpj);
  if (d.length !== 14) return cnpj;
  return `${d.slice(0, 2)}.${d.slice(2, 5)}.${d.slice(5, 8)}/${d.slice(8, 12)}-${d.slice(12, 14)}`;
}

exports.listar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [clientes] = await db.query(
    `SELECT * FROM clientes_faturado WHERE padaria_id = ? ORDER BY tipo, nome`, [padaria_id]
  );
  // Junto com cada um, já manda o saldo devedor atual (soma dos pagamentos "Faturado"
  // ainda não quitados) — pra tela mostrar de cara quem está perto do limite.
  const [saldos] = await db.query(
    `SELECT cliente_documento, COALESCE(SUM(valor - valor_pago), 0) AS saldo
     FROM comanda_pagamentos
     WHERE forma_pagamento = 'Faturado' AND quitado_em IS NULL AND cliente_documento IS NOT NULL
     GROUP BY cliente_documento`
  );
  const saldoPorDoc = Object.fromEntries(saldos.map(s => [s.cliente_documento, parseFloat(s.saldo)]));
  // Quem já foi "lançado" (cobrança enviada, aguardando pagamento) mas ainda não foi
  // quitado — pra tela mostrar o selo "Lançado" em vez do botão de novo.
  const [lancados] = await db.query(
    `SELECT DISTINCT cliente_documento FROM comanda_pagamentos
     WHERE forma_pagamento = 'Faturado' AND quitado_em IS NULL AND lancado_em IS NOT NULL
       AND cliente_documento IS NOT NULL`
  );
  const lancadoPorDoc = new Set(lancados.map(l => l.cliente_documento));
  // Valor específico do que foi lançado (pode ser menor que o saldo total, se o
  // cliente consumiu mais depois do "Fechar e cobrar") — pra confirmar a baixa certa.
  const [lancadosValor] = await db.query(
    `SELECT cliente_documento, COALESCE(SUM(valor - valor_pago), 0) AS valor
     FROM comanda_pagamentos
     WHERE forma_pagamento = 'Faturado' AND quitado_em IS NULL AND lancado_em IS NOT NULL
       AND cliente_documento IS NOT NULL
     GROUP BY cliente_documento`
  );
  const lancadoValorPorDoc = Object.fromEntries(lancadosValor.map(l => [l.cliente_documento, parseFloat(l.valor)]));
  res.json(clientes.map(c => ({
    ...c,
    saldo_devedor: saldoPorDoc[c.cnpj] || 0,
    lancado: lancadoPorDoc.has(c.cnpj),
    saldo_lancado: lancadoValorPorDoc[c.cnpj] || 0,
  })));
};

// Busca por documento (CNPJ ou CPF) — usado na hora de cobrar em "Faturado".
exports.buscarPorCnpj = async (req, res) => {
  const padaria_id = req.padaria.id;
  const docLimpo = limparDoc(req.params.cnpj);
  if (docLimpo.length !== 14 && docLimpo.length !== 11) {
    return res.status(400).json({ erro: 'Documento inválido — CNPJ tem 14 números, CPF tem 11.' });
  }
  const [[cliente]] = await db.query(
    `SELECT * FROM clientes_faturado WHERE padaria_id = ? AND cnpj = ?`, [padaria_id, docLimpo]
  );
  if (!cliente) return res.status(404).json({ erro: 'Nenhum cliente cadastrado com esse documento.' });
  res.json(cliente);
};

exports.criar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const nome = String(req.body.nome || '').trim();
  const tipo = req.body.tipo === 'funcionario' ? 'funcionario' : 'empresa';
  const docLimpo = limparDoc(req.body.cnpj);
  const endereco = String(req.body.endereco || '').trim() || null;
  const telefone = String(req.body.telefone || '').trim() || null;
  // Funcionário sempre nasce com limite de R$500 — CNPJ (empresa) nunca tem limite.
  const limite = tipo === 'funcionario' ? LIMITE_PADRAO_FUNCIONARIO : null;

  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });
  const tamanhoEsperado = tipo === 'funcionario' ? 11 : 14;
  if (docLimpo.length !== tamanhoEsperado) {
    return res.status(400).json({
      erro: tipo === 'funcionario' ? 'CPF inválido — precisa ter 11 números.' : 'CNPJ inválido — precisa ter 14 números.'
    });
  }

  const [[existe]] = await db.query(
    `SELECT id FROM clientes_faturado WHERE padaria_id = ? AND cnpj = ?`, [padaria_id, docLimpo]
  );
  if (existe) return res.status(400).json({ erro: 'Já existe um cliente cadastrado com esse documento.' });

  const [r] = await db.query(
    `INSERT INTO clientes_faturado (padaria_id, cnpj, nome, endereco, telefone, tipo, limite) VALUES (?,?,?,?,?,?,?)`,
    [padaria_id, docLimpo, nome, endereco, telefone, tipo, limite]
  );
  res.status(201).json({ id: r.insertId, cnpj: docLimpo, nome, endereco, telefone, tipo, limite });
};

exports.atualizar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const nome = String(req.body.nome || '').trim();
  const endereco = String(req.body.endereco || '').trim() || null;
  const telefone = String(req.body.telefone || '').trim() || null;
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });

  // Funcionário sempre tem limite. Empresa (CNPJ) também pode ter, opcional: vazio ou 0
  // = sem limite (NULL), que é como todas as empresas já cadastradas continuam.
  const [[atual]] = await db.query(
    `SELECT tipo FROM clientes_faturado WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]
  );
  if (!atual) return res.status(404).json({ erro: 'Cliente não encontrado.' });

  const limiteVeio = req.body.limite !== undefined && req.body.limite !== null;
  const limiteVazio = !limiteVeio || String(req.body.limite).trim() === '';
  if ((atual.tipo === 'funcionario' && !limiteVazio) || (atual.tipo === 'empresa' && limiteVeio)) {
    let limite = limiteVazio ? null : parseFloat(String(req.body.limite).replace(',', '.'));
    if (limite !== null && (isNaN(limite) || limite < 0)) return res.status(400).json({ erro: 'Limite inválido.' });
    if (atual.tipo === 'empresa' && !(limite > 0)) limite = null;
    await db.query(
      `UPDATE clientes_faturado SET nome = ?, endereco = ?, telefone = ?, limite = ? WHERE id = ? AND padaria_id = ?`,
      [nome, endereco, telefone, limite, req.params.id, padaria_id]
    );
  } else {
    await db.query(
      `UPDATE clientes_faturado SET nome = ?, endereco = ?, telefone = ? WHERE id = ? AND padaria_id = ?`,
      [nome, endereco, telefone, req.params.id, padaria_id]
    );
  }
  res.json({ ok: true });
};

exports.remover = async (req, res) => {
  const padaria_id = req.padaria.id;
  await db.query(`DELETE FROM clientes_faturado WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]);
  res.json({ ok: true });
};

// Saldo devedor + limite de um documento — usado na hora de cobrar em "Faturado" pra
// travar a venda se o funcionário for passar de R$500. Empresa (CNPJ) nunca trava.
exports.saldo = async (req, res) => {
  const padaria_id = req.padaria.id;
  const docLimpo = limparDoc(req.params.documento);
  const [[cliente]] = await db.query(
    `SELECT tipo, limite FROM clientes_faturado WHERE padaria_id = ? AND cnpj = ?`, [padaria_id, docLimpo]
  );
  if (!cliente) return res.status(404).json({ erro: 'Cliente não encontrado.' });
  const [[{ saldo }]] = await db.query(
    `SELECT COALESCE(SUM(cp.valor - cp.valor_pago), 0) AS saldo
     FROM comanda_pagamentos cp JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.padaria_id = ? AND cp.forma_pagamento = 'Faturado' AND cp.quitado_em IS NULL AND cp.cliente_documento = ?`,
    [padaria_id, docLimpo]
  );
  const saldoDevedor = parseFloat(saldo);
  const limite = cliente.tipo === 'funcionario'
    ? parseFloat(cliente.limite || 0)
    : (parseFloat(cliente.limite) > 0 ? parseFloat(cliente.limite) : null); // empresa: só se tiver limite
  res.json({
    tipo: cliente.tipo,
    limite,
    saldoDevedor,
    disponivel: limite === null ? null : Math.max(0, limite - saldoDevedor),
  });
};

// Extrato — tudo que esse documento consumiu em "Faturado", pra conferir/imprimir.
exports.extrato = async (req, res) => {
  const padaria_id = req.padaria.id;
  const docLimpo = limparDoc(req.params.documento);
  const [linhas] = await db.query(
    `SELECT c.id AS comanda_id, c.identificador, c.fechada_em, cp.valor, cp.valor_pago, cp.quitado_em, cp.forma_quitacao
     FROM comanda_pagamentos cp JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.padaria_id = ? AND cp.forma_pagamento = 'Faturado' AND cp.cliente_documento = ?
     ORDER BY c.fechada_em DESC`,
    [padaria_id, docLimpo]
  );
  // Junto com cada comanda, os itens dela — pra dar pra reimprimir o recibo completo
  // (igual o de uma venda de verdade) direto do histórico, não só o resumo do valor.
  if (linhas.length) {
    const ids = linhas.map(l => l.comanda_id);
    const [itens] = await db.query(
      `SELECT comanda_id, produto_id, nome_produto, unidade, quantidade, preco_unitario, subtotal
       FROM itens_comanda WHERE comanda_id IN (?)`,
      [ids]
    );
    const itensPorComanda = {};
    for (const i of itens) {
      if (!itensPorComanda[i.comanda_id]) itensPorComanda[i.comanda_id] = [];
      itensPorComanda[i.comanda_id].push(i);
    }
    for (const l of linhas) l.itens = itensPorComanda[l.comanda_id] || [];
  }
  res.json(linhas);
};

// "Fechar e cobrar" (só empresas/CNPJ) — marca os consumos em aberto como "lançados"
// (cobrança já enviada/impressa pro cliente cobrar), SEM zerar o saldo devedor — o
// saldo só zera de verdade quando a empresa pagar e você confirmar em "Dar baixa".
exports.lancar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const docLimpo = limparDoc(req.params.documento);
  const [r] = await db.query(
    `UPDATE comanda_pagamentos cp JOIN comandas c ON c.id = cp.comanda_id
     SET cp.lancado_em = NOW()
     WHERE c.padaria_id = ? AND cp.forma_pagamento = 'Faturado' AND cp.cliente_documento = ?
       AND cp.quitado_em IS NULL AND cp.lancado_em IS NULL`,
    [padaria_id, docLimpo]
  );
  res.json({ ok: true, lancados: r.affectedRows });
};

// Formas aceitas pra registrar como a dívida foi quitada — mesmo vocabulário das
// formas de pagamento normais do caixa, pra não confundir ninguém.
const FORMAS_QUITACAO = ['Dinheiro', 'Pix', 'Crédito', 'Débito', 'Voucher', 'Desconto em folha'];
function formaQuitacaoValida(forma) {
  return FORMAS_QUITACAO.includes(forma) ? forma : null;
}

// Registra o recebimento no caixa onde ele aconteceu (aparece no fechamento: "Receita"
// e "Resumo Receitas"). Só quando veio de um caixa aberto e é dinheiro de verdade —
// "Desconto em folha" (RH) não passa pelo caixa.
const FORMAS_DE_CAIXA = ['Dinheiro', 'Pix', 'Crédito', 'Débito', 'Voucher'];
async function registrarRecebimento(conn, { padaria_id, caixa_id, documento, valor, forma }) {
  if (!caixa_id || !(valor > 0) || !FORMAS_DE_CAIXA.includes(forma)) return;
  const [[caixa]] = await conn.query(
    `SELECT id FROM caixas WHERE id = ? AND padaria_id = ? AND status = 'aberto'`, [caixa_id, padaria_id]);
  if (!caixa) return;
  const [[cliente]] = await conn.query(
    `SELECT nome FROM clientes_faturado WHERE padaria_id = ? AND cnpj = ?`, [padaria_id, documento]);
  await conn.query(
    `INSERT INTO recebimentos_faturado (padaria_id, caixa_id, cliente_documento, cliente_nome, valor, forma_pagamento) VALUES (?,?,?,?,?,?)`,
    [padaria_id, caixa.id, documento, cliente?.nome || null, Math.round(valor * 100) / 100, forma]);
}

// Quanto ainda falta pagar nas linhas que um "dar baixa" vai quitar (pra registrar o valor recebido).
async function emAbertoAntesDaBaixa(padaria_id, documento, filtroExtra = '', params = []) {
  const [[{ falta }]] = await db.query(
    `SELECT COALESCE(SUM(cp.valor - cp.valor_pago), 0) AS falta
     FROM comanda_pagamentos cp JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.padaria_id = ? AND cp.forma_pagamento = 'Faturado' AND cp.cliente_documento = ? AND cp.quitado_em IS NULL ${filtroExtra}`,
    [padaria_id, documento, ...params]);
  return parseFloat(falta) || 0;
}

// "Dar baixa" — marca tudo que esse documento deve como quitado (pagou a fatura),
// zerando o saldo devedor e liberando o limite de novo.
exports.liquidar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const docLimpo = limparDoc(req.params.documento);
  // Forma é opcional: o caixa sempre informa (entra no fechamento); na retaguarda
  // (Financeiro) dá pra dar baixa sem saber como o cliente pagou, como era antes.
  const forma = req.body.forma ? formaQuitacaoValida(req.body.forma) : null;
  if (req.body.forma && !forma) return res.status(400).json({ erro: 'Forma de pagamento inválida.' });
  if (req.body.caixa_id && !forma) return res.status(400).json({ erro: 'No caixa, informe a forma de pagamento (Dinheiro, Pix, Crédito, Débito ou Voucher).' });
  const valor = await emAbertoAntesDaBaixa(padaria_id, docLimpo);
  const [r] = await db.query(
    `UPDATE comanda_pagamentos cp JOIN comandas c ON c.id = cp.comanda_id
     SET cp.quitado_em = NOW(), cp.valor_pago = cp.valor, cp.forma_quitacao = ?
     WHERE c.padaria_id = ? AND cp.forma_pagamento = 'Faturado' AND cp.cliente_documento = ? AND cp.quitado_em IS NULL`,
    [forma, padaria_id, docLimpo]
  );
  if (r.affectedRows) await registrarRecebimento(db, { padaria_id, caixa_id: req.body.caixa_id, documento: docLimpo, valor, forma });
  res.json({ ok: true, quitados: r.affectedRows });
};

// Dá baixa só nas comandas escolhidas (extrato com checkbox) — diferente do "Dar
// baixa" normal, que quita tudo de uma vez, isso deixa o resto em aberto.
exports.liquidarSelecionados = async (req, res) => {
  const padaria_id = req.padaria.id;
  const docLimpo = limparDoc(req.params.documento);
  // Forma é opcional: o caixa sempre informa (entra no fechamento); na retaguarda
  // (Financeiro) dá pra dar baixa sem saber como o cliente pagou, como era antes.
  const forma = req.body.forma ? formaQuitacaoValida(req.body.forma) : null;
  if (req.body.forma && !forma) return res.status(400).json({ erro: 'Forma de pagamento inválida.' });
  if (req.body.caixa_id && !forma) return res.status(400).json({ erro: 'No caixa, informe a forma de pagamento (Dinheiro, Pix, Crédito, Débito ou Voucher).' });
  const comandaIds = (req.body.comanda_ids || []).map(Number).filter(n => Number.isInteger(n) && n > 0);
  if (!comandaIds.length) return res.status(400).json({ erro: 'Nenhuma comanda selecionada.' });
  const valor = await emAbertoAntesDaBaixa(padaria_id, docLimpo, 'AND cp.comanda_id IN (?)', [comandaIds]);
  const [r] = await db.query(
    `UPDATE comanda_pagamentos cp JOIN comandas c ON c.id = cp.comanda_id
     SET cp.quitado_em = NOW(), cp.valor_pago = cp.valor, cp.forma_quitacao = ?
     WHERE c.padaria_id = ? AND cp.forma_pagamento = 'Faturado' AND cp.cliente_documento = ?
       AND cp.quitado_em IS NULL AND cp.comanda_id IN (?)`,
    [forma, padaria_id, docLimpo, comandaIds]
  );
  if (r.affectedRows) await registrarRecebimento(db, { padaria_id, caixa_id: req.body.caixa_id, documento: docLimpo, valor, forma });
  res.json({ ok: true, quitados: r.affectedRows });
};

// Dá baixa SÓ no que já foi "lançado" (fechado em "Fechar e cobrar") — deixa de fora
// qualquer consumo novo que o cliente tenha feito depois do lançamento e ainda não
// pagou, ao contrário do "Dar baixa" normal que zera tudo que estiver em aberto.
exports.liquidarLancados = async (req, res) => {
  const padaria_id = req.padaria.id;
  const docLimpo = limparDoc(req.params.documento);
  // Forma é opcional: o caixa sempre informa (entra no fechamento); na retaguarda
  // (Financeiro) dá pra dar baixa sem saber como o cliente pagou, como era antes.
  const forma = req.body.forma ? formaQuitacaoValida(req.body.forma) : null;
  if (req.body.forma && !forma) return res.status(400).json({ erro: 'Forma de pagamento inválida.' });
  if (req.body.caixa_id && !forma) return res.status(400).json({ erro: 'No caixa, informe a forma de pagamento (Dinheiro, Pix, Crédito, Débito ou Voucher).' });
  const valor = await emAbertoAntesDaBaixa(padaria_id, docLimpo, 'AND cp.lancado_em IS NOT NULL');
  const [r] = await db.query(
    `UPDATE comanda_pagamentos cp JOIN comandas c ON c.id = cp.comanda_id
     SET cp.quitado_em = NOW(), cp.valor_pago = cp.valor, cp.forma_quitacao = ?
     WHERE c.padaria_id = ? AND cp.forma_pagamento = 'Faturado' AND cp.cliente_documento = ?
       AND cp.quitado_em IS NULL AND cp.lancado_em IS NOT NULL`,
    [forma, padaria_id, docLimpo]
  );
  if (r.affectedRows) await registrarRecebimento(db, { padaria_id, caixa_id: req.body.caixa_id, documento: docLimpo, valor, forma });
  res.json({ ok: true, quitados: r.affectedRows });
};

// Pagamento parcial — abate um valor qualquer do saldo devedor (ex: deve R$200, paga
// R$100) sem precisar escolher quais compras específicas quitar. Aplica o valor nas
// compras mais antigas primeiro (FIFO): quita inteira a mais velha, depois a próxima,
// até o valor acabar — a última que sobrar fica parcialmente paga (valor_pago < valor),
// sem marcar quitado_em, então continua contando como "em aberto" pelo resto.
// Trava as linhas com FOR UPDATE: se dois caixas tentarem baixar o mesmo cliente ao
// mesmo tempo, um espera o outro terminar, em vez de os dois abaterem do mesmo saldo
// e sobrar menos dinheiro recebido do que realmente entrou.
exports.pagarParcial = async (req, res) => {
  const padaria_id = req.padaria.id;
  const docLimpo = limparDoc(req.params.documento);
  const valorPago = parseFloat(req.body.valor);
  if (!(valorPago > 0)) return res.status(400).json({ erro: 'Informe um valor maior que zero.' });
  // Forma é opcional: o caixa sempre informa (entra no fechamento); na retaguarda
  // (Financeiro) dá pra dar baixa sem saber como o cliente pagou, como era antes.
  const forma = req.body.forma ? formaQuitacaoValida(req.body.forma) : null;
  if (req.body.forma && !forma) return res.status(400).json({ erro: 'Forma de pagamento inválida.' });
  if (req.body.caixa_id && !forma) return res.status(400).json({ erro: 'No caixa, informe a forma de pagamento (Dinheiro, Pix, Crédito, Débito ou Voucher).' });

  const conn = await db.getConnection();
  try {
    await conn.beginTransaction();
    const [abertas] = await conn.query(
      `SELECT cp.id, cp.valor, cp.valor_pago
       FROM comanda_pagamentos cp JOIN comandas c ON c.id = cp.comanda_id
       WHERE c.padaria_id = ? AND cp.forma_pagamento = 'Faturado' AND cp.cliente_documento = ?
         AND cp.quitado_em IS NULL
       ORDER BY c.fechada_em ASC, cp.id ASC  -- desempate: duas vendas no mesmo segundo
       FOR UPDATE`,
      [padaria_id, docLimpo]
    );
    const saldoAntes = abertas.reduce((s, l) => s + (parseFloat(l.valor) - parseFloat(l.valor_pago)), 0);
    if (!abertas.length) { await conn.rollback(); return res.status(400).json({ erro: 'Esse cliente não tem nada em aberto pra pagar.' }); }
    if (valorPago > saldoAntes + 0.01) {
      await conn.rollback();
      return res.status(400).json({ erro: `O valor digitado (${valorPago.toFixed(2)}) é maior que o saldo devedor (${saldoAntes.toFixed(2)}).` });
    }

    let restante = valorPago;
    for (const linha of abertas) {
      if (restante <= 0) break;
      const faltaNessaLinha = parseFloat(linha.valor) - parseFloat(linha.valor_pago);
      const abateAqui = Math.min(restante, faltaNessaLinha);
      const novoValorPago = parseFloat(linha.valor_pago) + abateAqui;
      const quitouTudo = novoValorPago >= parseFloat(linha.valor) - 0.005;
      await conn.query(
        `UPDATE comanda_pagamentos SET valor_pago = ?, quitado_em = ?, forma_quitacao = ? WHERE id = ?`,
        [novoValorPago, quitouTudo ? new Date() : null, quitouTudo ? forma : null, linha.id]
      );
      restante -= abateAqui;
    }
    await registrarRecebimento(conn, { padaria_id, caixa_id: req.body.caixa_id, documento: docLimpo, valor: valorPago, forma });
    await conn.commit();
    const saldoDepois = saldoAntes - valorPago;
    res.json({ ok: true, saldoAntes, valorPago, saldoDepois });
  } catch (e) {
    await conn.rollback().catch(() => {});
    console.error('Erro ao pagar parcial do Faturado:', e);
    res.status(500).json({ erro: 'Erro interno ao registrar o pagamento.' });
  } finally {
    conn.release();
  }
};

exports.formatarCnpj = formatarCnpj;
