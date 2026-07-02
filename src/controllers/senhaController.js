const jwt        = require('jsonwebtoken');
const bcrypt     = require('bcryptjs');
const nodemailer = require('nodemailer');
const db         = require('../database/connection');

function getSecret() {
  const s = process.env.JWT_SECRET;
  if (!s) throw new Error('JWT_SECRET não definido nas variáveis de ambiente.');
  return s;
}

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

  const [rows] = await db.query(
    'SELECT id, nome FROM padarias WHERE email = ? AND ativo = 1', [email]
  );
  // Sempre retorna 200 para não revelar se email existe
  if (!rows.length) return res.json({ ok: true });

  const padaria = rows[0];

  // Grava token hash + expiração no banco (invalida qualquer reset anterior)
  const token  = jwt.sign({ id: padaria.id, tipo: 'reset' }, getSecret(), { expiresIn: '1h' });
  const expires = new Date(Date.now() + 60 * 60 * 1000); // 1 hora
  await db.query(
    'UPDATE padarias SET reset_token = ?, reset_expires = ? WHERE id = ?',
    [token, expires, padaria.id]
  );

  const appUrl = process.env.APP_URL || 'https://panificapro-erp.onrender.com';
  const link   = `${appUrl}/redefinir-senha?token=${token}`;

  if (process.env.SMTP_USER) {
    try {
      const transport = criarTransporte();
      await transport.sendMail({
        from:    `"PanificaPro" <${process.env.SMTP_USER}>`,
        to:      email,
        subject: 'Redefinição de senha — PanificaPro',
        html: `
          <div style="font-family:Inter,sans-serif;max-width:480px;margin:0 auto;padding:32px;">
            <img src="${appUrl}/img/logosem%20fundo.png" width="64" style="margin-bottom:16px;"/>
            <h2 style="color:#1e3a5f;">Olá, ${padaria.nome}!</h2>
            <p style="color:#475569;">Recebemos uma solicitação para redefinir sua senha.</p>
            <a href="${link}" style="display:inline-block;margin:20px 0;background:#f97316;color:#fff;padding:14px 28px;border-radius:10px;text-decoration:none;font-weight:600;">Redefinir minha senha</a>
            <p style="color:#94a3b8;font-size:13px;">Link válido por 1 hora. Se não foi você, ignore este email.</p>
          </div>`
      });
    } catch (e) {
      console.error('Erro ao enviar email de recuperação:', e.message);
      return res.status(500).json({ erro: 'Não foi possível enviar o email. Tente novamente.' });
    }
  } else {
    // SMTP não configurado — loga o link no console para desenvolvimento
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
    payload = jwt.verify(token, getSecret());
  } catch {
    return res.status(400).json({ erro: 'Link inválido ou expirado.' });
  }

  if (payload.tipo !== 'reset') return res.status(400).json({ erro: 'Token inválido.' });

  // Valida token contra o banco (impede reuso após reset bem-sucedido)
  const [rows] = await db.query(
    'SELECT id FROM padarias WHERE id = ? AND reset_token = ? AND reset_expires > NOW()',
    [payload.id, token]
  );
  if (!rows.length) return res.status(400).json({ erro: 'Link inválido, já utilizado ou expirado.' });

  const hash = await bcrypt.hash(senha, 10);
  // Atualiza senha e invalida o token
  await db.query(
    'UPDATE padarias SET senha_hash = ?, reset_token = NULL, reset_expires = NULL WHERE id = ?',
    [hash, payload.id]
  );

  res.json({ ok: true });
};
