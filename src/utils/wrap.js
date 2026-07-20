// Wrapper para capturar erros em rotas async sem try/catch repetido
const wrap = fn => async (req, res, next) => {
  try { await fn(req, res, next); }
  catch (e) { console.error(e); res.status(500).json({ erro: 'Erro interno do servidor.' }); }
};

module.exports = wrap;
