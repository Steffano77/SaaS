const router = require('express').Router();
const auth   = require('../middleware/auth');
const multer = require('multer');
const upload = multer({ dest: '/tmp/panificapro/' });

// Wrapper para capturar erros em rotas async inline
const wrap = fn => async (req, res, next) => {
  try { await fn(req, res, next); }
  catch (e) { console.error(e); res.status(500).json({ erro: 'Erro interno do servidor.' }); }
};

const authCtrl  = require('../controllers/authController');
const prodCtrl  = require('../controllers/produtosController');
const movCtrl   = require('../controllers/movimentacoesController');
const syncCtrl   = require('../controllers/syncController');
const importCtrl = require('../controllers/importController');
const dadosCtrl  = require('../controllers/dadosController');

const senhaCtrl = require('../controllers/senhaController');

// Auth
router.post('/auth/registrar',     authCtrl.registrar);
router.post('/auth/login',         authCtrl.login);
router.get('/auth/perfil',         auth, authCtrl.perfil);
router.post('/auth/esqueci-senha', senhaCtrl.esqueceuSenha);
router.post('/auth/redefinir-senha', senhaCtrl.redefinirSenha);

router.put('/auth/padaria', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const { nome } = req.body;
  if (!nome || nome.trim().length < 2) return res.status(400).json({ erro: 'Nome muito curto.' });
  await db.query('UPDATE padarias SET nome = ? WHERE id = ?', [nome.trim(), req.padaria.id]);
  res.json({ ok: true, nome: nome.trim() });
}));

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

// Importação genérica
router.post('/sync/preview',   auth, upload.single('arquivo'), importCtrl.preview);
router.post('/sync/generico',  auth, upload.single('arquivo'), importCtrl.importarGenerico);

// Fornecedores
router.get('/fornecedores', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query('SELECT * FROM fornecedores WHERE padaria_id = ? AND ativo = 1 ORDER BY nome', [req.padaria.id]);
  res.json(rows);
}));

router.post('/fornecedores', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const { nome, contato, telefone, email } = req.body;
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });
  const [r] = await db.query(
    'INSERT INTO fornecedores (padaria_id, nome, contato, telefone, email) VALUES (?,?,?,?,?)',
    [req.padaria.id, nome, contato || null, telefone || null, email || null]
  );
  res.status(201).json({ id: r.insertId, nome });
}));

router.put('/fornecedores/:id', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const { nome, contato, telefone, email } = req.body;
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });
  await db.query(
    'UPDATE fornecedores SET nome=?, contato=?, telefone=?, email=? WHERE id=? AND padaria_id=?',
    [nome, contato||null, telefone||null, email||null, req.params.id, req.padaria.id]
  );
  res.json({ ok: true });
}));

router.delete('/fornecedores/:id', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  await db.query('UPDATE fornecedores SET ativo = 0 WHERE id = ? AND padaria_id = ?', [req.params.id, req.padaria.id]);
  res.json({ ok: true });
}));

// Relatórios
router.get('/relatorios/movs-semana', auth, wrap(async (req, res) => {
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
}));

router.get('/relatorios/top-produtos', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query(`
    SELECT nome, ROUND(estoque_atual * custo_unitario, 2) AS valor
    FROM produtos
    WHERE padaria_id = ? AND ativo = 1 AND estoque_atual > 0 AND custo_unitario > 0
    ORDER BY valor DESC
    LIMIT 5`, [req.padaria.id]);
  res.json(rows);
}));

router.get('/relatorios/valor-categorias', auth, wrap(async (req, res) => {
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
}));

router.get('/relatorios/mes', auth, wrap(async (req, res) => {
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
}));

// Saídas últimos 30 dias
router.get('/saidas/recentes', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query(`
    SELECT m.id, m.quantidade, m.custo_unit, m.valor_total, m.data, m.observacao,
           p.nome AS produto, p.unidade
    FROM movimentacoes m
    JOIN produtos p ON p.id = m.produto_id
    WHERE m.padaria_id = ? AND m.tipo = 'saida'
      AND m.data >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
    ORDER BY m.data DESC, m.id DESC
    LIMIT 200`, [req.padaria.id]);
  res.json(rows);
}));

