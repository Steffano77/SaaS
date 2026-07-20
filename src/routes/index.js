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

const senhaCtrl   = require('../controllers/senhaController');
const hotmartCtrl = require('../controllers/hotmartController');

// Webhook Hotmart (sem auth)
router.post('/hotmart/webhook', hotmartCtrl.webhook);

// Rota de teste do webhook (apenas em desenvolvimento ou com token admin)
router.post('/hotmart/teste', wrap(async (req, res) => {
  const { email, nome, plano } = req.body;
  if (!email || !nome || !plano) return res.status(400).json({ erro: 'email, nome e plano obrigatórios.' });
  const planosValidos = ['essencial', 'pro', 'premium'];
  if (!planosValidos.includes(plano)) return res.status(400).json({ erro: 'Plano inválido.' });

  // Simula payload da Hotmart para a rota real
  req.body = {
    event: 'PURCHASE_APPROVED',
    data: {
      purchase: {},
      buyer: { email, name: nome },
      product: { id: plano === 'essencial' ? 'P106748886H' : plano === 'pro' ? 'F106749321O' : 'R106749586T' },
    },
  };
  return hotmartCtrl.webhook(req, res);
}));

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
  const [ano, m] = mes.split('-').map(Number);
  const mesAnterior = m === 1
    ? `${ano - 1}-12`
    : `${ano}-${String(m - 1).padStart(2, '0')}`;

  const q = (sql, params) => db.query(sql, params)
    .then(([rows]) => rows)
    .catch(e => { console.error('[rel] ERRO:', e.message); return []; });

  const [kpisRows, kpisAntRows, movs, top, categorias, alertas, compras] = await Promise.all([
    q(`SELECT
        COALESCE(SUM(CASE WHEN tipo IN ('entrada','sync_saurus') THEN valor_total ELSE 0 END), 0) AS total_entradas,
        COALESCE(SUM(CASE WHEN tipo = 'saida' THEN valor_total ELSE 0 END), 0) AS total_saidas,
        COUNT(*) AS qtd_movs,
        COUNT(DISTINCT produto_id) AS prods_distintos
       FROM movimentacoes
       WHERE padaria_id = ? AND DATE_FORMAT(data, '%Y-%m') = ?`,
      [req.padaria.id, mes]),

    q(`SELECT
        COALESCE(SUM(CASE WHEN tipo IN ('entrada','sync_saurus') THEN valor_total ELSE 0 END), 0) AS total_entradas,
        COALESCE(SUM(CASE WHEN tipo = 'saida' THEN valor_total ELSE 0 END), 0) AS total_saidas,
        COUNT(*) AS qtd_movs
       FROM movimentacoes
       WHERE padaria_id = ? AND DATE_FORMAT(data, '%Y-%m') = ?`,
      [req.padaria.id, mesAnterior]),

    q(`SELECT m.tipo, m.quantidade, m.custo_unit, m.valor_total, m.data,
              COALESCE(p.nome, '[Produto removido]') AS produto,
              COALESCE(c.nome, 'Sem categoria') AS categoria
       FROM movimentacoes m
       LEFT JOIN produtos p ON p.id = m.produto_id
       LEFT JOIN categorias c ON c.id = p.categoria_id
       WHERE m.padaria_id = ? AND DATE_FORMAT(m.data, '%Y-%m') = ?
       ORDER BY m.data DESC LIMIT 500`,
      [req.padaria.id, mes]),

    q(`SELECT m.produto_id,
              COALESCE(MAX(p.nome), '[Produto removido]') AS nome,
              COALESCE(MAX(p.unidade), 'un') AS unidade,
              COUNT(*) AS qtd_movs,
              SUM(CASE WHEN m.tipo IN ('entrada','sync_saurus') THEN m.quantidade ELSE 0 END) AS entradas,
              SUM(CASE WHEN m.tipo = 'saida' THEN m.quantidade ELSE 0 END) AS saidas
       FROM movimentacoes m
       LEFT JOIN produtos p ON p.id = m.produto_id
       WHERE m.padaria_id = ? AND DATE_FORMAT(m.data, '%Y-%m') = ?
       GROUP BY m.produto_id
       ORDER BY qtd_movs DESC LIMIT 5`,
      [req.padaria.id, mes]),

    q(`SELECT COALESCE(c.nome, 'Sem categoria') AS categoria,
              SUM(CASE WHEN m.tipo IN ('entrada','sync_saurus') THEN m.valor_total ELSE 0 END) AS total_entradas,
              SUM(CASE WHEN m.tipo = 'saida' THEN m.valor_total ELSE 0 END) AS total_saidas,
              COUNT(*) AS movs
       FROM movimentacoes m
       LEFT JOIN produtos p ON p.id = m.produto_id
       LEFT JOIN categorias c ON c.id = p.categoria_id
       WHERE m.padaria_id = ? AND DATE_FORMAT(m.data, '%Y-%m') = ?
       GROUP BY c.id
       ORDER BY total_entradas DESC`,
      [req.padaria.id, mes]),

    q(`SELECT nome, estoque_atual, estoque_minimo, unidade,
              CASE WHEN estoque_atual <= 0 THEN 'zerado' ELSE 'minimo' END AS alerta
       FROM produtos
       WHERE padaria_id = ? AND ativo = 1
         AND (estoque_atual <= 0 OR (estoque_minimo > 0 AND estoque_atual <= estoque_minimo))
       ORDER BY estoque_atual ASC LIMIT 20`,
      [req.padaria.id]),

    q(`SELECT COALESCE(f.nome, '— Sem fornecedor —') AS fornecedor,
              COUNT(DISTINCT pc.id) AS qtd_pedidos,
              SUM(pc.total) AS total_gasto
       FROM pedidos_compra pc
       LEFT JOIN fornecedores f ON f.id = pc.fornecedor_id
       WHERE pc.padaria_id = ? AND pc.status = 'recebido'
         AND DATE_FORMAT(pc.recebido_em, '%Y-%m') = ?
       GROUP BY f.id
       ORDER BY total_gasto DESC`,
      [req.padaria.id, mes]),
  ]);

  res.json({
    ...(kpisRows[0] || {}),
    mes_anterior: kpisAntRows[0] || {},
    movs,
    top_produtos: top,
    categorias,
    alertas,
    compras_fornecedor: compras,
  });
}));

