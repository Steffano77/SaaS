const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../database/connection');

const PAPEIS_VALIDOS = ['atendente', 'caixa', 'gerente'];

exports.listar = async (req, res) => {
  const [rows] = await db.query(
    `SELECT id, nome, role, ativo, criado_em, (pin_hash IS NOT NULL) AS tem_pin
     FROM atendentes WHERE padaria_id = ? AND ativo = 1 ORDER BY nome`,
    [req.padaria.id]
  );
  res.json(rows);
};

exports.criar = async (req, res) => {
  const nome = String(req.body.nome || '').trim();
  const pin = String(req.body.pin || '').trim();
  const role = PAPEIS_VALIDOS.includes(req.body.role) ? req.body.role : 'atendente';
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });
  if (!/^\d{4}$/.test(pin)) return res.status(400).json({ erro: 'O PIN precisa ter exatamente 4 números.' });

  const pin_hash = await bcrypt.hash(pin, 10);
  const [r] = await db.query(
    `INSERT INTO atendentes (padaria_id, nome, pin_hash, role) VALUES (?, ?, ?, ?)`,
    [req.padaria.id, nome, pin_hash, role]
  );
  res.status(201).json({ id: r.insertId, nome, role });
};

// Troca o papel de um atendente já cadastrado
exports.trocarPapel = async (req, res) => {
  const role = req.body.role;
  if (!PAPEIS_VALIDOS.includes(role)) return res.status(400).json({ erro: 'Papel inválido.' });
  await db.query(`UPDATE atendentes SET role = ? WHERE id = ? AND padaria_id = ?`, [role, req.params.id, req.padaria.id]);
  res.json({ ok: true });
};

// Login por PIN — identifica QUEM está usando o tablet agora e devolve um token
// próprio (separado do token da padaria) usado pra liberar ações restritas por papel
// (excluir item, cancelar comanda, abrir caixa).
exports.loginPin = async (req, res) => {
  const padaria_id = req.padaria.id;
  const pin = String(req.body.pin || '').trim();
  if (!/^\d{4}$/.test(pin)) return res.status(400).json({ erro: 'PIN inválido.' });

  const [atendentes] = await db.query(
    `SELECT id, nome, role, pin_hash FROM atendentes WHERE padaria_id = ? AND ativo = 1 AND pin_hash IS NOT NULL`,
    [padaria_id]
  );
  let encontrado = null;
  for (const a of atendentes) {
    if (await bcrypt.compare(pin, a.pin_hash)) { encontrado = a; break; }
  }
  if (!encontrado) return res.status(401).json({ erro: 'PIN incorreto.' });

  const secret = process.env.JWT_SECRET;
  const token = jwt.sign(
    { tipo: 'atendente', id: encontrado.id, padaria_id, nome: encontrado.nome, role: encontrado.role },
    secret,
    { expiresIn: '12h' }
  );
  res.json({ ok: true, token, nome: encontrado.nome, role: encontrado.role });
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
