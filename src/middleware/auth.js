const jwt = require('jsonwebtoken');
const db  = require('../database/connection');

module.exports = async (req, res, next) => {
  const header = req.headers.authorization || '';
  const token  = header.startsWith('Bearer ') ? header.slice(7) : null;

  if (!token) return res.status(401).json({ erro: 'Token não fornecido.' });

  const secret = process.env.JWT_SECRET;
  if (!secret) {
    console.error('FATAL: JWT_SECRET não definido.');
    return res.status(500).json({ erro: 'Erro de configuração do servidor.' });
  }

  try {
    const payload = jwt.verify(token, secret);
    if (payload.tipo === 'reset') return res.status(401).json({ erro: 'Token inválido.' });

    // Admin nunca é bloqueado
    if (payload.role !== 'admin') {
      const [[padaria]] = await db.query(
        'SELECT plano, plano_expira_em, plano_bloqueado, ativo FROM padarias WHERE id = ?',
        [payload.id]
      );
      if (!padaria || !padaria.ativo) return res.status(401).json({ erro: 'Conta inativa.' });
      if (padaria.plano_bloqueado) return res.status(402).json({ erro: 'plano_expirado', plano: padaria.plano });
      if (padaria.plano_expira_em && new Date(padaria.plano_expira_em) < new Date()) {
        await db.query('UPDATE padarias SET plano_bloqueado = 1 WHERE id = ?', [payload.id]);
        return res.status(402).json({ erro: 'plano_expirado', plano: padaria.plano });
      }
    }

    req.padaria = payload;
    next();
  } catch {
    res.status(401).json({ erro: 'Token inválido ou expirado.' });
  }
};
