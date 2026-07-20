const router = require('express').Router();
const auth   = require('../middleware/auth');
const wrap   = require('../utils/wrap');
const db     = require('../database/connection');

// Pedidos pendentes de recebimento
router.get('/pedidos', auth, wrap(async (req, res) => {
  const [pedidos] = await db.query(`
    SELECT pc.id, pc.criado_em, pc.observacao, pc.total, pc.fornecedor_id,
           COALESCE(f.nome, pc.observacao) AS fornecedor,
           f.telefone AS fornecedor_tel
    FROM pedidos_compra pc
    LEFT JOIN fornecedores f ON f.id = pc.fornecedor_id
    WHERE pc.padaria_id = ? AND pc.status = 'pendente'
    ORDER BY pc.criado_em DESC`,
    [req.padaria.id]
  );

  const ids = pedidos.map(p => p.id);
  if (!ids.length) return res.json([]);

  const [itens] = await db.query(`
    SELECT ip.pedido_id, ip.produto_id, ip.quantidade, ip.custo_unitario,
           COALESCE(p.nome, ip.nome_temp, 'Produto sem nome') AS produto,
           COALESCE(p.unidade, ip.unidade_temp, 'un') AS unidade,
           ip.is_novo
    FROM itens_pedido ip
    LEFT JOIN produtos p ON p.id = ip.produto_id
    WHERE ip.pedido_id IN (${ids.map(() => '?').join(',')})`,
    ids
  );

  const mapa = {};
  pedidos.forEach(p => { mapa[p.id] = { ...p, itens: [] }; });
  itens.forEach(i => { if (mapa[i.pedido_id]) mapa[i.pedido_id].itens.push(i); });

  res.json(Object.values(mapa));
}));

// Criar pedido de compra (sem atualizar estoque)
router.post('/pedidos', auth, async (req, res) => {
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
router.post('/pedidos/:id/receber', auth, async (req, res) => {
  const pedidoId = req.params.id;
  const conn = await db.getConnection();
  try {
    await conn.beginTransaction();

    const [[pedido]] = await conn.query(
      `SELECT id, fornecedor_id FROM pedidos_compra WHERE id = ? AND padaria_id = ? AND status = 'pendente'`,
      [pedidoId, req.padaria.id]
    );
    if (!pedido) {
      await conn.rollback();
      conn.release();
      return res.status(404).json({ erro: 'Pedido não encontrado ou já recebido.' });
    }

    const fornecedorId = pedido.fornecedor_id || null;
    const [itens] = await conn.query('SELECT ip.* FROM itens_pedido ip WHERE ip.pedido_id = ?', [pedidoId]);

    for (const item of itens) {
      let prodId = item.produto_id;

      if (item.is_novo) {
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
        if (fornecedorId) {
          await conn.query(
            'UPDATE produtos SET fornecedor_id = ? WHERE id = ? AND padaria_id = ? AND (fornecedor_id IS NULL OR fornecedor_id = ?)',
            [fornecedorId, prodId, req.padaria.id, fornecedorId]
          );
        }
      }

      await conn.query(
        `UPDATE produtos SET
           estoque_atual = estoque_atual + ?,
           custo_unitario = IF(? > 0, ?, custo_unitario)
         WHERE id = ? AND padaria_id = ?`,
        [item.quantidade, item.custo_unitario, item.custo_unitario, prodId, req.padaria.id]
      );
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

// Corrige item sem nome no pedido pendente
router.post('/pedidos/:id/corrigir-item', auth, wrap(async (req, res) => {
  const { item_idx, produto_id, nome_temp } = req.body;
  if (!nome_temp) return res.status(400).json({ erro: 'Nome obrigatório.' });

  const [itens] = await db.query(
    'SELECT * FROM itens_pedido WHERE pedido_id = ? ORDER BY id ASC',
    [req.params.id]
  );
  const item = itens[item_idx];
  if (!item) return res.status(404).json({ erro: 'Item não encontrado.' });

  const [[pedido]] = await db.query(
    'SELECT id FROM pedidos_compra WHERE id = ? AND padaria_id = ? AND status = "pendente"',
    [req.params.id, req.padaria.id]
  );
  if (!pedido) return res.status(403).json({ erro: 'Pedido não encontrado.' });

  if (produto_id) {
    await db.query(
      'UPDATE itens_pedido SET produto_id = ?, nome_temp = ?, is_novo = 0 WHERE id = ?',
      [produto_id, nome_temp, item.id]
    );
  } else {
    await db.query(
      'UPDATE itens_pedido SET produto_id = NULL, nome_temp = ?, is_novo = 1 WHERE id = ?',
      [nome_temp, item.id]
    );
  }
  res.json({ ok: true });
}));

router.post('/pedidos/:id/cancelar', auth, wrap(async (req, res) => {
  await db.query(
    `UPDATE pedidos_compra SET status = 'cancelado' WHERE id = ? AND padaria_id = ? AND status = 'pendente'`,
    [req.params.id, req.padaria.id]
  );
  res.json({ ok: true });
}));

router.delete('/pedidos/:id', auth, wrap(async (req, res) => {
  await db.query('DELETE FROM itens_pedido WHERE pedido_id = ?', [req.params.id]);
  await db.query(
    "DELETE FROM pedidos_compra WHERE id = ? AND padaria_id = ? AND status = 'pendente'",
    [req.params.id, req.padaria.id]
  );
  res.json({ ok: true });
}));

// Compras recentes (últimos 30 dias) — pedidos já recebidos
router.get('/recentes', auth, wrap(async (req, res) => {
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
    LIMIT 50`,
    [req.padaria.id]
  );
  res.json(rows);
}));

module.exports = router;
