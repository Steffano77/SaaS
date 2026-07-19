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

  const [kpis] = await db.query(`
    SELECT
      COALESCE(SUM(CASE WHEN tipo IN ('entrada','sync_saurus') THEN valor_total ELSE 0 END), 0) AS total_entradas,
      COALESCE(SUM(CASE WHEN tipo = 'saida' THEN valor_total ELSE 0 END), 0) AS total_saidas,
      COUNT(*) AS qtd_movs,
      COUNT(DISTINCT produto_id) AS prods_distintos
    FROM movimentacoes
    WHERE padaria_id = ? AND DATE_FORMAT(data, '%Y-%m') = ?`,
    [req.padaria.id, mes]
  );

  const [movs] = await db.query(`
    SELECT m.tipo, m.quantidade, m.custo_unit, m.valor_total, m.data, p.nome AS produto
    FROM movimentacoes m
    JOIN produtos p ON p.id = m.produto_id
    WHERE m.padaria_id = ? AND DATE_FORMAT(m.data, '%Y-%m') = ?
    ORDER BY m.data DESC
    LIMIT 200`,
    [req.padaria.id, mes]
  );

  res.json({ ...kpis[0], movs });
}));

module.exports = router;
