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
    `SELECT cliente_documento, COALESCE(SUM(valor), 0) AS saldo
     FROM comanda_pagamentos
     WHERE forma_pagamento = 'Faturado' AND quitado_em IS NULL AND cliente_documento IS NOT NULL
     GROUP BY cliente_documento`
  );
  const saldoPorDoc = Object.fromEntries(saldos.map(s => [s.cliente_documento, parseFloat(s.saldo)]));
  res.json(clientes.map(c => ({ ...c, saldo_devedor: saldoPorDoc[c.cnpj] || 0 })));
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

  // Limite só existe (e só pode ser mudado) pra funcionário — CNPJ (empresa) continua sem limite.
  const [[atual]] = await db.query(
    `SELECT tipo FROM clientes_faturado WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]
  );
  if (!atual) return res.status(404).json({ erro: 'Cliente não encontrado.' });

  if (atual.tipo === 'funcionario' && req.body.limite !== undefined && req.body.limite !== null && req.body.limite !== '') {
    const limite = parseFloat(req.body.limite);
    if (isNaN(limite) || limite < 0) return res.status(400).json({ erro: 'Limite inválido.' });
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
    `SELECT COALESCE(SUM(cp.valor), 0) AS saldo
     FROM comanda_pagamentos cp JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.padaria_id = ? AND cp.forma_pagamento = 'Faturado' AND cp.quitado_em IS NULL AND cp.cliente_documento = ?`,
    [padaria_id, docLimpo]
  );
  const saldoDevedor = parseFloat(saldo);
  const limite = cliente.tipo === 'funcionario' ? parseFloat(cliente.limite || 0) : null;
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
    `SELECT c.identificador, c.fechada_em, cp.valor, cp.quitado_em
     FROM comanda_pagamentos cp JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.padaria_id = ? AND cp.forma_pagamento = 'Faturado' AND cp.cliente_documento = ?
     ORDER BY c.fechada_em DESC`,
    [padaria_id, docLimpo]
  );
  res.json(linhas);
};

// "Dar baixa" — marca tudo que esse documento deve como quitado (pagou a fatura),
// zerando o saldo devedor e liberando o limite de novo.
exports.liquidar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const docLimpo = limparDoc(req.params.documento);
  const [r] = await db.query(
    `UPDATE comanda_pagamentos cp JOIN comandas c ON c.id = cp.comanda_id
     SET cp.quitado_em = NOW()
     WHERE c.padaria_id = ? AND cp.forma_pagamento = 'Faturado' AND cp.cliente_documento = ? AND cp.quitado_em IS NULL`,
    [padaria_id, docLimpo]
  );
  res.json({ ok: true, quitados: r.affectedRows });
};

exports.formatarCnpj = formatarCnpj;