// Saídas últimos 30 dias
router.get('/saidas/recentes', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query(`
    SELECT m.id, m.quantidade, m.custo_unit, m.valor_total, m.data, m.observacao,
           p.nome AS produto, p.unidade,
           COALESCE(f.nome, 'Sem fornecedor') AS fornecedor
    FROM movimentacoes m
    JOIN produtos p ON p.id = m.produto_id
    LEFT JOIN fornecedores f ON f.id = p.fornecedor_id AND f.padaria_id = m.padaria_id
    WHERE m.padaria_id = ? AND m.tipo = 'saida'
      AND m.data >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
    ORDER BY COALESCE(f.nome, 'Sem fornecedor'), m.data DESC, m.id DESC
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
           COALESCE(p.nome, ip.nome_temp, 'Produto sem nome') AS produto,
           COALESCE(p.unidade, ip.unidade_temp, 'un') AS unidade,
           ip.is_novo
    FROM itens_pedido ip
    LEFT JOIN produtos p ON p.id = ip.produto_id
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

    const total = itens.reduce((s, i) => s + (i.quantidade * (i.custo || 0)), 0);

    const [rp] = await conn.query(
      `INSERT INTO pedidos_compra (padaria_id, fornecedor_id, status, total, observacao, criado_em)
       VALUES (?, ?, 'pendente', ?, ?, ?)`,
      [req.padaria.id, fornecedor_id || null, total, observacao || null, data || new Date().toISOString().slice(0, 10)]
    );
    const pedidoId = rp.insertId;

    for (const item of itens) {
      await conn.query(
        `INSERT INTO itens_pedido
           (pedido_id, produto_id, quantidade, custo_unitario, nome_temp, unidade_temp, minimo_temp, is_novo)
         VALUES (?,?,?,?,?,?,?,?)`,
        [pedidoId, item.isNovo ? null : item.produto_id, item.quantidade, item.custo || 0,
         item.isNovo ? item.nome : null, item.unidade || null, item.isNovo ? (item.minimo || 0) : null, item.isNovo ? 1 : 0]
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
      `SELECT id, fornecedor_id FROM pedidos_compra WHERE id = ? AND padaria_id = ? AND status = 'pendente'`,
      [pedidoId, req.padaria.id]
    );
    if (!pedido) { await conn.rollback(); conn.release(); return res.status(404).json({ erro: 'Pedido não encontrado ou já recebido.' }); }

    const fornecedorId = pedido.fornecedor_id || null;

    const [itens] = await conn.query(
      'SELECT ip.* FROM itens_pedido ip WHERE ip.pedido_id = ?',
      [pedidoId]
    );

    for (const item of itens) {
      let prodId = item.produto_id;

      if (item.is_novo) {
        // Cria produto no estoque ativo com fornecedor vinculado
        const [r] = await conn.query(
          'INSERT INTO produtos (padaria_id, fornecedor_id, nome, unidade, estoque_minimo, custo_unitario, ativo) VALUES (?,?,?,?,?,?,1)',
          [req.padaria.id, fornecedorId, item.nome_temp, item.unidade_temp || 'un', item.minimo_temp || 0, item.custo_unitario || 0]
        );
        prodId = r.insertId;
        await conn.query('UPDATE itens_pedido SET produto_id = ? WHERE id = ?', [prodId, item.id]);
      } else {
        if (item.unidade_temp) {
          await conn.query(
            'UPDATE produtos SET unidade = ? WHERE id = ? AND padaria_id = ?',
            [item.unidade_temp, prodId, req.padaria.id]
          );
        }
        // Vincula o fornecedor ao produto se ainda não tiver
        if (fornecedorId) {
          await conn.query(
            'UPDATE produtos SET fornecedor_id = ? WHERE id = ? AND padaria_id = ? AND (fornecedor_id IS NULL OR fornecedor_id = ?)',
            [fornecedorId, prodId, req.padaria.id, fornecedorId]
          );
        }
      }

      const valorTotal = parseFloat(item.quantidade || 0) * parseFloat(item.custo_unitario || 0);

      // Atualiza estoque e custo
      await conn.query(
        `UPDATE produtos SET
           estoque_atual = estoque_atual + ?,
           custo_unitario = IF(? > 0, ?, custo_unitario)
         WHERE id = ? AND padaria_id = ?`,
        [item.quantidade, item.custo_unitario, item.custo_unitario, prodId, req.padaria.id]
      );
      // Registra movimentação (valor_total é coluna gerada pelo banco)
      await conn.query(
        `INSERT INTO movimentacoes (padaria_id, produto_id, tipo, quantidade, custo_unit, observacao, data)
         VALUES (?, ?, 'entrada', ?, ?, ?, NOW())`,
        [req.padaria.id, prodId, item.quantidade, item.custo_unitario, `Pedido #${pedidoId}`]
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
// Corrige item sem nome no pedido pendente
router.post('/compras/pedidos/:id/corrigir-item', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const { item_idx, produto_id, nome_temp } = req.body;
  if (!nome_temp) return res.status(400).json({ erro: 'Nome obrigatório.' });

  // Busca itens do pedido
  const [itens] = await db.query(
    'SELECT * FROM itens_pedido WHERE pedido_id = ? ORDER BY id ASC',
    [req.params.id]
  );
  const item = itens[item_idx];
  if (!item) return res.status(404).json({ erro: 'Item não encontrado.' });

  // Verifica que o pedido pertence à padaria
  const [[pedido]] = await db.query(
    'SELECT id FROM pedidos_compra WHERE id = ? AND padaria_id = ? AND status = "pendente"',
    [req.params.id, req.padaria.id]
  );
  if (!pedido) return res.status(403).json({ erro: 'Pedido não encontrado.' });

  if (produto_id) {
    // Vincula ao produto existente
    await db.query(
      'UPDATE itens_pedido SET produto_id = ?, nome_temp = ?, is_novo = 0 WHERE id = ?',
      [produto_id, nome_temp, item.id]
    );
  } else {
    // Salva nome temporário para criar produto novo no recebimento
    await db.query(
      'UPDATE itens_pedido SET produto_id = NULL, nome_temp = ?, is_novo = 1 WHERE id = ?',
      [nome_temp, item.id]
    );
  }
  res.json({ ok: true });
}));

