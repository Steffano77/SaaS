const db = require('../database/connection');

// Só dígitos — pra comparar CNPJ digitado/bipado sem depender de máscara igual.
function limparCnpj(cnpj) {
  return String(cnpj || '').replace(/\D/g, '');
}

function formatarCnpj(cnpj) {
  const d = limparCnpj(cnpj);
  if (d.length !== 14) return cnpj;
  return `${d.slice(0, 2)}.${d.slice(2, 5)}.${d.slice(5, 8)}/${d.slice(8, 12)}-${d.slice(12, 14)}`;
}

exports.listar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [clientes] = await db.query(
    `SELECT * FROM clientes_faturado WHERE padaria_id = ? ORDER BY nome`, [padaria_id]
  );
  res.json(clientes);
};

// Busca por CNPJ — usado na hora de cobrar em "Faturado", pra já preencher o nome sozinho.
exports.buscarPorCnpj = async (req, res) => {
  const padaria_id = req.padaria.id;
  const cnpjLimpo = limparCnpj(req.params.cnpj);
  if (cnpjLimpo.length !== 14) return res.status(400).json({ erro: 'CNPJ inválido — precisa ter 14 números.' });
  const [[cliente]] = await db.query(
    `SELECT * FROM clientes_faturado WHERE padaria_id = ? AND cnpj = ?`, [padaria_id, cnpjLimpo]
  );
  if (!cliente) return res.status(404).json({ erro: 'Nenhum cliente cadastrado com esse CNPJ.' });
  res.json(cliente);
};

exports.criar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const nome = String(req.body.nome || '').trim();
  const cnpjLimpo = limparCnpj(req.body.cnpj);
  const endereco = String(req.body.endereco || '').trim() || null;
  const telefone = String(req.body.telefone || '').trim() || null;

  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });
  if (cnpjLimpo.length !== 14) return res.status(400).json({ erro: 'CNPJ inválido — precisa ter 14 números.' });

  const [[existe]] = await db.query(
    `SELECT id FROM clientes_faturado WHERE padaria_id = ? AND cnpj = ?`, [padaria_id, cnpjLimpo]
  );
  if (existe) return res.status(400).json({ erro: 'Já existe um cliente cadastrado com esse CNPJ.' });

  const [r] = await db.query(
    `INSERT INTO clientes_faturado (padaria_id, cnpj, nome, endereco, telefone) VALUES (?,?,?,?,?)`,
    [padaria_id, cnpjLimpo, nome, endereco, telefone]
  );
  res.status(201).json({ id: r.insertId, cnpj: cnpjLimpo, nome, endereco, telefone });
};

exports.atualizar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const nome = String(req.body.nome || '').trim();
  const endereco = String(req.body.endereco || '').trim() || null;
  const telefone = String(req.body.telefone || '').trim() || null;
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });

  await db.query(
    `UPDATE clientes_faturado SET nome = ?, endereco = ?, telefone = ? WHERE id = ? AND padaria_id = ?`,
    [nome, endereco, telefone, req.params.id, padaria_id]
  );
  res.json({ ok: true });
};

exports.remover = async (req, res) => {
  const padaria_id = req.padaria.id;
  await db.query(`DELETE FROM clientes_faturado WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]);
  res.json({ ok: true });
};

exports.formatarCnpj = formatarCnpj;
