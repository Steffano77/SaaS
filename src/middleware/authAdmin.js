const authAdmin = (req, res, next) => {
  if (req.padaria.role !== 'admin') return res.status(403).json({ erro: 'Acesso restrito.' });
  next();
};

module.exports = authAdmin;
