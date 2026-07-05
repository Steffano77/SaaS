const db = require('../database/connection');

exports.limparTudo = async (req, res) => {
  const pid = req.padaria.id;
  const conn = await db.getConnection();
  try {
    const [[mResult]] = await conn.query('SELECT COUNT(*) AS total FROM movimentacoes WHERE padaria_id = ?', [pid]);
    const [[pResult]] = await conn.query('SELECT COUNT(*) AS total FROM produtos WHERE padaria_id = ?', [pid]);

    await conn.beginTransaction();
    await conn.query('DELETE FROM movimentacoes WHERE padaria_id = ?', [pid]);
    await conn.query('DELETE FROM itens_ficha WHERE ficha_id IN (SELECT id FROM fichas_tecnicas WHERE padaria_id = ?)', [pid]);
    await conn.query('DELETE FROM fichas_tecnicas WHERE padaria_id = ?', [pid]);
    await conn.query('DELETE FROM itens_pedido WHERE pedido_id IN (SELECT id FROM pedidos_compra WHERE padaria_id = ?)', [pid]);
    await conn.query('DELETE FROM pedidos_compra WHERE padaria_id = ?', [pid]);
    await conn.query('DELETE FROM produtos WHERE padaria_id = ?', [pid]);
    await conn.query('DELETE FROM categorias WHERE padaria_id = ?', [pid]);
    await conn.commit();

    res.json({ ok: true, movimentacoes: mResult.total, produtos: pResult.total });
  } catch (e) {
    await conn.rollback();
    console.error('Erro ao limpar dados:', e);
    res.status(500).json({ erro: 'Erro ao limpar dados. Nenhuma alteração foi feita.' });
  } finally {
    conn.release();
  }
};
