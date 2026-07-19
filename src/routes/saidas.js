const router = require('express').Router();
const auth   = require('../middleware/auth');
const wrap   = require('../utils/wrap');
const db     = require('../database/connection');

router.get('/recentes', auth, wrap(async (req, res) => {
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
    LIMIT 200`,
    [req.padaria.id]
  );
  res.json(rows);
}));

module.exports = router;
