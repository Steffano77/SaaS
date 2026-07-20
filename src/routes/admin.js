const router    = require('express').Router();
const auth      = require('../middleware/auth');
const authAdmin = require('../middleware/authAdmin');
const wrap      = require('../utils/wrap');
const db        = require('../database/connection');

// Todas as rotas admin exigem autenticação + papel admin
router.use(auth, authAdmin);

router.get('/padarias', wrap(async (req, res) => {
  const [rows] = await db.query(`
    SELECT id, nome, email, plano, plano_expira_em, plano_bloqueado, role, ativo, criado_em,
      (SELECT COUNT(*) FROM produtos WHERE padaria_id = padarias.id) AS total_produtos
    FROM padarias ORDER BY criado_em DESC`);
  res.json(rows);
}));

router.post('/padarias/:id/renovar', wrap(async (req, res) => {
  const { meses = 1, plano } = req.body;
  const [[p]] = await db.query('SELECT plano_expira_em FROM padarias WHERE id = ?', [req.params.id]);
  if (!p) return res.status(404).json({ erro: 'Padaria não encontrada.' });

  const base = p.plano_expira_em && new Date(p.plano_expira_em) > new Date()
    ? new Date(p.plano_expira_em)
    : new Date();
  base.setMonth(base.getMonth() + Number(meses));
  const novaExpiracao = base.toISOString().slice(0, 10);

  await db.query(
    'UPDATE padarias SET plano_expira_em = ?, plano_bloqueado = 0' + (plano ? ', plano = ?' : '') + ' WHERE id = ?',
    plano ? [novaExpiracao, plano, req.params.id] : [novaExpiracao, req.params.id]
  );
  res.json({ ok: true, plano_expira_em: novaExpiracao });
}));

router.patch('/padarias/:id/ativo', wrap(async (req, res) => {
  const { ativo } = req.body;
  if (Number(req.params.id) === req.padaria.id) {
    return res.status(400).json({ erro: 'Não pode alterar a si mesmo.' });
  }
  await db.query('UPDATE padarias SET ativo = ? WHERE id = ?', [ativo ? 1 : 0, req.params.id]);
  res.json({ ok: true });
}));

router.delete('/padarias/:id', wrap(async (req, res) => {
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

// Códigos de ativação
router.get('/codigos', wrap(async (req, res) => {
  const [rows] = await db.query(`
    SELECT c.id, c.codigo, c.plano, c.usado, c.criado_em, c.usado_em,
           p.nome AS padaria_nome, p.email AS padaria_email
    FROM codigos_ativacao c
    LEFT JOIN padarias p ON p.id = c.padaria_id
    ORDER BY c.criado_em DESC`);
  res.json(rows);
}));

router.post('/codigos', wrap(async (req, res) => {
  const { plano } = req.body;
  const planosValidos = ['essencial', 'pro', 'premium'];
  if (!planosValidos.includes(plano)) return res.status(400).json({ erro: 'Plano inválido.' });

  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  const rand = n => Array.from({ length: n }, () => chars[Math.floor(Math.random() * chars.length)]).join('');
  const codigo = `PP-${rand(4)}-${rand(4)}`;

  await db.query('INSERT INTO codigos_ativacao (codigo, plano) VALUES (?, ?)', [codigo, plano]);
  res.status(201).json({ codigo, plano });
}));

router.delete('/codigos/:id', wrap(async (req, res) => {
  await db.query('DELETE FROM codigos_ativacao WHERE id = ?', [req.params.id]);
  res.json({ ok: true });
}));

module.exports = router;