router.post('/compras/pedidos/:id/cancelar', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  await db.query(
    `UPDATE pedidos_compra SET status = 'cancelado' WHERE id = ? AND padaria_id = ? AND status = 'pendente'`,
    [req.params.id, req.padaria.id]
  );
  res.json({ ok: true });
}));

router.delete('/compras/pedidos/:id', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  await db.query('DELETE FROM itens_pedido WHERE pedido_id = ?', [req.params.id]);
  await db.query('DELETE FROM pedidos_compra WHERE id = ? AND padaria_id = ? AND status = \'pendente\'', [req.params.id, req.padaria.id]);
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

// ── Histórico de compras por fornecedor ──────────────────────────────────────
router.get('/fornecedores/:id/historico', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query(`
    SELECT pc.id, pc.criado_em AS data, pc.total, pc.status,
           GROUP_CONCAT(CONCAT(COALESCE(p.nome, ip.nome_temp), ' (', ip.quantidade, ')') ORDER BY p.nome SEPARATOR ', ') AS produtos
    FROM pedidos_compra pc
    JOIN itens_pedido ip ON ip.pedido_id = pc.id
    LEFT JOIN produtos p ON p.id = ip.produto_id
    WHERE pc.padaria_id = ? AND pc.fornecedor_id = ?
    GROUP BY pc.id ORDER BY pc.criado_em DESC LIMIT 50`, [req.padaria.id, req.params.id]);
  res.json(rows);
}));

