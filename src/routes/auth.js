const router  = require('express').Router();
const auth    = require('../middleware/auth');
const wrap    = require('../utils/wrap');
const db      = require('../database/connection');

const authCtrl  = require('../controllers/authController');
const senhaCtrl = require('../controllers/senhaController');

router.post('/registrar',       authCtrl.registrar);
router.post('/login',           authCtrl.login);
router.get('/perfil',     auth, authCtrl.perfil);
router.post('/esqueci-senha',   senhaCtrl.esqueceuSenha);
router.post('/redefinir-senha', senhaCtrl.redefinirSenha);

router.put('/padaria', auth, wrap(async (req, res) => {
  const { nome } = req.body;
  if (!nome || nome.trim().length < 2) return res.status(400).json({ erro: 'Nome muito curto.' });
  await db.query('UPDATE padarias SET nome = ? WHERE id = ?', [nome.trim(), req.padaria.id]);
  res.json({ ok: true, nome: nome.trim() });
}));

router.get('/verificar-codigo/:codigo', wrap(async (req, res) => {
  const codigo = String(req.params.codigo || '').trim().toUpperCase();
  const [rows] = await db.query('SELECT plano FROM codigos_ativacao WHERE codigo = ? AND usado = 0', [codigo]);
  if (!rows.length) return res.status(404).json({ valido: false });
  res.json({ valido: true, plano: rows[0].plano });
}));

module.exports = router;
