const bcrypt = require('bcryptjs');
const jwt    = require('jsonwebtoken');
const db     = require('../database/connection');

const SECRET = process.env.JWT_SECRET || 'panificapro_secret';

exports.registrar = async (req, res) => {
  const { nome, email, senha } = req.body;
  if (!nome || !email || !senha)
    return res.status(400).json({ erro: 'Nome, email e senha são obrigatórios.' });

  const [existe] = await db.query('SELECT id FROM padarias WHERE email = ?', [email]);
  if (existe.length) return res.status(409).json({ erro: 'Email já cadastrado.' });

  const hash = await bcrypt.hash(senha, 10);
  const [result] = await db.query(
    'INSERT INTO padarias (nome, email, senha_hash) VALUES (?, ?, ?)',
    [nome, email, hash]
  );

  // Categorias padrão
  const cats = ['Farinhas','Gorduras','Açúcares','Laticínios','Ovos','Embalagens','Outros'];
  for (const c of cats) {
    await db.query('INSERT INTO categorias (padaria_id, nome) VALUES (?, ?)', [result.insertId, c]);
  }

  const token = jwt.sign({ id: result.insertId, nome, email }, SECRET, { expiresIn: '30d' });
  res.status(201).json({ token, padaria: { id: result.insertId, nome, email } });
};

exports.login = async (req, res) => {
  const { email, senha } = req.body;
  if (!email || !senha) return res.status(400).json({ erro: 'Email e senha obrigatórios.' });

  const [rows] = await db.query('SELECT * FROM padarias WHERE email = ? AND ativo = 1', [email]);
  if (!rows.length) return res.status(401).json({ erro: 'Credenciais inválidas.' });

  const padaria = rows[0];
  const ok = await bcrypt.compare(senha, padaria.senha_hash);
  if (!ok) return res.status(401).json({ erro: 'Credenciais inválidas.' });

  const token = jwt.sign(
    { id: padaria.id, nome: padaria.nome, email: padaria.email },
    SECRET,
    { expiresIn: '30d' }
  );
  res.json({ token, padaria: { id: padaria.id, nome: padaria.nome, email: padaria.email, plano: padaria.plano } });
};

exports.perfil = async (req, res) => {
  const [rows] = await db.query(
    'SELECT id, nome, email, plano, criado_em FROM padarias WHERE id = ?',
    [req.padaria.id]
  );
  res.json(rows[0]);
};
