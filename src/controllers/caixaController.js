const bcrypt = require('bcryptjs');
const db = require('../database/connection');

// Lista todos os caixas abertos da padaria (pode haver mais de um — um por tablet/aparelho)
exports.abertos = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [caixas] = await db.query(
    `SELECT * FROM caixas WHERE padaria_id = ? AND status = 'aberto' ORDER BY aberto_em`,
    [padaria_id]
  );
  res.json(caixas);
};

// Detalhe de um caixa específico (com resumo), usado pelo tablet que já sabe qual é o seu
exports.buscar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [[caixa]] = await db.query(
    `SELECT * FROM caixas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado.' });
  const resumo = await montarResumoCaixa(caixa);
  res.json({ ...caixa, resumo });
};

// Histórico de caixas já fechados
exports.historico = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [caixas] = await db.query(
    `SELECT * FROM caixas WHERE padaria_id = ? AND status = 'fechado' ORDER BY fechado_em DESC LIMIT 30`,
    [padaria_id]
  );
  res.json(caixas);
};

exports.abrir = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { valor_abertura, atendente_id, pin, observacao } = req.body;
  const nome = String(req.body.nome || '').trim() || 'Caixa 1';

  let atendenteNome = null;
  if (atendente_id) {
    const [[atendente]] = await db.query(
      `SELECT id, nome, pin_hash FROM atendentes WHERE id = ? AND padaria_id = ? AND ativo = 1`,
      [atendente_id, padaria_id]
    );
    if (!atendente) return res.status(404).json({ erro: 'Atendente não encontrado.' });
    if (atendente.pin_hash) {
      const ok = await bcrypt.compare(String(pin || ''), atendente.pin_hash);
      if (!ok) return res.status(401).json({ erro: 'PIN incorreto.' });
    }
    atendenteNome = atendente.nome;
  }

  const [r] = await db.query(
    `INSERT INTO caixas (padaria_id, nome, atendente, valor_abertura, observacao) VALUES (?,?,?,?,?)`,
    [padaria_id, nome, atendenteNome, parseFloat(valor_abertura) || 0, observacao || null]
  );
  res.status(201).json({ id: r.insertId, nome, atendente: atendenteNome });
};

async function montarResumoCaixa(caixa) {
  const [porForma] = await db.query(
    `SELECT cp.forma_pagamento, COALESCE(SUM(cp.valor), 0) AS total
     FROM comanda_pagamentos cp
     JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.caixa_id = ?
     GROUP BY cp.forma_pagamento`,
    [caixa.id]
  );
  const [[totalVendas]] = await db.query(
    `SELECT COALESCE(SUM(cp.valor), 0) AS total
     FROM comanda_pagamentos cp
     JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.caixa_id = ?`,
    [caixa.id]
  );
  const [[totalDinheiro]] = await db.query(
    `SELECT COALESCE(SUM(cp.valor), 0) AS total
     FROM comanda_pagamentos cp
     JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.caixa_id = ? AND cp.forma_pagamento = 'Dinheiro'`,
    [caixa.id]
  );
  const [movimentos] = await db.query(
    `SELECT * FROM caixa_movimentos WHERE caixa_id = ? ORDER BY criado_em`, [caixa.id]
  );
  const totalSangrias = movimentos.filter(m => m.tipo === 'sangria').reduce((s, m) => s + parseFloat(m.valor), 0);
  const totalSuprimentos = movimentos.filter(m => m.tipo === 'suprimento').reduce((s, m) => s + parseFloat(m.valor), 0);

  const [[ajustes]] = await db.query(
    `SELECT COALESCE(SUM(desconto), 0) AS totalDescontos, COALESCE(SUM(acrescimo), 0) AS totalAcrescimos
     FROM comandas WHERE caixa_id = ? AND status = 'fechada'`,
    [caixa.id]
  );

  const esperadoEmDinheiro = parseFloat(caixa.valor_abertura) + parseFloat(totalDinheiro.total)
    + totalSuprimentos - totalSangrias;

  return {
    porForma,
    totalVendas: parseFloat(totalVendas.total),
    totalDinheiro: parseFloat(totalDinheiro.total),
    totalDescontos: parseFloat(ajustes.totalDescontos),
    totalAcrescimos: parseFloat(ajustes.totalAcrescimos),
    totalSangrias, totalSuprimentos,
    movimentos,
    esperadoEmDinheiro,
  };
}

exports.fechar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { valor_fechamento, observacao } = req.body;
  const [[caixa]] = await db.query(
    `SELECT * FROM caixas WHERE id = ? AND padaria_id = ? AND status = 'aberto'`,
    [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado ou já fechado.' });

  const resumo = await montarResumoCaixa(caixa);

  await db.query(
    `UPDATE caixas SET status = 'fechado', valor_fechamento = ?, valor_esperado = ?, observacao = COALESCE(?, observacao), fechado_em = NOW()
     WHERE id = ?`,
    [parseFloat(valor_fechamento) || 0, resumo.esperadoEmDinheiro, observacao || null, caixa.id]
  );

  res.json({
    ok: true,
    esperado: resumo.esperadoEmDinheiro,
    informado: parseFloat(valor_fechamento) || 0,
    diferenca: (parseFloat(valor_fechamento) || 0) - resumo.esperadoEmDinheiro,
    resumo,
  });
};

exports.sangria = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { valor, observacao } = req.body;
  if (!valor || valor <= 0) return res.status(400).json({ erro: 'Valor inválido.' });

  const [[caixa]] = await db.query(
    `SELECT id FROM caixas WHERE id = ? AND padaria_id = ? AND status = 'aberto'`, [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado ou já fechado.' });

  await db.query(
    `INSERT INTO caixa_movimentos (caixa_id, tipo, valor, observacao) VALUES (?, 'sangria', ?, ?)`,
    [caixa.id, valor, observacao || null]
  );
  res.status(201).json({ ok: true });
};

exports.suprimento = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { valor, observacao } = req.body;
  if (!valor || valor <= 0) return res.status(400).json({ erro: 'Valor inválido.' });

  const [[caixa]] = await db.query(
    `SELECT id FROM caixas WHERE id = ? AND padaria_id = ? AND status = 'aberto'`, [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado ou já fechado.' });

  await db.query(
    `INSERT INTO caixa_movimentos (caixa_id, tipo, valor, observacao) VALUES (?, 'suprimento', ?, ?)`,
    [caixa.id, valor, observacao || null]
  );
  res.status(201).json({ ok: true });
};
