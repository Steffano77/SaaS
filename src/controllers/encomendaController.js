const db = require('../database/connection');

// Lista encomendas em aberto (não entregues/canceladas) ordenadas por data de entrega mais próxima,
// e um histórico recente das entregues/canceladas.
exports.listar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [abertas] = await db.query(
    `SELECT * FROM encomendas
     WHERE padaria_id = ? AND status NOT IN ('entregue','cancelada')
     ORDER BY data_entrega ASC, hora_entrega ASC`,
    [padaria_id]
  );
  const [recentes] = await db.query(
    `SELECT * FROM encomendas
     WHERE padaria_id = ? AND status IN ('entregue','cancelada')
     ORDER BY atualizado_em DESC LIMIT 30`,
    [padaria_id]
  );
  res.json({ abertas, recentes });
};

// Resumo pro Painel: quantas pra hoje e quantas atrasadas
exports.resumo = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [[r]] = await db.query(
    `SELECT
       COALESCE(SUM(data_entrega = CURDATE()), 0) AS hoje,
       COALESCE(SUM(data_entrega < CURDATE()), 0) AS atrasadas
     FROM encomendas
     WHERE padaria_id = ? AND status NOT IN ('entregue','cancelada')`,
    [padaria_id]
  );
  res.json({ hoje: r.hoje, atrasadas: r.atrasadas });
};

exports.buscar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [[encomenda]] = await db.query(
    `SELECT * FROM encomendas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]
  );
  if (!encomenda) return res.status(404).json({ erro: 'Encomenda não encontrada.' });
  res.json(encomenda);
};

exports.criar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { cliente_nome, cliente_telefone, descricao, data_entrega, hora_entrega, valor, sinal_pago, observacao } = req.body;

  if (!cliente_nome || !cliente_nome.trim()) return res.status(400).json({ erro: 'Nome do cliente é obrigatório.' });
  if (!descricao || !descricao.trim()) return res.status(400).json({ erro: 'Descreva o que foi encomendado.' });
  if (!data_entrega) return res.status(400).json({ erro: 'Data de entrega é obrigatória.' });

  const [r] = await db.query(
    `INSERT INTO encomendas (padaria_id, cliente_nome, cliente_telefone, descricao, data_entrega, hora_entrega, valor, sinal_pago, observacao)
     VALUES (?,?,?,?,?,?,?,?,?)`,
    [padaria_id, cliente_nome.trim(), cliente_telefone || null, descricao.trim(), data_entrega, hora_entrega || null,
     parseFloat(valor) || 0, parseFloat(sinal_pago) || 0, observacao || null]
  );
  res.status(201).json({ id: r.insertId });
};

exports.atualizar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const campos = ['cliente_nome', 'cliente_telefone', 'descricao', 'data_entrega', 'hora_entrega', 'valor', 'sinal_pago', 'observacao'];
  const sets = []; const vals = [];
  for (const c of campos) {
    if (req.body[c] !== undefined) { sets.push(`${c} = ?`); vals.push(req.body[c] === '' ? null : req.body[c]); }
  }
  if (!sets.length) return res.status(400).json({ erro: 'Nenhum campo para atualizar.' });
  vals.push(req.params.id, padaria_id);
  await db.query(`UPDATE encomendas SET ${sets.join(', ')} WHERE id = ? AND padaria_id = ?`, vals);
  res.json({ ok: true });
};

// Muda o status (pendente → producao → pronta → entregue), ou cancela
exports.mudarStatus = async (req, res) => {
  const padaria_id = req.padaria.id;
  const status = String(req.body.status || '').trim();
  const validos = ['pendente', 'producao', 'pronta', 'entregue', 'cancelada'];
  if (!validos.includes(status)) return res.status(400).json({ erro: 'Status inválido.' });

  const [[encomenda]] = await db.query(
    `SELECT id FROM encomendas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]
  );
  if (!encomenda) return res.status(404).json({ erro: 'Encomenda não encontrada.' });

  await db.query(`UPDATE encomendas SET status = ? WHERE id = ?`, [status, encomenda.id]);
  res.json({ ok: true });
};

exports.excluir = async (req, res) => {
  const padaria_id = req.padaria.id;
  await db.query(`DELETE FROM encomendas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]);
  res.json({ ok: true });
};
