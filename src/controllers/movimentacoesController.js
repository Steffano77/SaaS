const db = require('../database/connection');

exports.listar = async (req, res) => {
  try {
    const { produto_id, tipo } = req.query;
    const limit = Math.min(Math.max(parseInt(req.query.limit) || 50, 1), 500);
    let sql = `SELECT m.*, p.nome AS produto, p.unidade
               FROM movimentacoes m JOIN produtos p ON p.id = m.produto_id
               WHERE m.padaria_id = ?`;
    const params = [req.padaria.id];
    if (produto_id) { sql += ' AND m.produto_id = ?'; params.push(produto_id); }
    if (tipo)       { sql += ' AND m.tipo = ?'; params.push(tipo); }
    sql += ' ORDER BY m.data DESC LIMIT ?';
    params.push(limit);
    const [rows] = await db.query(sql, params);
    res.json(rows);
  } catch (e) {
    console.error('Erro ao listar movimentações:', e);
    res.status(500).json({ erro: 'Erro interno.' });
  }
};

exports.registrar = async (req, res) => {
  try {
    const { produto_id, tipo, quantidade, custo_unit, observacao, data } = req.body;
    if (!produto_id || !tipo || !quantidade)
      return res.status(400).json({ erro: 'produto_id, tipo e quantidade são obrigatórios.' });

    const [prod] = await db.query(
      'SELECT id, estoque_atual, custo_unitario FROM produtos WHERE id = ? AND padaria_id = ?',
      [produto_id, req.padaria.id]
    );
    if (!prod.length) return res.status(404).json({ erro: 'Produto não encontrado.' });

    const custo = custo_unit || prod[0].custo_unitario;
    const dataMovimento = data || new Date().toISOString().slice(0, 10);
    await db.query(
      'INSERT INTO movimentacoes (padaria_id, produto_id, tipo, quantidade, custo_unit, observacao, data) VALUES (?,?,?,?,?,?,?)',
      [req.padaria.id, produto_id, tipo, quantidade, custo, observacao || null, dataMovimento]
    );

    const delta = ['entrada','ajuste'].includes(tipo) ? quantidade : -quantidade;
    await db.query(
      'UPDATE produtos SET estoque_atual = GREATEST(0, estoque_atual + ?), custo_unitario = IF(? > 0, ?, custo_unitario) WHERE id = ?',
      [delta, custo, custo, produto_id]
    );

    res.status(201).json({ ok: true });
  } catch (e) {
    console.error('Erro ao registrar movimentação:', e);
    res.status(500).json({ erro: 'Erro interno ao registrar movimentação.' });
  }
};
