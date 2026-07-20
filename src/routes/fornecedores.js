const router = require('express').Router();
const auth   = require('../middleware/auth');
const wrap   = require('../utils/wrap');
const db     = require('../database/connection');

router.get('/', auth, wrap(async (req, res) => {
  const [rows] = await db.query(
    'SELECT * FROM fornecedores WHERE padaria_id = ? AND ativo = 1 ORDER BY nome',
    [req.padaria.id]
  );
  res.json(rows);
}));

router.post('/', auth, wrap(async (req, res) => {
  const { nome, contato, telefone, email } = req.body;
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });
  const [r] = await db.query(
    'INSERT INTO fornecedores (padaria_id, nome, contato, telefone, email) VALUES (?,?,?,?,?)',
    [req.padaria.id, nome, contato || null, telefone || null, email || null]
  );
  res.status(201).json({ id: r.insertId, nome });
}));

router.put('/:id', auth, wrap(async (req, res) => {
  const { nome, contato, telefone, email } = req.body;
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });
  await db.query(
    'UPDATE fornecedores SET nome=?, contato=?, telefone=?, email=? WHERE id=? AND padaria_id=?',
    [nome, contato || null, telefone || null, email || null, req.params.id, req.padaria.id]
  );
  res.json({ ok: true });
}));

router.delete('/:id', auth, wrap(async (req, res) => {
  await db.query(
    'UPDATE fornecedores SET ativo = 0 WHERE id = ? AND padaria_id = ?',
    [req.params.id, req.padaria.id]
  );
  res.json({ ok: true });
}));

router.get('/:id/historico', auth, wrap(async (req, res) => {
  const [rows] = await db.query(`
    SELECT pc.id, pc.criado_em AS data, pc.total, pc.status,
           GROUP_CONCAT(CONCAT(COALESCE(p.nome, ip.nome_temp), ' (', ip.quantidade, ')') ORDER BY p.nome SEPARATOR ', ') AS produtos
    FROM pedidos_compra pc
    JOIN itens_pedido ip ON ip.pedido_id = pc.id
    LEFT JOIN produtos p ON p.id = ip.produto_id
    WHERE pc.padaria_id = ? AND pc.fornecedor_id = ?
    GROUP BY pc.id ORDER BY pc.criado_em DESC LIMIT 50`,
    [req.padaria.id, req.params.id]
  );
  res.json(rows);
}));

router.get('/:id/produtos', auth, wrap(async (req, res) => {
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
    ORDER BY p.nome`,
    [req.padaria.id, req.params.id]
  );
  res.json(rows);
}));

module.exports = router;