// Compras recentes (últimos 30 dias) — pedidos já recebidos
router.get('/compras/recentes', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query(`
    SELECT pc.id AS pedido_id, pc.recebido_em AS data,
           COALESCE(f.nome, pc.observacao) AS fornecedor,
           pc.total,
           GROUP_CONCAT(p.nome ORDER BY p.nome SEPARATOR ', ') AS produtos
    FROM pedidos_compra pc
    LEFT JOIN fornecedores f ON f.id = pc.fornecedor_id
    JOIN itens_pedido ip ON ip.pedido_id = pc.id
    JOIN produtos p ON p.id = ip.produto_id
    WHERE pc.padaria_id = ?
      AND pc.status = 'recebido'
      AND pc.recebido_em >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
    GROUP BY pc.id
    ORDER BY pc.recebido_em DESC
    LIMIT 50`, [req.padaria.id]);
  res.json(rows);
}));

// Pedidos pendentes de recebimento
router.get('/compras/pedidos', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [pedidos] = await db.query(`
    SELECT pc.id, pc.criado_em, pc.observacao, pc.total, pc.fornecedor_id,
           COALESCE(f.nome, pc.observacao) AS fornecedor,
           f.telefone AS fornecedor_tel
    FROM pedidos_compra pc
    LEFT JOIN fornecedores f ON f.id = pc.fornecedor_id
    WHERE pc.padaria_id = ? AND pc.status = 'pendente'
    ORDER BY pc.criado_em DESC`, [req.padaria.id]);

  const ids = pedidos.map(p => p.id);
  if (!ids.length) return res.json([]);

  const [itens] = await db.query(`
    SELECT ip.pedido_id, ip.produto_id, ip.quantidade, ip.custo_unitario,
           p.nome AS produto, p.unidade
    FROM itens_pedido ip
    JOIN produtos p ON p.id = ip.produto_id
    WHERE ip.pedido_id IN (${ids.map(() => '?').join(',')})`, ids);

  const mapa = {};
  pedidos.forEach(p => { mapa[p.id] = { ...p, itens: [] }; });
  itens.forEach(i => { if (mapa[i.pedido_id]) mapa[i.pedido_id].itens.push(i); });

  res.json(Object.values(mapa));
}));

// Criar pedido de compra (sem atualizar estoque)
router.post('/compras/pedidos', auth, async (req, res) => {
  const db = require('../database/connection');
  const { fornecedor_id, observacao, data, itens } = req.body;
  if (!itens || !itens.length) return res.status(400).json({ erro: 'Informe ao menos um item.' });

  const conn = await db.getConnection();
  try {
    await conn.beginTransaction();

    // Criar produtos novos se necessário
    const itensResolvidos = [];
    for (const item of itens) {
      let prodId = item.produto_id;
      if (item.isNovo) {
        const [r] = await conn.query(
          'INSERT INTO produtos (padaria_id, nome, unidade, estoque_minimo, custo_unitario) VALUES (?,?,?,?,?)',
          [req.padaria.id, item.nome, item.unidade || 'un', item.minimo || 0, item.custo || 0]
        );
        prodId = r.insertId;
      } else if (item.unidade) {
        await conn.query(
          'UPDATE produtos SET unidade = ? WHERE id = ? AND padaria_id = ?',
          [item.unidade, prodId, req.padaria.id]
        );
      }
      itensResolvidos.push({ ...item, produto_id: prodId });
    }

    const total = itensResolvidos.reduce((s, i) => s + (i.quantidade * (i.custo || 0)), 0);

    const [rp] = await conn.query(
      `INSERT INTO pedidos_compra (padaria_id, fornecedor_id, status, total, observacao, criado_em)
       VALUES (?, ?, 'pendente', ?, ?, ?)`,
      [req.padaria.id, fornecedor_id || null, total, observacao || null, data || new Date().toISOString().slice(0, 10)]
    );
    const pedidoId = rp.insertId;

    for (const item of itensResolvidos) {
      await conn.query(
        'INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, custo_unitario) VALUES (?,?,?,?)',
        [pedidoId, item.produto_id, item.quantidade, item.custo || 0]
      );
    }

    await conn.commit();
    res.status(201).json({ id: pedidoId });
  } catch (e) {
    await conn.rollback();
    console.error('Erro ao criar pedido:', e);
    res.status(500).json({ erro: 'Erro ao criar pedido.' });
  } finally {
    conn.release();
  }
});