// ── Produtos já comprados de um fornecedor (histórico) ───────────────────────
router.get('/fornecedores/:id/produtos', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query(`
    SELECT DISTINCT p.id, p.nome, p.unidade, p.estoque_atual, p.estoque_minimo,
           p.custo_unitario, p.categoria_id, p.fornecedor_id, p.validade, p.codigo_barras,
           c.nome AS categoria, f.nome AS fornecedor_nome
    FROM itens_pedido ip
    JOIN pedidos_compra pc ON pc.id = ip.pedido_id
    JOIN produtos p ON p.id = ip.produto_id
    LEFT JOIN categorias c ON c.id = p.categoria_id
    LEFT JOIN fornecedores f ON f.id = p.fornecedor_id
    WHERE pc.padaria_id = ? AND pc.fornecedor_id = ? AND p.ativo = 1
    ORDER BY p.nome
  `, [req.padaria.id, req.params.id]);
  res.json(rows);
}));

// ── Exportação Excel ──────────────────────────────────────────────────────────
router.get('/exportar/produtos', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const ExcelJS = require('exceljs');
  const [rows] = await db.query(`
    SELECT p.nome, p.codigo_barras, p.unidade, c.nome AS categoria,
           f.nome AS fornecedor, p.estoque_atual, p.estoque_minimo,
           p.custo_unitario, p.preco_venda, p.validade
    FROM produtos p
    LEFT JOIN categorias c ON c.id = p.categoria_id
    LEFT JOIN fornecedores f ON f.id = p.fornecedor_id
    WHERE p.padaria_id = ? AND p.ativo = 1 ORDER BY p.nome`, [req.padaria.id]);

  const wb = new ExcelJS.Workbook();
  const ws = wb.addWorksheet('Produtos');
  ws.columns = [
    { header: 'Nome', key: 'nome', width: 30 },
    { header: 'Código de barras', key: 'codigo_barras', width: 18 },
    { header: 'Unidade', key: 'unidade', width: 10 },
    { header: 'Categoria', key: 'categoria', width: 18 },
    { header: 'Fornecedor', key: 'fornecedor', width: 22 },
    { header: 'Estoque atual', key: 'estoque_atual', width: 14 },
    { header: 'Estoque mínimo', key: 'estoque_minimo', width: 15 },
    { header: 'Custo unitário', key: 'custo_unitario', width: 14 },
    { header: 'Preço de venda', key: 'preco_venda', width: 14 },
    { header: 'Validade', key: 'validade', width: 12 },
  ];
  ws.getRow(1).font = { bold: true };
  rows.forEach(r => ws.addRow(r));

  res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
  res.setHeader('Content-Disposition', 'attachment; filename="produtos.xlsx"');
  await wb.xlsx.write(res);
  res.end();
}));

