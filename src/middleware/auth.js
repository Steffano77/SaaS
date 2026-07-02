const jwt = require('jsonwebtoken');

module.exports = (req, res, next) => {
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
    // Impede tokens de reset de serem usados como tokens de sessão
    if (payload.tipo === 'reset') {
      return res.status(401).json({ erro: 'Token inválido.' });
    }
    req.padaria = payload;
    next();
  } catch {
    res.status(401).json({ erro: 'Token inválido ou expirado.' });
  }
};