// Confirmar recebimento — só aqui atualiza o estoque
router.post('/compras/pedidos/:id/receber', auth, async (req, res) => {
  const db = require('../database/connection');
  const pedidoId = req.params.id;

  const conn = await db.getConnection();
  try {
    await conn.beginTransaction();

    const [[pedido]] = await conn.query(
      `SELECT id FROM pedidos_compra WHERE id = ? AND padaria_id = ? AND status = 'pendente'`,
      [pedidoId, req.padaria.id]
    );
    if (!pedido) { await conn.rollback(); conn.release(); return res.status(404).json({ erro: 'Pedido não encontrado ou já recebido.' }); }

    const [itens] = await conn.query(
      'SELECT ip.produto_id, ip.quantidade, ip.custo_unitario FROM itens_pedido ip WHERE ip.pedido_id = ?',
      [pedidoId]
    );

    for (const item of itens) {
      // Atualiza estoque
      await conn.query(
        `UPDATE produtos SET
           estoque_atual = estoque_atual + ?,
           custo_unitario = IF(? > 0, ?, custo_unitario)
         WHERE id = ? AND padaria_id = ?`,
        [item.quantidade, item.custo_unitario, item.custo_unitario, item.produto_id, req.padaria.id]
      );
      // Registra movimentação para histórico
      await conn.query(
        `INSERT INTO movimentacoes (padaria_id, produto_id, tipo, quantidade, custo_unit, observacao, data)
         VALUES (?, ?, 'entrada', ?, ?, ?, NOW())`,
        [req.padaria.id, item.produto_id, item.quantidade, item.custo_unitario,
         `Pedido #${pedidoId}`]
      );
    }

    await conn.query(
      `UPDATE pedidos_compra SET status = 'recebido', recebido_em = NOW() WHERE id = ?`,
      [pedidoId]
    );

    await conn.commit();
    res.json({ ok: true });
  } catch (e) {
    await conn.rollback();
    console.error('Erro ao confirmar recebimento:', e);
    res.status(500).json({ erro: 'Erro ao confirmar recebimento.' });
  } finally {
    conn.release();
  }
});

// Cancelar pedido pendente
router.post('/compras/pedidos/:id/cancelar', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  await db.query(
    `UPDATE pedidos_compra SET status = 'cancelado' WHERE id = ? AND padaria_id = ? AND status = 'pendente'`,
    [req.params.id, req.padaria.id]
  );
  res.json({ ok: true });
}));

// Limpar todos os dados
router.delete('/dados/limpar', auth, dadosCtrl.limparTudo);

// Categorias
router.get('/categorias', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query('SELECT * FROM categorias WHERE padaria_id = ? ORDER BY nome', [req.padaria.id]);
  res.json(rows);
}));

router.post('/categorias', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const { nome } = req.body;
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });
  const [r] = await db.query('INSERT INTO categorias (padaria_id, nome) VALUES (?,?)', [req.padaria.id, nome]);
  res.status(201).json({ id: r.insertId, nome });
}));

router.delete('/categorias/:id', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  await db.query('DELETE FROM categorias WHERE id = ? AND padaria_id = ?', [req.params.id, req.padaria.id]);
  res.json({ ok: true });
}));

// ── Admin ──────────────────────────────────────────────────────────────────
const authAdmin = (req, res, next) => {
  if (req.padaria.role !== 'admin') return res.status(403).json({ erro: 'Acesso restrito.' });
  next();
};

router.get('/admin/padarias', auth, authAdmin, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query(`
    SELECT id, nome, email, plano, role, ativo, criado_em,
      (SELECT COUNT(*) FROM produtos WHERE padaria_id = padarias.id) AS total_produtos
    FROM padarias ORDER BY criado_em DESC`);
  res.json(rows);
}));

router.patch('/admin/padarias/:id/ativo', auth, authAdmin, wrap(async (req, res) => {
  const db = require('../database/connection');
  const { ativo } = req.body;
  if (Number(req.params.id) === req.padaria.id) return res.status(400).json({ erro: 'Não pode alterar a si mesmo.' });
  await db.query('UPDATE padarias SET ativo = ? WHERE id = ?', [ativo ? 1 : 0, req.params.id]);
  res.json({ ok: true });
}));

router.delete('/admin/padarias/:id', auth, authAdmin, wrap(async (req, res) => {
  const db = require('../database/connection');
  if (Number(req.params.id) === req.padaria.id) return res.status(400).json({ erro: 'Não pode apagar a si mesmo.' });
  await db.query('DELETE FROM padarias WHERE id = ?', [req.params.id]);
  res.json({ ok: true });
}));

module.exports = router;
