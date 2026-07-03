const db = require('../database/connection');

exports.listar = async (req, res) => {
  const { busca, categoria_id, alerta } = req.query;
  let sql = `
    SELECT p.*, c.nome AS categoria
    FROM produtos p
    LEFT JOIN categorias c ON c.id = p.categoria_id
    WHERE p.padaria_id = ? AND p.ativo = 1`;
  const params = [req.padaria.id];

  if (busca) { sql += ' AND (p.nome LIKE ? OR p.codigo_barras LIKE ?)'; params.push(`%${busca}%`, `%${busca}%`); }
  if (categoria_id) { sql += ' AND p.categoria_id = ?'; params.push(categoria_id); }
  if (alerta === 'minimo')   sql += ' AND p.estoque_minimo > 0 AND p.estoque_atual > 0 AND p.estoque_atual < p.estoque_minimo';
  if (alerta === 'zerado')   sql += ' AND p.estoque_atual <= 0';
  if (alerta === 'validade') sql += ' AND p.validade IS NOT NULL AND p.validade <= DATE_ADD(CURDATE(), INTERVAL 10 DAY)';

  sql += ' ORDER BY p.estoque_atual <= 0 DESC, p.estoque_atual < p.estoque_minimo DESC, p.nome';
  const [rows] = await db.query(sql, params);
  res.json(rows.map(formatarProduto));
};

function formatarProduto(p) {
  return {
    ...p,
    estoque_atual:  parseFloat(p.estoque_atual  || 0),
    estoque_minimo: Math.round(parseFloat(p.estoque_minimo || 0)),
    custo_unitario: parseFloat(parseFloat(p.custo_unitario || 0).toFixed(2)),
    preco_venda:    parseFloat(parseFloat(p.preco_venda    || 0).toFixed(2)),
  };
}

exports.buscar = async (req, res) => {
  const [rows] = await db.query(
    `SELECT p.*, c.nome AS categoria FROM produtos p
     LEFT JOIN categorias c ON c.id = p.categoria_id
     WHERE p.id = ? AND p.padaria_id = ?`,
    [req.params.id, req.padaria.id]
  );
  if (!rows.length) return res.status(404).json({ erro: 'Produto não encontrado.' });
  res.json(formatarProduto(rows[0]));
};

exports.criar = async (req, res) => {
  const { codigo_barras, nome, unidade, categoria_id, custo_unitario, preco_venda,
          estoque_atual, estoque_minimo, validade } = req.body;
  if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });

  const [result] = await db.query(
    `INSERT INTO produtos (padaria_id, categoria_id, codigo_barras, nome, unidade,
      custo_unitario, preco_venda, estoque_atual, estoque_minimo, validade)
     VALUES (?,?,?,?,?,?,?,?,?,?)`,
    [req.padaria.id, categoria_id || null, codigo_barras || null, nome,
     unidade || 'UNIDADE', custo_unitario || 0, preco_venda || 0,
     estoque_atual || 0, estoque_minimo || 0, validade || null]
  );
  const [novo] = await db.query('SELECT * FROM produtos WHERE id = ?', [result.insertId]);
  res.status(201).json(novo[0]);
};

exports.atualizar = async (req, res) => {
  const campos = ['codigo_barras','nome','unidade','categoria_id','custo_unitario',
                  'preco_venda','estoque_minimo','validade'];
  const sets = []; const vals = [];
  for (const c of campos) {
    if (req.body[c] !== undefined) { sets.push(`${c} = ?`); vals.push(req.body[c]); }
  }
  if (!sets.length) return res.status(400).json({ erro: 'Nenhum campo para atualizar.' });
  vals.push(req.params.id, req.padaria.id);
  await db.query(`UPDATE produtos SET ${sets.join(', ')} WHERE id = ? AND padaria_id = ?`, vals);
  res.json({ ok: true });
};

exports.remover = async (req, res) => {
  await db.query('UPDATE produtos SET ativo = 0 WHERE id = ? AND padaria_id = ?',
    [req.params.id, req.padaria.id]);
  res.json({ ok: true });
};

exports.dashboard = async (req, res) => {
  const pid = req.padaria.id;
  const [[kpis]] = await db.query(`
    SELECT
      COUNT(*) AS total_produtos,
      COALESCE(SUM(estoque_atual <= 0), 0) AS zerados,
      COALESCE(SUM(estoque_atual > 0 AND estoque_minimo > 0 AND estoque_atual < estoque_minimo), 0) AS abaixo_minimo,
      COALESCE(SUM(validade IS NOT NULL AND validade <= DATE_ADD(CURDATE(), INTERVAL 10 DAY) AND estoque_atual > 0), 0) AS vencendo,
      COALESCE(SUM(estoque_atual * custo_unitario), 0) AS valor_total_estoque
    FROM produtos WHERE padaria_id = ? AND ativo = 1`, [pid]);

  const [repor] = await db.query(`
    SELECT nome, codigo_barras, estoque_atual, estoque_minimo,
           GREATEST(0, estoque_minimo - estoque_atual) AS falta, unidade
    FROM produtos WHERE padaria_id = ? AND ativo = 1
      AND (estoque_atual <= 0 OR estoque_atual < estoque_minimo)
    ORDER BY estoque_atual <= 0 DESC, falta DESC LIMIT 20`, [pid]);

  const [vencendo] = await db.query(`
    SELECT nome, codigo_barras, estoque_atual, unidade, validade,
           DATEDIFF(validade, CURDATE()) AS dias_restantes
    FROM produtos WHERE padaria_id = ? AND ativo = 1
      AND validade IS NOT NULL AND validade <= DATE_ADD(CURDATE(), INTERVAL 10 DAY)
    ORDER BY validade ASC LIMIT 20`, [pid]);

  const [movs] = await db.query(`
    SELECT m.tipo, m.quantidade, m.data, p.nome AS produto
    FROM movimentacoes m JOIN produtos p ON p.id = m.produto_id
    WHERE m.padaria_id = ? ORDER BY m.data DESC LIMIT 10`, [pid]);

  const [[saidas15d]] = await db.query(`
    SELECT COALESCE(SUM(valor_total), 0) AS total_saidas_15d
    FROM movimentacoes
    WHERE padaria_id = ? AND tipo = 'saida'
      AND data >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)`, [pid]);

  res.json({ kpis: { ...kpis, total_saidas_15d: parseFloat(saidas15d.total_saidas_15d || 0) }, repor, vencendo, movimentacoes_recentes: movs });
};
