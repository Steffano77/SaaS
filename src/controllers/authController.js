const bcrypt = require('bcryptjs');
const jwt    = require('jsonwebtoken');
const crypto = require('crypto');
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
    if (senha.length < 8)
      return res.status(400).json({ erro: 'Senha deve ter pelo menos 8 caracteres.' });

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
    // Duração vem do código: dias (trial) tem prioridade; senão meses (assinatura)
    const expira = new Date();
    if (codigoObj.dias) {
      expira.setDate(expira.getDate() + Math.min(Math.max(Number(codigoObj.dias), 1), 1095));
    } else {
      expira.setMonth(expira.getMonth() + Math.min(Math.max(Number(codigoObj.meses) || 1, 1), 36));
    }
    const expiraStr = expira.toISOString().slice(0, 10);
    const [result] = await db.query(
      'INSERT INTO padarias (nome, email, senha_hash, plano, plano_expira_em) VALUES (?, ?, ?, ?, ?)',
      [nome, email, hash, codigoObj.plano, expiraStr]
    );

    // Marca código como usado
    await db.query(
      'UPDATE codigos_ativacao SET usado = 1, padaria_id = ?, usado_em = NOW() WHERE id = ?',
      [result.insertId, codigoObj.id]
    );

    const token = jwt.sign({ jti: crypto.randomUUID(), id: result.insertId, nome, email }, SECRET, { expiresIn: '7d' });
    res.status(201).json({ token, padaria: { id: result.insertId, nome, email, plano: codigoObj.plano, plano_expira_em: expiraStr } });
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
      { jti: crypto.randomUUID(), id: padaria.id, nome: padaria.nome, email: padaria.email, role: padaria.role || 'user' },
      SECRET,
      { expiresIn: '7d' }
    );
    res.json({ token, padaria: { id: padaria.id, nome: padaria.nome, email: padaria.email, plano: padaria.plano, role: padaria.role || 'user', plano_expira_em: padaria.plano_expira_em } });
  } catch (e) {
    console.error('Erro ao fazer login:', e);
    res.status(500).json({ erro: 'Erro interno ao fazer login.' });
  }
};

// Login pra aparelho "fixado" numa padaria — só nome + PIN do atendente,
// sem senha de dono. O padaria_id vem do próprio aparelho (guardado localmente
// depois de configurar em "⚙️ Este aparelho"), não é escolhido livremente aqui.
exports.loginCaixa = async (req, res) => {
  try {
    const padaria_id = parseInt(req.body.padaria_id, 10);
    const nome = String(req.body.nome || '').trim();
    const pin = String(req.body.pin || '');
    if (!padaria_id || !nome || !pin) return res.status(400).json({ erro: 'Nome e PIN são obrigatórios.' });

    const [[padaria]] = await db.query('SELECT * FROM padarias WHERE id = ? AND ativo = 1', [padaria_id]);
    if (!padaria) return res.status(404).json({ erro: 'Padaria não encontrada ou inativa.' });

    const [[atendente]] = await db.query(
      'SELECT * FROM atendentes WHERE padaria_id = ? AND nome = ? AND ativo = 1',
      [padaria_id, nome]
    );
    if (!atendente || !atendente.pin_hash) return res.status(401).json({ erro: 'Nome ou PIN incorretos.' });
    const ok = await bcrypt.compare(pin, atendente.pin_hash);
    if (!ok) return res.status(401).json({ erro: 'Nome ou PIN incorretos.' });

    // Mesmo formato de token do login normal de dono — funciona em todas as rotas
    // que já existem hoje. A diferença fica só na hora de mostrar a interface:
    // o frontend restringe o menu com base em atendente_role.
    const token = jwt.sign(
      {
        jti: crypto.randomUUID(), id: padaria.id, nome: padaria.nome, email: padaria.email,
        role: padaria.role || 'user', atendente_nome: atendente.nome, atendente_role: atendente.role,
      },
      SECRET,
      { expiresIn: '16h' }
    );
    res.json({
      token,
      padaria: { id: padaria.id, nome: padaria.nome, email: padaria.email, plano: padaria.plano, role: padaria.role || 'user', plano_expira_em: padaria.plano_expira_em },
      atendente: { nome: atendente.nome, role: atendente.role },
    });
  } catch (e) {
    console.error('Erro no login de caixa:', e);
    res.status(500).json({ erro: 'Erro interno.' });
  }
};

exports.perfil = async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT id, nome, email, plano, role, plano_expira_em, criado_em FROM padarias WHERE id = ?',
      [req.padaria.id]
    );
    res.json(rows[0]);
  } catch (e) {
    console.error('Erro ao buscar perfil:', e);
    res.status(500).json({ erro: 'Erro interno.' });
  }
};
