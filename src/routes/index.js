const router = require('express').Router();
const auth   = require('../middleware/auth');
const multer = require('multer');
const upload = multer({ dest: '/tmp/panificapro/' });

const authCtrl  = require('../controllers/authController');
const prodCtrl  = require('../controllers/produtosController');
const movCtrl   = require('../controllers/movimentacoesController');
const syncCtrl  = require('../controllers/syncController');
const dadosCtrl = require('../controllers/dadosController');

// Auth
router.post('/auth/registrar', authCtrl.registrar);
router.post('/auth/login',     authCtrl.login);
router.get('/auth/perfil',     auth, authCtrl.perfil);

// Dashboard
router.get('/dashboard', auth, prodCtrl.dashboard);

// Produtos
router.get('/produtos',       auth, prodCtrl.listar);
router.get('/produtos/:id',   auth, prodCtrl.buscar);
router.post('/produtos',      auth, prodCtrl.criar);
router.put('/produtos/:id',   auth, prodCtrl.atualizar);
router.delete('/produtos/:id',auth, prodCtrl.remover);

// Movimentações
router.get('/movimentacoes',  auth, movCtrl.listar);
router.post('/movimentacoes', auth, movCtrl.registrar);

// Sync Saurus
router.post('/sync/saurus', auth, upload.single('arquivo'), syncCtrl.importarSaurus);

// Limpar todos os dados
router.delete('/dados/limpar', auth, dadosCtrl.limparTudo);

// Categorias
router.get('/categorias', auth, async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query('SELECT * FROM categorias WHERE padaria_id = ? ORDER BY nome', [req.padaria.id]);
  res.json(rows);
});

module.exports = router;
