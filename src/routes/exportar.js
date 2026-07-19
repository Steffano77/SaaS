const router  = require('express').Router();
const auth    = require('../middleware/auth');
const wrap    = require('../utils/wrap');
const db      = require('../database/connection');
const ExcelJS = require('exceljs');

router.get('/produtos', auth, wrap(async (req, res) => {
  const [rows] = await db.query(`
    SELECT p.nome, p.codigo_barras, p.unidade, c.nome AS categoria,
           f.nome AS fornecedor, p.estoque_atual, p.estoque_minimo,
           p.custo_unitario, p.preco_venda, p.validade
    FROM produtos p
    LEFT JOIN categorias c ON c.id = p.categoria_id
    LEFT JOIN fornecedores f ON f.id = p.fornecedor_id
    WHERE p.padaria_id = ? AND p.ativo = 1 ORDER BY p.nome`,
    [req.padaria.id]
  );

  const wb = new ExcelJS.Workbook();
  const ws = wb.addWorksheet('Produtos');
  ws.columns = [
    { header: 'Nome',           key: 'nome',           width: 30 },
    { header: 'Código de barras', key: 'codigo_barras', width: 18 },
    { header: 'Unidade',        key: 'unidade',        width: 10 },
    { header: 'Categoria',      key: 'categoria',      width: 18 },
    { header: 'Fornecedor',     key: 'fornecedor',     width: 22 },
    { header: 'Estoque atual',  key: 'estoque_atual',  width: 14 },
    { header: 'Estoque mínimo', key: 'estoque_minimo', width: 15 },
    { header: 'Custo unitário', key: 'custo_unitario', width: 14 },
    { header: 'Preço de venda', key: 'preco_venda',    width: 14 },
    { header: 'Validade',       key: 'validade',       width: 12 },
  ];
  ws.getRow(1).font = { bold: true };
  rows.forEach(r => ws.addRow(r));

  res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
  res.setHeader('Content-Disposition', 'attachment; filename="produtos.xlsx"');
  await wb.xlsx.write(res);
  res.end();
}));

router.get('/movimentacoes', auth, wrap(async (req, res) => {
  const mes = req.query.mes || new Date().toISOString().slice(0, 7);
  const [rows] = await db.query(`
    SELECT m.data, m.tipo, p.nome AS produto, m.quantidade, p.unidade,
           m.custo_unit, m.valor_total, m.observacao
    FROM movimentacoes m
    JOIN produtos p ON p.id = m.produto_id
    WHERE m.padaria_id = ? AND DATE_FORMAT(m.data, '%Y-%m') = ?
    ORDER BY m.data DESC`,
    [req.padaria.id, mes]
  );

  const wb = new ExcelJS.Workbook();
  const ws = wb.addWorksheet('Movimentações');
  ws.columns = [
    { header: 'Data',       key: 'data',        width: 18 },
    { header: 'Tipo',       key: 'tipo',        width: 12 },
    { header: 'Produto',    key: 'produto',     width: 28 },
    { header: 'Quantidade', key: 'quantidade',  width: 12 },
    { header: 'Unidade',    key: 'unidade',     width: 10 },
    { header: 'Custo unit.',key: 'custo_unit',  width: 12 },
    { header: 'Total',      key: 'valor_total', width: 12 },
    { header: 'Observação', key: 'observacao',  width: 28 },
  ];
  ws.getRow(1).font = { bold: true };
  rows.forEach(r => ws.addRow(r));

  res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
  res.setHeader('Content-Disposition', `attachment; filename="movimentacoes-${mes}.xlsx"`);
  await wb.xlsx.write(res);
  res.end();
}));

module.exports = router;