router.get('/exportar/movimentacoes', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const ExcelJS = require('exceljs');
  const mes = req.query.mes || new Date().toISOString().slice(0, 7);
  const [rows] = await db.query(`
    SELECT m.data, m.tipo, p.nome AS produto, m.quantidade, p.unidade,
           m.custo_unit, m.valor_total, m.observacao
    FROM movimentacoes m
    JOIN produtos p ON p.id = m.produto_id
    WHERE m.padaria_id = ? AND DATE_FORMAT(m.data, '%Y-%m') = ?
    ORDER BY m.data DESC`, [req.padaria.id, mes]);

  const wb = new ExcelJS.Workbook();
  const ws = wb.addWorksheet('Movimentações');
  ws.columns = [
    { header: 'Data', key: 'data', width: 18 },
    { header: 'Tipo', key: 'tipo', width: 12 },
    { header: 'Produto', key: 'produto', width: 28 },
    { header: 'Quantidade', key: 'quantidade', width: 12 },
    { header: 'Unidade', key: 'unidade', width: 10 },
    { header: 'Custo unit.', key: 'custo_unit', width: 12 },
    { header: 'Total', key: 'valor_total', width: 12 },
    { header: 'Observação', key: 'observacao', width: 28 },
  ];
  ws.getRow(1).font = { bold: true };
  rows.forEach(r => ws.addRow(r));

  res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
  res.setHeader('Content-Disposition', `attachment; filename="movimentacoes-${mes}.xlsx"`);
  await wb.xlsx.write(res);
  res.end();
}));

// ── Admin ──────────────────────────────────────────────────────────────────
const authAdmin = (req, res, next) => {
  if (req.padaria.role !== 'admin') return res.status(403).json({ erro: 'Acesso restrito.' });
  next();
};

router.get('/admin/padarias', auth, authAdmin, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query(`
    SELECT id, nome, email, plano, plano_expira_em, plano_bloqueado, role, ativo, criado_em,
      (SELECT COUNT(*) FROM produtos WHERE padaria_id = padarias.id) AS total_produtos
    FROM padarias ORDER BY criado_em DESC`);
  res.json(rows);
}));

// Renovar plano (admin)
router.post('/admin/padarias/:id/renovar', auth, authAdmin, wrap(async (req, res) => {
  const db = require('../database/connection');
  const { meses = 1, plano } = req.body;
  const [[p]] = await db.query('SELECT plano_expira_em FROM padarias WHERE id = ?', [req.params.id]);
  if (!p) return res.status(404).json({ erro: 'Padaria não encontrada.' });
  const base = p.plano_expira_em && new Date(p.plano_expira_em) > new Date() ? new Date(p.plano_expira_em) : new Date();
  base.setMonth(base.getMonth() + Number(meses));
  const novaExpiracao = base.toISOString().slice(0, 10);
  await db.query(
    'UPDATE padarias SET plano_expira_em = ?, plano_bloqueado = 0' + (plano ? ', plano = ?' : '') + ' WHERE id = ?',
    plano ? [novaExpiracao, plano, req.params.id] : [novaExpiracao, req.params.id]
  );
  res.json({ ok: true, plano_expira_em: novaExpiracao });
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
  const id = Number(req.params.id);
  if (id === req.padaria.id) return res.status(400).json({ erro: 'Não pode apagar a si mesmo.' });
  // Remove em cascata: filhos antes dos pais
  await db.query('DELETE FROM itens_ficha WHERE ficha_id IN (SELECT id FROM fichas_tecnicas WHERE padaria_id = ?)', [id]);
  await db.query('DELETE FROM fichas_tecnicas WHERE padaria_id = ?', [id]);
  await db.query('DELETE FROM movimentacoes WHERE padaria_id = ?', [id]);
  await db.query('DELETE FROM itens_pedido WHERE pedido_id IN (SELECT id FROM pedidos_compra WHERE padaria_id = ?)', [id]);
  await db.query('DELETE FROM pedidos_compra WHERE padaria_id = ?', [id]);
  await db.query('DELETE FROM produtos WHERE padaria_id = ?', [id]);
  await db.query('DELETE FROM categorias WHERE padaria_id = ?', [id]);
  await db.query('DELETE FROM fornecedores WHERE padaria_id = ?', [id]);
  await db.query('DELETE FROM usuarios WHERE padaria_id = ?', [id]);
  await db.query('DELETE FROM codigos_ativacao WHERE padaria_id = ?', [id]);
  await db.query('DELETE FROM padarias WHERE id = ?', [id]);
  res.json({ ok: true });
}));

