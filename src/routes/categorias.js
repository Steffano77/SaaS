const router = require('express').Router();
const auth   = require('../middleware/auth');
const wrap   = require('../utils/wrap');
const db     = require('../database/connection');

router.get('/', auth, wrap(async (req, res) => {
  const [rows] = await db.query(
    'SELECT * FROM categorias WHERE padaria_id = ? ORDER BY nome',
    [req.padaria.id]
  );
  res.json(rows);
}));

router.post('/', auth, wrap(async (req, res) => {
  const { nome } = req.body;
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });
  const [r] = await db.query(
    'INSERT INTO categorias (padaria_id, nome) VALUES (?,?)',
    [req.padaria.id, nome]
  );
  res.status(201).json({ id: r.insertId, nome });
}));

router.delete('/:id', auth, wrap(async (req, res) => {
  await db.query(
    'DELETE FROM categorias WHERE id = ? AND padaria_id = ?',
    [req.params.id, req.padaria.id]
  );
  res.json({ ok: true });
}));

module.exports = router;
