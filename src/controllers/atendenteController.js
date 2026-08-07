const db = require('../database/connection');

exports.listar = async (req, res) => {
  const [rows] = await db.query(
    `SELECT * FROM atendentes WHERE padaria_id = ? AND ativo = 1 ORDER BY nome`,
    [req.padaria.id]
  );
  res.json(rows);
};

exports.criar = async (req, res) => {
  const nome = String(req.body.nome || '').trim();
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });
  const [r] = await db.query(
    `INSERT INTO atendentes (padaria_id, nome) VALUES (?, ?)`,
    [req.padaria.id, nome]
  );
  res.status(201).json({ id: r.insertId, nome });
};

exports.remover = async (req, res) => {
  await db.query(
    `UPDATE atendentes SET ativo = 0 WHERE id = ? AND padaria_id = ?`,
    [req.params.id, req.padaria.id]
  );
  res.json({ ok: true });
};