// ── Códigos de ativação ───────────────────────────────────────────────────
router.get('/admin/codigos', auth, authAdmin, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [rows] = await db.query(`
    SELECT c.id, c.codigo, c.plano, c.usado, c.criado_em, c.usado_em,
           p.nome AS padaria_nome, p.email AS padaria_email
    FROM codigos_ativacao c
    LEFT JOIN padarias p ON p.id = c.padaria_id
    ORDER BY c.criado_em DESC`);
  res.json(rows);
}));

router.post('/admin/codigos', auth, authAdmin, wrap(async (req, res) => {
  const db = require('../database/connection');
  const { plano } = req.body;
  const planosValidos = ['essencial', 'pro', 'premium'];
  if (!planosValidos.includes(plano)) return res.status(400).json({ erro: 'Plano inválido.' });

  // Gera código único: PP-XXXX-XXXX
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  const rand = (n) => Array.from({ length: n }, () => chars[Math.floor(Math.random() * chars.length)]).join('');
  const codigo = `PP-${rand(4)}-${rand(4)}`;

  await db.query('INSERT INTO codigos_ativacao (codigo, plano) VALUES (?, ?)', [codigo, plano]);
  res.status(201).json({ codigo, plano });
}));

router.delete('/admin/codigos/:id', auth, authAdmin, wrap(async (req, res) => {
  const db = require('../database/connection');
  await db.query('DELETE FROM codigos_ativacao WHERE id = ?', [req.params.id]);
  res.json({ ok: true });
}));

// ── Fichas Técnicas ────────────────────────────────────────────────────────
// Listar fichas com CMV calculado
router.get('/fichas', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [fichas] = await db.query(
    `SELECT f.*,
            COUNT(i.id) AS total_ingredientes,
            COALESCE(SUM(i.quantidade * p.custo_unitario), 0) AS custo_total
     FROM fichas_tecnicas f
     LEFT JOIN itens_ficha i ON i.ficha_id = f.id
     LEFT JOIN produtos p ON p.id = i.produto_id
     WHERE f.padaria_id = ? AND f.ativo = 1
     GROUP BY f.id
     ORDER BY f.nome`,
    [req.padaria.id]
  );
  res.json(fichas);
}));

// Buscar ficha com ingredientes
router.get('/fichas/:id', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [[ficha]] = await db.query(
    'SELECT * FROM fichas_tecnicas WHERE id = ? AND padaria_id = ? AND ativo = 1',
    [req.params.id, req.padaria.id]
  );
  if (!ficha) return res.status(404).json({ erro: 'Ficha não encontrada.' });

  const [itens] = await db.query(
    `SELECT i.*, p.nome AS produto_nome, p.unidade AS produto_unidade, p.custo_unitario,
            (i.quantidade * p.custo_unitario) AS custo_item
     FROM itens_ficha i
     JOIN produtos p ON p.id = i.produto_id
     WHERE i.ficha_id = ?
     ORDER BY p.nome`,
    [req.params.id]
  );
  res.json({ ...ficha, itens });
}));

// Criar ficha
router.post('/fichas', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const { nome, descricao, rendimento, unidade_rendimento, preco_venda, itens } = req.body;
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });

  const [r] = await db.query(
    'INSERT INTO fichas_tecnicas (padaria_id, nome, descricao, rendimento, unidade_rendimento, preco_venda) VALUES (?,?,?,?,?,?)',
    [req.padaria.id, nome, descricao || null, rendimento || 1, unidade_rendimento || 'unidades', preco_venda || null]
  );
  const fichaId = r.insertId;

  if (itens && itens.length) {
    for (const item of itens) {
      await db.query(
        'INSERT INTO itens_ficha (ficha_id, produto_id, quantidade, unidade) VALUES (?,?,?,?)',
        [fichaId, item.produto_id, item.quantidade, item.unidade || 'un']
      );
    }
  }
  res.status(201).json({ id: fichaId });
}));

// Atualizar ficha
router.put('/fichas/:id', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const { nome, descricao, rendimento, unidade_rendimento, preco_venda, itens } = req.body;
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });

  await db.query(
    'UPDATE fichas_tecnicas SET nome=?, descricao=?, rendimento=?, unidade_rendimento=?, preco_venda=? WHERE id=? AND padaria_id=?',
    [nome, descricao || null, rendimento || 1, unidade_rendimento || 'unidades', preco_venda || null, req.params.id, req.padaria.id]
  );

  await db.query('DELETE FROM itens_ficha WHERE ficha_id = ?', [req.params.id]);
  if (itens && itens.length) {
    for (const item of itens) {
      await db.query(
        'INSERT INTO itens_ficha (ficha_id, produto_id, quantidade, unidade) VALUES (?,?,?,?)',
        [req.params.id, item.produto_id, item.quantidade, item.unidade || 'un']
      );
    }
  }
  res.json({ ok: true });
}));

