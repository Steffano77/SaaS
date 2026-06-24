const jwt        = require('jsonwebtoken');
const bcrypt     = require('bcryptjs');
const nodemailer = require('nodemailer');
const db         = require('../database/connection');

const SECRET = process.env.JWT_SECRET || 'panificapro_secret';

function criarTransporte() {
  return nodemailer.createTransport({
    host:   process.env.SMTP_HOST || 'smtp.gmail.com',
    port:   parseInt(process.env.SMTP_PORT || '587'),
    secure: false,
    auth: {
      user: process.env.SMTP_USER,
      pass: process.env.SMTP_PASS,
    },
  });
}

exports.esqueceuSenha = async (req, res) => {
  const email = String(req.body.email || '').trim().toLowerCase();
  if (!email) return res.status(400).json({ erro: 'Email obrigatório.' });

  const [rows] = await db.query('SELECT id, nome FROM padarias WHERE email = ? AND ativo = 1', [email]);
  // Sempre retorna 200 para não revelar se email existe
  if (!rows.length) return res.json({ ok: true });

  const padaria = rows[0];
  const token = jwt.sign({ id: padaria.id, tipo: 'reset' }, SECRET, { expiresIn: '1h' });
  const link  = `${process.env.APP_URL || 'https://panificapro-erp.onrender.com'}/redefinir-senha?token=${token}`;

  if (process.env.SMTP_USER) {
    try {
      const transport = criarTransporte();
      await transport.sendMail({
        from:    `"PanificaPro" <${process.env.SMTP_USER}>`,
        to:      email,
        subject: 'Redefinição de senha — PanificaPro',
        html: `
          <div style="font-family:Inter,sans-serif;max-width:480px;margin:0 auto;padding:32px;">
            <img src="${process.env.APP_URL || 'https://panificapro-erp.onrender.com'}/img/logosem%20fundo.png" width="64" style="margin-bottom:16px;"/>
            <h2 style="color:#1e3a5f;">Olá, ${padaria.nome}!</h2>
            <p style="color:#475569;">Recebemos uma solicitação para redefinir sua senha.</p>
            <a href="${link}" style="display:inline-block;margin:20px 0;background:#f97316;color:#fff;padding:14px 28px;border-radius:10px;text-decoration:none;font-weight:600;">Redefinir minha senha</a>
            <p style="color:#94a3b8;font-size:13px;">Link válido por 1 hora. Se não foi você, ignore este email.</p>
          </div>`
      });
    } catch(e) {
      console.error('Erro ao enviar email:', e.message);
    }
  } else {
    // SMTP não configurado — loga o link no console para teste
    console.log(`[DEV] Link de reset para ${email}: ${link}`);
  }

  res.json({ ok: true });
};

exports.redefinirSenha = async (req, res) => {
  const { token, senha } = req.body;
  if (!token || !senha) return res.status(400).json({ erro: 'Token e senha obrigatórios.' });
  if (senha.length < 6) return res.status(400).json({ erro: 'Senha deve ter pelo menos 6 caracteres.' });

  let payload;
  try {
    payload = jwt.verify(token, SECRET);
  } catch {
    return res.status(400).json({ erro: 'Link inválido ou expirado.' });
  }

  if (payload.tipo !== 'reset') return res.status(400).json({ erro: 'Token inválido.' });

  const hash = await bcrypt.hash(senha, 10);
  await db.query('UPDATE padarias SET senha_hash = ? WHERE id = ?', [hash, payload.id]);
  res.json({ ok: true });
};
