const db = require('../database/connection');

// Lista comandas abertas + um histórico recente das fechadas/canceladas
exports.listar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [abertas] = await db.query(
    `SELECT c.*,
       (SELECT COUNT(*) FROM itens_comanda i WHERE i.comanda_id = c.id) AS qtd_itens
     FROM comandas c
     WHERE c.padaria_id = ? AND c.status = 'aberta'
     ORDER BY c.aberta_em DESC`,
    [padaria_id]
  );
  const [recentes] = await db.query(
    `SELECT c.*,
       (SELECT COUNT(*) FROM itens_comanda i WHERE i.comanda_id = c.id) AS qtd_itens
     FROM comandas c
     WHERE c.padaria_id = ? AND c.status <> 'aberta'
     ORDER BY c.fechada_em DESC LIMIT 30`,
    [padaria_id]
  );
  res.json({ abertas, recentes });
};

// Abre uma nova comanda
exports.abrir = async (req, res) => {
  const padaria_id = req.padaria.id;
  const identificador = String(req.body.identificador || '').trim() || 'Comanda';
  const [r] = await db.query(
    `INSERT INTO comandas (padaria_id, identificador) VALUES (?, ?)`,
    [padaria_id, identificador]
  );
  res.status(201).json({ id: r.insertId, identificador });
};

// Detalhe de uma comanda com os itens
exports.buscar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [[comanda]] = await db.query(
    `SELECT * FROM comandas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]
  );
  if (!comanda) return res.status(404).json({ erro: 'Comanda não encontrada.' });
  const [itens] = await db.query(
    `SELECT * FROM itens_comanda WHERE comanda_id = ? ORDER BY id`, [comanda.id]
  );
  res.json({ ...comanda, itens });
};

// Adiciona um item (produto cadastrado ou avulso) à comanda
exports.adicionarItem = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { produto_id, nome_produto, quantidade, preco_unitario, unidade } = req.body;

  const [[comanda]] = await db.query(
    `SELECT id, status FROM comandas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]
  );
  if (!comanda) return res.status(404).json({ erro: 'Comanda não encontrada.' });
  if (comanda.status !== 'aberta') return res.status(400).json({ erro: 'Essa comanda já foi fechada.' });

  const qtd = parseFloat(quantidade);
  if (!qtd || qtd <= 0) return res.status(400).json({ erro: 'Quantidade inválida.' });

  let nome = nome_produto, preco = parseFloat(preco_unitario), unid = unidade || 'un', pid = produto_id || null;

  if (produto_id) {
    const [[prod]] = await db.query(
      `SELECT id, nome, unidade, preco_venda, estoque_atual FROM produtos WHERE id = ? AND padaria_id = ? AND ativo = 1`,
      [produto_id, padaria_id]
    );
    if (!prod) return res.status(404).json({ erro: 'Produto não encontrado.' });
    nome = prod.nome;
    unid = prod.unidade;
    if (preco == null || isNaN(preco)) preco = parseFloat(prod.preco_venda || 0);
  }

  if (!nome || !nome.trim()) return res.status(400).json({ erro: 'Nome do item é obrigatório.' });
  if (preco == null || isNaN(preco) || preco < 0) preco = 0;

  const [r] = await db.query(
    `INSERT INTO itens_comanda (comanda_id, produto_id, nome_produto, unidade, quantidade, preco_unitario) VALUES (?,?,?,?,?,?)`,
    [comanda.id, pid, nome.trim(), unid, qtd, preco]
  );
  await recalcularTotal(comanda.id);
  res.status(201).json({ id: r.insertId });
};

// Remove um item da comanda
exports.removerItem = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [[comanda]] = await db.query(
    `SELECT id, status FROM comandas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]
  );
  if (!comanda) return res.status(404).json({ erro: 'Comanda não encontrada.' });
  if (comanda.status !== 'aberta') return res.status(400).json({ erro: 'Essa comanda já foi fechada.' });

  await db.query(`DELETE FROM itens_comanda WHERE id = ? AND comanda_id = ?`, [req.params.itemId, comanda.id]);
  await recalcularTotal(comanda.id);
  res.json({ ok: true });
};

async function recalcularTotal(comanda_id) {
  const [[{ total }]] = await db.query(
    `SELECT COALESCE(SUM(subtotal), 0) AS total FROM itens_comanda WHERE comanda_id = ?`, [comanda_id]
  );
  await db.query(`UPDATE comandas SET total = ? WHERE id = ?`, [total, comanda_id]);
}

// Fecha a comanda: escolhe forma de pagamento, lança no Financeiro e
// desconta o estoque de cada item vinculado a um produto cadastrado.
exports.fechar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const forma_pagamento = String(req.body.forma_pagamento || '').trim() || 'Dinheiro';

  const [[comanda]] = await db.query(
    `SELECT * FROM comandas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]
  );
  if (!comanda) return res.status(404).json({ erro: 'Comanda não encontrada.' });
  if (comanda.status !== 'aberta') return res.status(400).json({ erro: 'Essa comanda já foi fechada.' });

  const [itens] = await db.query(`SELECT * FROM itens_comanda WHERE comanda_id = ?`, [comanda.id]);
  if (!itens.length) return res.status(400).json({ erro: 'Adicione ao menos um item antes de fechar.' });

  const totalGeral = itens.reduce((s, i) => s + parseFloat(i.subtotal), 0);

  // Lança a venda no Financeiro
  await db.query(
    `INSERT INTO financeiro (padaria_id, tipo, valor, descricao, categoria, forma_pagamento, data) VALUES (?,?,?,?,?,?,CURDATE())`,
    [padaria_id, 'entrada', totalGeral, `Comanda ${comanda.identificador}`, 'Vendas', forma_pagamento]
  );

  // Desconta estoque de cada item vinculado a um produto cadastrado
  for (const item of itens) {
    if (!item.produto_id) continue;
    const [[prod]] = await db.query(
      `SELECT custo_unitario FROM produtos WHERE id = ? AND padaria_id = ?`, [item.produto_id, padaria_id]
    );
    if (!prod) continue;
    await db.query(
      `INSERT INTO movimentacoes (padaria_id, produto_id, tipo, quantidade, custo_unit, observacao, data) VALUES (?,?,?,?,?,?,NOW())`,
      [padaria_id, item.produto_id, 'saida', item.quantidade, prod.custo_unitario || 0, `Comanda ${comanda.identificador}`]
    );
    await db.query(
      `UPDATE produtos SET estoque_atual = estoque_atual - ? WHERE id = ? AND padaria_id = ?`,
      [item.quantidade, item.produto_id, padaria_id]
    );
  }

  await db.query(
    `UPDATE comandas SET status = 'fechada', total = ?, forma_pagamento = ?, fechada_em = NOW() WHERE id = ?`,
    [totalGeral, forma_pagamento, comanda.id]
  );

  res.json({ ok: true, total: totalGeral });
};

// Cancela uma comanda aberta (sem lançar nada)
exports.cancelar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [[comanda]] = await db.query(
    `SELECT id, status FROM comandas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]
  );
  if (!comanda) return res.status(404).json({ erro: 'Comanda não encontrada.' });
  if (comanda.status !== 'aberta') return res.status(400).json({ erro: 'Essa comanda já foi fechada.' });

  await db.query(`UPDATE comandas SET status = 'cancelada', fechada_em = NOW() WHERE id = ?`, [comanda.id]);
  res.json({ ok: true });
};