// Excluir ficha (soft delete)
router.delete('/fichas/:id', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  await db.query('UPDATE fichas_tecnicas SET ativo=0 WHERE id=? AND padaria_id=?', [req.params.id, req.padaria.id]);
  res.json({ ok: true });
}));

// Rota pública para verificar código antes de preencher o formulário
router.get('/auth/verificar-codigo/:codigo', wrap(async (req, res) => {
  const db = require('../database/connection');
  const codigo = String(req.params.codigo || '').trim().toUpperCase();
  const [rows] = await db.query('SELECT plano FROM codigos_ativacao WHERE codigo = ? AND usado = 0', [codigo]);
  if (!rows.length) return res.status(404).json({ valido: false });
  res.json({ valido: true, plano: rows[0].plano });
}));

// ── Configurações de Precificação ─────────────────────────────────────────

// GET config + despesas + modalidades
router.get('/precificacao/config', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const [[config]] = await db.query(
    'SELECT * FROM config_precificacao WHERE padaria_id = ?', [req.padaria.id]
  );
  const [despesas] = await db.query(
    'SELECT * FROM despesas_fixas_config WHERE padaria_id = ? ORDER BY ordem, id', [req.padaria.id]
  );
  const [modalidades] = await db.query(
    'SELECT * FROM modalidades_pagamento WHERE padaria_id = ? ORDER BY id', [req.padaria.id]
  );
  res.json({
    config: config || { faturamento_medio: 0, imposto_pct: 5, perda_pct: 2, lucro_desejado_pct: 10 },
    despesas,
    modalidades,
  });
}));

// PUT config geral
router.put('/precificacao/config', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const { faturamento_medio, imposto_pct, perda_pct, lucro_desejado_pct } = req.body;
  await db.query(
    `INSERT INTO config_precificacao (padaria_id, faturamento_medio, imposto_pct, perda_pct, lucro_desejado_pct)
     VALUES (?,?,?,?,?)
     ON DUPLICATE KEY UPDATE faturamento_medio=VALUES(faturamento_medio), imposto_pct=VALUES(imposto_pct),
       perda_pct=VALUES(perda_pct), lucro_desejado_pct=VALUES(lucro_desejado_pct)`,
    [req.padaria.id, faturamento_medio||0, imposto_pct||5, perda_pct||2, lucro_desejado_pct||10]
  );
  res.json({ ok: true });
}));

// PUT despesas fixas (substitui todas)
router.put('/precificacao/despesas', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const { despesas } = req.body; // [{nome, valor}]
  await db.query('DELETE FROM despesas_fixas_config WHERE padaria_id = ?', [req.padaria.id]);
  if (despesas && despesas.length) {
    for (let i = 0; i < despesas.length; i++) {
      const d = despesas[i];
      if (d.nome && d.valor >= 0) {
        await db.query(
          'INSERT INTO despesas_fixas_config (padaria_id, nome, valor, ordem) VALUES (?,?,?,?)',
          [req.padaria.id, d.nome, d.valor, i]
        );
      }
    }
  }
  res.json({ ok: true });
}));

// PUT modalidades (substitui todas)
router.put('/precificacao/modalidades', auth, wrap(async (req, res) => {
  const db = require('../database/connection');
  const { modalidades } = req.body; // [{nome, taxa_pct, participacao_pct}]
  await db.query('DELETE FROM modalidades_pagamento WHERE padaria_id = ?', [req.padaria.id]);
  if (modalidades && modalidades.length) {
    for (const m of modalidades) {
      if (m.nome) {
        await db.query(
          'INSERT INTO modalidades_pagamento (padaria_id, nome, taxa_pct, participacao_pct) VALUES (?,?,?,?)',
          [req.padaria.id, m.nome, m.taxa_pct||0, m.participacao_pct||0]
        );
      }
    }
  }
  res.json({ ok: true });
}));

module.exports = router;
