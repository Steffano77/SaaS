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

router.post('/categorias', auth, async (req, res) => {
  const db = require('../database/connection');
  const { nome } = req.body;
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });
  const [r] = await db.query('INSERT INTO categorias (padaria_id, nome) VALUES (?,?)', [req.padaria.id, nome]);
  res.status(201).json({ id: r.insertId, nome });
});

router.delete('/categorias/:id', auth, async (req, res) => {
  const db = require('../database/connection');
  await db.query('DELETE FROM categorias WHERE id = ? AND padaria_id = ?', [req.params.id, req.padaria.id]);
  res.json({ ok: true });
});

module.exports = router;
