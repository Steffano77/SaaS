const db = require('../database/connection');

exports.listar = async (req, res) => {
  try {
    const { busca, categoria_id, alerta } = req.query;
    let sql = `
      SELECT p.*, c.nome AS categoria, f.nome AS fornecedor_nome,
        (SELECT MAX(pc.criado_em)
         FROM pedidos_compra pc
         JOIN itens_pedido ip ON ip.pedido_id = pc.id
         WHERE pc.padaria_id = p.padaria_id AND ip.produto_id = p.id AND pc.status = 'recebido'
        ) AS ultima_compra
      FROM produtos p
      LEFT JOIN categorias c ON c.id = p.categoria_id
      LEFT JOIN fornecedores f ON f.id = p.fornecedor_id
      WHERE p.padaria_id = ? AND p.ativo = 1`;
    const params = [req.padaria.id];

    if (busca) { sql += ' AND (p.nome LIKE ? OR p.codigo_barras LIKE ?)'; params.push(`%${busca}%`, `%${busca}%`); }
    if (categoria_id) { sql += ' AND p.categoria_id = ?'; params.push(categoria_id); }
    if (alerta === 'minimo')   sql += ' AND p.estoque_minimo > 0 AND p.estoque_atual > 0 AND p.estoque_atual <= p.estoque_minimo';
    if (alerta === 'zerado')   sql += ' AND p.estoque_atual <= 0';
    if (alerta === 'validade') sql += ' AND p.validade IS NOT NULL AND p.validade <= DATE_ADD(CURDATE(), INTERVAL 10 DAY)';

    sql += ' ORDER BY p.estoque_atual <= 0 ASC, p.estoque_atual <= p.estoque_minimo ASC, p.nome';
    const [rows] = await db.query(sql, params);
    res.json(rows.map(formatarProduto));
  } catch (e) {
    console.error('Erro ao listar produtos:', e);
    res.status(500).json({ erro: 'Erro interno.' });
  }
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
  try {
    const [rows] = await db.query(
      `SELECT p.*, c.nome AS categoria FROM produtos p
       LEFT JOIN categorias c ON c.id = p.categoria_id
       WHERE p.id = ? AND p.padaria_id = ?`,
      [req.params.id, req.padaria.id]
    );
    if (!rows.length) return res.status(404).json({ erro: 'Produto não encontrado.' });
    res.json(formatarProduto(rows[0]));
  } catch (e) {
    console.error('Erro ao buscar produto:', e);
    res.status(500).json({ erro: 'Erro interno.' });
  }
};

const LIMITES_PLANO = { essencial: 50, pro: Infinity, premium: Infinity };

exports.criar = async (req, res) => {
  try {
    const { codigo_barras, nome, unidade, categoria_id, fornecedor_id, custo_unitario,
            preco_venda, estoque_atual, estoque_minimo, validade } = req.body;
    if (!nome) return res.status(400).json({ erro: 'Nome é obrigatório.' });

    // Verifica limite do plano
    const [[padaria]] = await db.query('SELECT plano FROM padarias WHERE id = ?', [req.padaria.id]);
    const limite = LIMITES_PLANO[padaria?.plano] ?? 50;
    if (limite !== Infinity) {
      const [[{ total }]] = await db.query('SELECT COUNT(*) AS total FROM produtos WHERE padaria_id = ? AND ativo = 1', [req.padaria.id]);
      if (total >= limite) return res.status(403).json({ erro: `limite_plano`, limite, plano: padaria.plano });
    }

    const [result] = await db.query(
      `INSERT INTO produtos (padaria_id, categoria_id, fornecedor_id, codigo_barras, nome, unidade,
        custo_unitario, preco_venda, estoque_atual, estoque_minimo, validade)
       VALUES (?,?,?,?,?,?,?,?,?,?,?)`,
      [req.padaria.id, categoria_id || null, fornecedor_id || null, codigo_barras || null, nome,
       unidade || 'UNIDADE', custo_unitario || 0, preco_venda || 0,
       estoque_atual || 0, estoque_minimo || 0, validade || null]
    );
    const [novo] = await db.query('SELECT * FROM produtos WHERE id = ?', [result.insertId]);
    res.status(201).json(novo[0]);
  } catch (e) {
    console.error('Erro ao criar produto:', e);
    res.status(500).json({ erro: 'Erro interno ao criar produto.' });
  }
};

