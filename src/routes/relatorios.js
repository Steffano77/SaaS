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

  const [[kpis], [kpisAnt], movs, top, categorias, alertas, compras] = await Promise.all([
    // KPIs do mês atual
    db.query(`
      SELECT
        COALESCE(SUM(CASE WHEN tipo IN ('entrada','sync_saurus') THEN valor_total ELSE 0 END), 0) AS total_entradas,
        COALESCE(SUM(CASE WHEN tipo = 'saida' THEN valor_total ELSE 0 END), 0) AS total_saidas,
        COUNT(*) AS qtd_movs,
        COUNT(DISTINCT produto_id) AS prods_distintos
      FROM movimentacoes
      WHERE padaria_id = ? AND DATE_FORMAT(data, '%Y-%m') = ?`,
      [req.padaria.id, mes]
    ),
    // KPIs do mês anterior (para comparativo)
    db.query(`
      SELECT
        COALESCE(SUM(CASE WHEN tipo IN ('entrada','sync_saurus') THEN valor_total ELSE 0 END), 0) AS total_entradas,
        COALESCE(SUM(CASE WHEN tipo = 'saida' THEN valor_total ELSE 0 END), 0) AS total_saidas,
        COUNT(*) AS qtd_movs
      FROM movimentacoes
      WHERE padaria_id = ? AND DATE_FORMAT(data, '%Y-%m') = ?`,
      [req.padaria.id, mesAnterior]
    ),
    // Movimentações detalhadas
    db.query(`
      SELECT m.tipo, m.quantidade, m.custo_unit, m.valor_total, m.data, p.nome AS produto,
             COALESCE(c.nome, 'Sem categoria') AS categoria
      FROM movimentacoes m
      JOIN produtos p ON p.id = m.produto_id
      LEFT JOIN categorias c ON c.id = p.categoria_id
      WHERE m.padaria_id = ? AND DATE_FORMAT(m.data, '%Y-%m') = ?
      ORDER BY m.data DESC
      LIMIT 500`,
      [req.padaria.id, mes]
    ),
    // Top 5 produtos mais movimentados no mês
    db.query(`
      SELECT p.nome, COUNT(*) AS qtd_movs,
             SUM(m.quantidade) AS total_qtd,
             SUM(CASE WHEN m.tipo IN ('entrada','sync_saurus') THEN m.quantidade ELSE 0 END) AS entradas,
             SUM(CASE WHEN m.tipo = 'saida' THEN m.quantidade ELSE 0 END) AS saidas,
             p.unidade
      FROM movimentacoes m
      JOIN produtos p ON p.id = m.produto_id
      WHERE m.padaria_id = ? AND DATE_FORMAT(m.data, '%Y-%m') = ?
      GROUP BY p.id, p.nome, p.unidade
      ORDER BY qtd_movs DESC
      LIMIT 5`,
      [req.padaria.id, mes]
    ),
    // Gastos por categoria (entradas do mês)
    db.query(`
      SELECT COALESCE(c.nome, 'Sem categoria') AS categoria,
             SUM(CASE WHEN m.tipo IN ('entrada','sync_saurus') THEN m.valor_total ELSE 0 END) AS total_entradas,
             SUM(CASE WHEN m.tipo = 'saida' THEN m.valor_total ELSE 0 END) AS total_saidas,
             COUNT(*) AS movs
      FROM movimentacoes m
      JOIN produtos p ON p.id = m.produto_id
      LEFT JOIN categorias c ON c.id = p.categoria_id
      WHERE m.padaria_id = ? AND DATE_FORMAT(m.data, '%Y-%m') = ?
      GROUP BY c.nome
      ORDER BY total_entradas DESC`,
      [req.padaria.id, mes]
    ),
    // Alertas de estoque atuais
    db.query(`
      SELECT nome, estoque_atual, estoque_minimo, unidade,
             CASE WHEN estoque_atual <= 0 THEN 'zerado'
                  WHEN estoque_minimo > 0 AND estoque_atual <= estoque_minimo THEN 'minimo'
             END AS alerta
      FROM produtos
      WHERE padaria_id = ? AND ativo = 1
        AND (estoque_atual <= 0 OR (estoque_minimo > 0 AND estoque_atual <= estoque_minimo))
      ORDER BY estoque_atual ASC
      LIMIT 20`,
      [req.padaria.id]
    ),
    // Compras recebidas no mês por fornecedor
    db.query(`
      SELECT COALESCE(f.nome, '— Sem fornecedor —') AS fornecedor,
             COUNT(DISTINCT pc.id) AS qtd_pedidos,
             SUM(pc.total) AS total_gasto
      FROM pedidos_compra pc
      LEFT JOIN fornecedores f ON f.id = pc.fornecedor_id
      WHERE pc.padaria_id = ? AND pc.status = 'recebido'
        AND DATE_FORMAT(pc.atualizado_em, '%Y-%m') = ?
      GROUP BY f.nome
      ORDER BY total_gasto DESC`,
      [req.padaria.id, mes]
    ),
  ]);

  res.json({
    ...kpis[0],
    mes_anterior: kpisAnt[0],
    movs: movs[0],
    top_produtos: top[0],
    categorias: categorias[0],
    alertas: alertas[0],
    compras_fornecedor: compras[0],
  });
}));

module.exports = router;
