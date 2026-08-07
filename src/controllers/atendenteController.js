const bcrypt = require('bcryptjs');
const db = require('../database/connection');

exports.listar = async (req, res) => {
  const [rows] = await db.query(
    `SELECT id, nome, ativo, criado_em, (pin_hash IS NOT NULL) AS tem_pin
     FROM atendentes WHERE padaria_id = ? AND ativo = 1 ORDER BY nome`,
    [req.padaria.id]
  );
  res.json(rows);
};

exports.criar = async (req, res) => {
  const nome = String(req.body.nome || '').trim();
  const pin = String(req.body.pin || '').trim();
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });
  if (!/^\d{4}$/.test(pin)) return res.status(400).json({ erro: 'O PIN precisa ter exatamente 4 números.' });

  const pin_hash = await bcrypt.hash(pin, 10);
  const [r] = await db.query(
    `INSERT INTO atendentes (padaria_id, nome, pin_hash) VALUES (?, ?, ?)`,
    [req.padaria.id, nome, pin_hash]
  );
  res.status(201).json({ id: r.insertId, nome });
};

// Confere o PIN de um atendente (usado antes de abrir caixa em nome dele)
exports.verificarPin = async (req, res) => {
  const padaria_id = req.padaria.id;
  const pin = String(req.body.pin || '').trim();
  const [[atendente]] = await db.query(
    `SELECT id, pin_hash FROM atendentes WHERE id = ? AND padaria_id = ? AND ativo = 1`,
    [req.params.id, padaria_id]
  );
  if (!atendente || !atendente.pin_hash) return res.status(404).json({ erro: 'Atendente não encontrado.' });

  const ok = await bcrypt.compare(pin, atendente.pin_hash);
  if (!ok) return res.status(401).json({ erro: 'PIN incorreto.' });
  res.json({ ok: true });
};

exports.remover = async (req, res) => {
  await db.query(
    `UPDATE atendentes SET ativo = 0 WHERE id = ? AND padaria_id = ?`,
    [req.params.id, req.padaria.id]
  );
  res.json({ ok: true });
};
