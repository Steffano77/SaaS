const bcrypt = require('bcryptjs');
const jwt    = require('jsonwebtoken');
const db     = require('../database/connection');

const SECRET = process.env.JWT_SECRET;
if (!SECRET) throw new Error('JWT_SECRET não configurado nas variáveis de ambiente.');

exports.registrar = async (req, res) => {
  try {
    const nome   = String(req.body.nome   || '').trim().slice(0, 120);
    const email  = String(req.body.email  || '').trim().toLowerCase().slice(0, 120);
    const senha  = String(req.body.senha  || '');
    const codigo = String(req.body.codigo || '').trim().toUpperCase();

    if (!nome || !email || !senha || !codigo)
      return res.status(400).json({ erro: 'Nome, email, senha e código de ativação são obrigatórios.' });
    if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email))
      return res.status(400).json({ erro: 'Email inválido.' });
    if (senha.length < 6)
      return res.status(400).json({ erro: 'Senha deve ter pelo menos 6 caracteres.' });

    // Valida código de ativação
    const [codigos] = await db.query(
      'SELECT * FROM codigos_ativacao WHERE codigo = ? AND usado = 0',
      [codigo]
    );
    if (!codigos.length)
      return res.status(400).json({ erro: 'Código de ativação inválido ou já utilizado.' });

    const codigoObj = codigos[0];

    const [existe] = await db.query('SELECT id FROM padarias WHERE email = ?', [email]);
    if (existe.length) return res.status(409).json({ erro: 'Email já cadastrado.' });

    const hash = await bcrypt.hash(senha, 10);
    const [result] = await db.query(
      'INSERT INTO padarias (nome, email, senha_hash, plano) VALUES (?, ?, ?, ?)',
      [nome, email, hash, codigoObj.plano]
    );

    // Marca código como usado
    await db.query(
      'UPDATE codigos_ativacao SET usado = 1, padaria_id = ?, usado_em = NOW() WHERE id = ?',
      [result.insertId, codigoObj.id]
    );

    const token = jwt.sign({ id: result.insertId, nome, email }, SECRET, { expiresIn: '7d' });
    res.status(201).json({ token, padaria: { id: result.insertId, nome, email, plano: codigoObj.plano } });
  } catch (e) {
    console.error('Erro ao registrar:', e);
    res.status(500).json({ erro: 'Erro interno ao criar conta.' });
  }
};

exports.login = async (req, res) => {
  try {
    const email = String(req.body.email || '').trim().toLowerCase().slice(0, 120);
    const senha = String(req.body.senha || '');
    if (!email || !senha) return res.status(400).json({ erro: 'Email e senha obrigatórios.' });

    const [rows] = await db.query('SELECT * FROM padarias WHERE email = ? AND ativo = 1', [email]);
    if (!rows.length) return res.status(401).json({ erro: 'Credenciais inválidas.' });

    const padaria = rows[0];
    const ok = await bcrypt.compare(senha, padaria.senha_hash);
    if (!ok) return res.status(401).json({ erro: 'Credenciais inválidas.' });

    const token = jwt.sign(
      { id: padaria.id, nome: padaria.nome, email: padaria.email, role: padaria.role || 'user' },
      SECRET,
      { expiresIn: '7d' }
    );
    res.json({ token, padaria: { id: padaria.id, nome: padaria.nome, email: padaria.email, plano: padaria.plano, role: padaria.role || 'user' } });
  } catch (e) {
    console.error('Erro ao fazer login:', e);
    res.status(500).json({ erro: 'Erro interno ao fazer login.' });
  }
};

exports.perfil = async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT id, nome, email, plano, role, criado_em FROM padarias WHERE id = ?',
      [req.padaria.id]
    );
    res.json(rows[0]);
  } catch (e) {
    console.error('Erro ao buscar perfil:', e);
    res.status(500).json({ erro: 'Erro interno.' });
  }
};
