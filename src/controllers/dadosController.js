const db = require('../database/connection');

exports.limparTudo = async (req, res) => {
  const pid = req.padaria.id;
  const [[mResult]] = await db.query(
    'SELECT COUNT(*) AS total FROM movimentacoes WHERE padaria_id = ?', [pid]
  );
  const [[pResult]] = await db.query(
    'SELECT COUNT(*) AS total FROM produtos WHERE padaria_id = ?', [pid]
  );
  await db.query('DELETE FROM movimentacoes WHERE padaria_id = ?', [pid]);
  await db.query('DELETE FROM itens_ficha WHERE ficha_id IN (SELECT id FROM fichas_tecnicas WHERE padaria_id = ?)', [pid]);
  await db.query('DELETE FROM fichas_tecnicas WHERE padaria_id = ?', [pid]);
  await db.query('DELETE FROM itens_pedido WHERE pedido_id IN (SELECT id FROM pedidos_compra WHERE padaria_id = ?)', [pid]);
  await db.query('DELETE FROM pedidos_compra WHERE padaria_id = ?', [pid]);
  await db.query('DELETE FROM produtos WHERE padaria_id = ?', [pid]);
  await db.query('DELETE FROM categorias WHERE padaria_id = ?', [pid]);
  res.json({ ok: true, movimentacoes: mResult.total, produtos: pResult.total });
};
