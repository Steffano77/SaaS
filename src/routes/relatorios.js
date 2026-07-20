const router = require('express').Router();
const auth   = require('../middleware/auth');
const wrap   = require('../utils/wrap');
const db     = require('../database/connection');

router.get('/movs-semana', auth, wrap(async (req, res) => {
  const [rows] = await db.query(`
    SELECT
      DATE_FORMAT(data, '%d/%m') AS dia,
      COALESCE(SUM(CASE WHEN tipo IN ('entrada','sync_saurus') THEN quantidade ELSE 0 END), 0) AS entradas,
      COALESCE(SUM(CASE WHEN tipo = 'saida' THEN quantidade ELSE 0 END), 0) AS saidas
    FROM movimentacoes
    WHERE padaria_id = ?
      AND data >= DATE_SUB(CURDATE(), INTERVAL 6 DAY)
    GROUP BY DATE(data), DATE_FORMAT(data, '%d/%m')
    ORDER BY DATE(data)`,
    [req.padaria.id]
  );
  res.json(rows);
}));

router.get('/top-produtos', auth, wrap(async (req, res) => {
  const [rows] = await db.query(`
    SELECT nome, ROUND(estoque_atual * custo_unitario, 2) AS valor
    FROM produtos
    WHERE padaria_id = ? AND ativo = 1 AND estoque_atual > 0 AND custo_unitario > 0
    ORDER BY valor DESC
    LIMIT 5`,
    [req.padaria.id]
  );
  res.json(rows);
}));

router.get('/valor-categorias', auth, wrap(async (req, res) => {
  const [rows] = await db.query(`
    SELECT COALESCE(c.nome, 'Sem categoria') AS categoria,
           SUM(p.estoque_atual * p.custo_unitario) AS valor
    FROM produtos p
    LEFT JOIN categorias c ON c.id = p.categoria_id
    WHERE p.padaria_id = ? AND p.ativo = 1
    GROUP BY c.nome
    ORDER BY valor DESC
    LIMIT 8`,
    [req.padaria.id]
  );
  res.json(rows);
}));

router.get('/mes', auth, wrap(async (req, res) => {
  const mes = req.query.mes || new Date().toISOString().slice(0, 7);
  const [ano, m] = mes.split('-').map(Number);
  const mesAnterior = m === 1
    ? `${ano - 1}-12`
    : `${ano}-${String(m - 1).padStart(2, '0')}`;

  const q = (sql, params) => db.query(sql, params)
    .then(([rows]) => rows)
    .catch(e => { console.error('rel query err:', e.message); return []; });

  const [kpisRows, kpisAntRows, movs, top, categorias, alertas, compras] = await Promise.all([
    // KPIs do mês atual
    q(`SELECT
        COALESCE(SUM(CASE WHEN tipo IN ('entrada','sync_saurus') THEN valor_total ELSE 0 END), 0) AS total_entradas,
        COALESCE(SUM(CASE WHEN tipo = 'saida' THEN valor_total ELSE 0 END), 0) AS total_saidas,
        COUNT(*) AS qtd_movs,
        COUNT(DISTINCT produto_id) AS prods_distintos
       FROM movimentacoes
       WHERE padaria_id = ? AND DATE_FORMAT(data, '%Y-%m') = ?`,
      [req.padaria.id, mes]),

    // KPIs do mês anterior
    q(`SELECT
        COALESCE(SUM(CASE WHEN tipo IN ('entrada','sync_saurus') THEN valor_total ELSE 0 END), 0) AS total_entradas,
        COALESCE(SUM(CASE WHEN tipo = 'saida' THEN valor_total ELSE 0 END), 0) AS total_saidas,
        COUNT(*) AS qtd_movs
       FROM movimentacoes
       WHERE padaria_id = ? AND DATE_FORMAT(data, '%Y-%m') = ?`,
      [req.padaria.id, mesAnterior]),

    // Movimentações detalhadas — LEFT JOIN para incluir produtos excluídos
    q(`SELECT m.tipo, m.quantidade, m.custo_unit, m.valor_total,
              DATE_FORMAT(m.data, '%Y-%m-%dT%H:%i:%s') AS data,
              COALESCE(p.nome, '[Produto removido]') AS produto,
              COALESCE(c.nome, 'Sem categoria') AS categoria
       FROM movimentacoes m
       LEFT JOIN produtos p ON p.id = m.produto_id
       LEFT JOIN categorias c ON c.id = p.categoria_id
       WHERE m.padaria_id = ? AND DATE_FORMAT(m.data, '%Y-%m') = ?
       ORDER BY m.data DESC LIMIT 500`,
      [req.padaria.id, mes]),

    // Top 5 produtos mais movimentados
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

    // Por categoria — LEFT JOIN para incluir produtos excluídos
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

    // Alertas de estoque
    q(`SELECT nome, estoque_atual, estoque_minimo, unidade,
              CASE WHEN estoque_atual <= 0 THEN 'zerado' ELSE 'minimo' END AS alerta
       FROM produtos
       WHERE padaria_id = ? AND ativo = 1
         AND (estoque_atual <= 0 OR (estoque_minimo > 0 AND estoque_atual <= estoque_minimo))
       ORDER BY estoque_atual ASC LIMIT 20`,
      [req.padaria.id]),

    // Compras por fornecedor
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

module.exports = router;
