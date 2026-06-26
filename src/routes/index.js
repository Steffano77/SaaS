const router = require('express').Router();
const auth   = require('../middleware/auth');
const multer = require('multer');
const upload = multer({ dest: '/tmp/panificapro/' });

const authCtrl  = require('../controllers/authController');
const prodCtrl  = require('../controllers/produtosController');
const movCtrl   = require('../controllers/movimentacoesController');
const syncCtrl  = require('../controllers/syncController');
const dadosCtrl = require('../controllers/dadosController');

const senhaCtrl = require('../controllers/senhaController');

// Auth
router.post('/auth/registrar',     authCtrl.registrar);
router.post('/auth/login',         authCtrl.login);
router.get('/auth/perfil',         auth, authCtrl.perfil);
router.post('/auth/esqueci-senha', senhaCtrl.esqueceuSenha);
router.post('/auth/redefinir-senha', senhaCtrl.redefinirSenha);

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

// Fornecedores
router.get('/fornecedores', auth, async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query('SELECT * FROM fornecedores WHERE padaria_id = ? AND ativo = 1 ORDER BY nome', [req.padaria.id]);
  res.json(rows);
});

router.post('/fornecedores', auth, async (req, res) => {
  const db = require('../database/connection');
  const { nome, contato, telefone, email } = req.body;
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });
  const [r] = await db.query(
    'INSERT INTO fornecedores (padaria_id, nome, contato, telefone, email) VALUES (?,?,?,?,?)',
    [req.padaria.id, nome, contato || null, telefone || null, email || null]
  );
  res.status(201).json({ id: r.insertId, nome });
});

router.delete('/fornecedores/:id', auth, async (req, res) => {
  const db = require('../database/connection');
  await db.query('UPDATE fornecedores SET ativo = 0 WHERE id = ? AND padaria_id = ?', [req.params.id, req.padaria.id]);
  res.json({ ok: true });
});

// Relatórios
router.get('/relatorios/movs-semana', auth, async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query(`
    SELECT
      DATE_FORMAT(data, '%d/%m') AS dia,
      COALESCE(SUM(CASE WHEN tipo IN ('entrada','sync_saurus') THEN quantidade ELSE 0 END), 0) AS entradas,
      COALESCE(SUM(CASE WHEN tipo = 'saida' THEN quantidade ELSE 0 END), 0) AS saidas
    FROM movimentacoes
    WHERE padaria_id = ?
      AND data >= DATE_SUB(CURDATE(), INTERVAL 6 DAY)
    GROUP BY DATE(data), DATE_FORMAT(data, '%d/%m')
    ORDER BY DATE(data)`, [req.padaria.id]);
  res.json(rows);
});

router.get('/relatorios/valor-categorias', auth, async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query(`
    SELECT COALESCE(c.nome, 'Sem categoria') AS categoria,
           SUM(p.estoque_atual * p.custo_unitario) AS valor
    FROM produtos p
    LEFT JOIN categorias c ON c.id = p.categoria_id
    WHERE p.padaria_id = ? AND p.ativo = 1
    GROUP BY c.nome
    ORDER BY valor DESC
    LIMIT 8`, [req.padaria.id]);
  res.json(rows);
});

router.get('/relatorios/mes', auth, async (req, res) => {
  const db = require('../database/connection');
  const mes = req.query.mes || new Date().toISOString().slice(0, 7);
  const [kpis] = await db.query(`
    SELECT
      COALESCE(SUM(CASE WHEN tipo IN ('entrada','sync_saurus') THEN valor_total ELSE 0 END), 0) AS total_entradas,
      COALESCE(SUM(CASE WHEN tipo = 'saida' THEN valor_total ELSE 0 END), 0) AS total_saidas,
      COUNT(*) AS qtd_movs,
      COUNT(DISTINCT produto_id) AS prods_distintos
    FROM movimentacoes
    WHERE padaria_id = ? AND DATE_FORMAT(data, '%Y-%m') = ?`, [req.padaria.id, mes]);

  const [movs] = await db.query(`
    SELECT m.tipo, m.quantidade, m.custo_unit, m.valor_total, m.data, p.nome AS produto
    FROM movimentacoes m
    JOIN produtos p ON p.id = m.produto_id
    WHERE m.padaria_id = ? AND DATE_FORMAT(m.data, '%Y-%m') = ?
    ORDER BY m.data DESC
    LIMIT 200`, [req.padaria.id, mes]);

  res.json({ ...kpis[0], movs });
});

// Compras recentes (últimos 30 dias)
router.get('/compras/recentes', auth, async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query(`
    SELECT m.id, m.quantidade, m.custo_unit, m.valor_total, m.data,
           p.nome AS produto, p.unidade,
           m.observacao AS fornecedor
    FROM movimentacoes m
    JOIN produtos p ON p.id = m.produto_id
    WHERE m.padaria_id = ?
      AND m.tipo = 'entrada'
      AND m.data >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
    ORDER BY m.data DESC, m.id DESC
    LIMIT 100`, [req.padaria.id]);
  res.json(rows);
});

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
