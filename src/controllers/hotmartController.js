const bcrypt = require('bcryptjs');
const crypto = require('crypto');
const db     = require('../database/connection');

const PLANOS = {
  P106748886H: 'essencial',
  F106749321O: 'pro',
  R106749586T: 'premium',
};

function gerarSenha() {
  return crypto.randomBytes(4).toString('hex'); // ex: a3f2b1c0
}

async function enviarBoasVindas({ to, nome, senha, plano, appUrl }) {
  if (!process.env.RESEND_API_KEY) {
    console.log(`[DEV] Boas-vindas para ${to} | senha: ${senha}`);
    return;
  }
  const { Resend } = require('resend');
  const resend = new Resend(process.env.RESEND_API_KEY);
  const planoLabel = plano.charAt(0).toUpperCase() + plano.slice(1);
  await resend.emails.send({
    from: process.env.EMAIL_FROM || 'PanificaPro <onboarding@resend.dev>',
    to,
    subject: `Bem-vindo ao PanificaPro! Seu acesso está pronto 🎉`,
    html: `
      <div style="font-family:Inter,sans-serif;max-width:520px;margin:0 auto;padding:32px;background:#f8fafc;border-radius:12px;">
        <div style="text-align:center;margin-bottom:24px;">
          <img src="${appUrl}/img/logosem%20fundo.png" width="72" style="margin-bottom:8px;"/>
          <h1 style="color:#1e3a5f;font-size:22px;margin:0;">Bem-vindo ao PanificaPro!</h1>
        </div>

        <p style="color:#334155;">Olá, <strong>${nome}</strong>!</p>
        <p style="color:#334155;">Seu pagamento foi confirmado e sua conta do Plano <strong>${planoLabel}</strong> já está ativa.</p>

        <div style="background:#fff;border:1px solid #e2e8f0;border-radius:10px;padding:20px;margin:24px 0;">
          <p style="margin:0 0 8px;color:#64748b;font-size:13px;text-transform:uppercase;letter-spacing:.05em;">Seus dados de acesso</p>
          <p style="margin:4px 0;color:#1e3a5f;"><strong>E-mail:</strong> ${to}</p>
          <p style="margin:4px 0;color:#1e3a5f;"><strong>Senha:</strong> <span style="font-family:monospace;background:#f1f5f9;padding:2px 8px;border-radius:4px;">${senha}</span></p>
        </div>

        <div style="text-align:center;margin:28px 0;">
          <a href="${appUrl}" style="display:inline-block;background:#f97316;color:#fff;padding:14px 32px;border-radius:10px;text-decoration:none;font-weight:700;font-size:16px;">Acessar o PanificaPro</a>
        </div>

        <p style="color:#64748b;font-size:13px;">Recomendamos que você troque a senha após o primeiro acesso.</p>
        <p style="color:#94a3b8;font-size:12px;margin-top:24px;border-top:1px solid #e2e8f0;padding-top:16px;">
          PanificaPro — Gestão inteligente para padarias<br/>
          Dúvidas? Responda este e-mail.
        </p>
      </div>
    `,
  });
}

exports.webhook = async (req, res) => {
  try {
    const body = req.body;
    const event = body?.event || body?.data?.event;

    // Só processa compra aprovada
    if (event !== 'PURCHASE_APPROVED' && event !== 'PURCHASE_COMPLETE') {
      return res.status(200).json({ ok: true, ignorado: event });
    }

    const purchase = body?.data?.purchase || body?.purchase || {};
    const buyer    = body?.data?.buyer    || body?.buyer    || {};
    const product  = body?.data?.product  || body?.product  || {};

    const productCode = String(product.id || product.ucode || '');
    const plano = PLANOS[productCode];

    const email = String(buyer.email || '').trim().toLowerCase();
    const nome  = String(buyer.name  || buyer.full_name || 'Cliente').trim();

    if (!email) {
      console.warn('[Hotmart] Email do comprador ausente.');
      return res.status(200).json({ ok: true, aviso: 'email ausente' });
    }

    if (!plano) {
      console.warn('[Hotmart] Produto não mapeado:', productCode);
      return res.status(200).json({ ok: true, aviso: `produto não mapeado: ${productCode}` });
    }

    // Verifica se já tem conta com esse email
    const [existente] = await db.query('SELECT id, plano FROM padarias WHERE email = ?', [email]);

    const appUrl = process.env.APP_URL || 'https://panificapro-erp.onrender.com';

    if (existente.length) {
      // Cliente já tem conta — atualiza o plano
      const expira = new Date();
      expira.setDate(expira.getDate() + 30);
      await db.query(
        'UPDATE padarias SET plano = ?, plano_expira_em = ?, ativo = 1 WHERE id = ?',
        [plano, expira.toISOString().slice(0, 10), existente[0].id]
      );
      console.log(`[Hotmart] Plano atualizado para ${email}: ${plano}`);
      return res.status(200).json({ ok: true, acao: 'plano_atualizado' });
    }

    // Cria conta nova
    const senha = gerarSenha();
    const hash  = await bcrypt.hash(senha, 10);
    const expira = new Date();
    expira.setDate(expira.getDate() + 30);

    await db.query(
      'INSERT INTO padarias (nome, email, senha_hash, plano, plano_expira_em, ativo) VALUES (?, ?, ?, ?, ?, 1)',
      [nome, email, hash, plano, expira.toISOString().slice(0, 10)]
    );

    console.log(`[Hotmart] Conta criada para ${email} — plano ${plano}`);

    await enviarBoasVindas({ to: email, nome, senha, plano, appUrl });

    return res.status(200).json({ ok: true, acao: 'conta_criada' });
  } catch (e) {
    console.error('[Hotmart] Erro no webhook:', e);
    return res.status(500).json({ erro: 'Erro interno.' });
  }
};