exports.atualizar = async (req, res) => {
  try {
    const campos = ['codigo_barras','nome','unidade','categoria_id','fornecedor_id',
                    'custo_unitario','preco_venda','estoque_atual','estoque_minimo','validade','ultima_compra'];
    const sets = []; const vals = [];
    for (const c of campos) {
      if (req.body[c] !== undefined) { sets.push(`${c} = ?`); vals.push(req.body[c]); }
    }
    if (!sets.length) return res.status(400).json({ erro: 'Nenhum campo para atualizar.' });
    vals.push(req.params.id, req.padaria.id);
    await db.query(`UPDATE produtos SET ${sets.join(', ')} WHERE id = ? AND padaria_id = ?`, vals);
    res.json({ ok: true });
  } catch (e) {
    console.error('Erro ao atualizar produto:', e);
    res.status(500).json({ erro: 'Erro interno ao atualizar produto.' });
  }
};

exports.remover = async (req, res) => {
  try {
    await db.query('UPDATE produtos SET ativo = 0 WHERE id = ? AND padaria_id = ?',
      [req.params.id, req.padaria.id]);
    res.json({ ok: true });
  } catch (e) {
    console.error('Erro ao remover produto:', e);
    res.status(500).json({ erro: 'Erro interno.' });
  }
};

exports.dashboard = async (req, res) => {
  try {
    const pid = req.padaria.id;
    const [[kpis]] = await db.query(`
      SELECT
        COUNT(*) AS total_produtos,
        COALESCE(SUM(estoque_atual <= 0), 0) AS zerados,
        COALESCE(SUM(estoque_atual > 0 AND estoque_minimo > 0 AND estoque_atual <= estoque_minimo), 0) AS abaixo_minimo,
        COALESCE(SUM(validade IS NOT NULL AND validade <= DATE_ADD(CURDATE(), INTERVAL 10 DAY) AND estoque_atual > 0), 0) AS vencendo,
        COALESCE(SUM(estoque_atual * custo_unitario), 0) AS valor_total_estoque
      FROM produtos WHERE padaria_id = ? AND ativo = 1`, [pid]);

    const [repor] = await db.query(`
      SELECT nome, codigo_barras, estoque_atual, estoque_minimo,
             GREATEST(0, estoque_minimo - estoque_atual) AS falta, unidade
      FROM produtos WHERE padaria_id = ? AND ativo = 1
        AND (estoque_atual <= 0 OR estoque_atual <= estoque_minimo)
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
      SELECT COALESCE(SUM(valor_total), 0) AS total_saidas_15d,
             COUNT(*) AS qtd_saidas_30d
      FROM movimentacoes
      WHERE padaria_id = ? AND tipo = 'saida'
        AND data >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)`, [pid]);

    const [[margemKpi]] = await db.query(`
      SELECT
        AVG((preco_venda - custo_unitario) / preco_venda * 100) AS margem_media,
        AVG(custo_unitario) AS cmv_medio,
        COUNT(*) AS qtd_com_preco
      FROM produtos
      WHERE padaria_id = ? AND ativo = 1 AND preco_venda > 0 AND custo_unitario > 0`, [pid]);

    res.json({ kpis: { ...kpis, total_saidas_15d: parseFloat(saidas15d.total_saidas_15d || 0), qtd_saidas_30d: parseInt(saidas15d.qtd_saidas_30d || 0), margem_media: parseFloat(margemKpi.margem_media || 0), cmv_medio: parseFloat(margemKpi.cmv_medio || 0), qtd_com_preco: parseInt(margemKpi.qtd_com_preco || 0) }, repor, vencendo, movimentacoes_recentes: movs });
  } catch (e) {
    console.error('Erro ao carregar dashboard:', e);
    res.status(500).json({ erro: 'Erro interno ao carregar painel.' });
  }
};
