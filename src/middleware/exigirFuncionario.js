// Trava uma ação pra só quem fez login como funcionário com o papel certo (ex: só
// "gerente" pode excluir item / cancelar comanda; "caixa" ou "gerente" pode abrir caixa).
// Usa um token PRÓPRIO do funcionário (não o token principal da padaria) — vem no
// header 'X-Func-Token', enviado pelo tablet depois que a pessoa digita o PIN dela.
const jwt = require('jsonwebtoken');

function exigirFuncionario(papeisPermitidos) {
  return (req, res, next) => {
    const token = req.headers['x-func-token'];
    if (!token) {
      return res.status(401).json({ erro: 'Ação exige login de funcionário.', precisa_login_funcionario: true });
    }
    try {
      const secret = process.env.JWT_SECRET;
      const payload = jwt.verify(token, secret, { algorithms: ['HS256'] });
      if (payload.tipo !== 'atendente' || payload.padaria_id !== req.padaria.id) {
        return res.status(401).json({ erro: 'Login de funcionário inválido.', precisa_login_funcionario: true });
      }
      if (!papeisPermitidos.includes(payload.role)) {
        return res.status(403).json({ erro: `Essa ação exige o papel: ${papeisPermitidos.join(' ou ')}.` });
      }
      req.funcionario = payload;
      next();
    } catch {
      return res.status(401).json({ erro: 'Login de funcionário expirado.', precisa_login_funcionario: true });
    }
  };
}

module.exports = exigirFuncionario;
