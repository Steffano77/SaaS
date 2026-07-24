const ExcelJS = require('exceljs');
const db      = require('../database/connection');
const fs      = require('fs');

// Colunas esperadas na planilha Saurus
const COL_EAN   = 'cEAN';
const COL_SALDO = 'qSaldo';
const COL_NOME  = 'xProd';

function isEAN(cod) {
  return cod && /^\d{8,14}$/.test(String(cod).trim());
}

async function parseSaurus(filePath) {
  const wb = new ExcelJS.Workbook();
  await wb.xlsx.readFile(filePath);
  const ws = wb.worksheets[0];

  // Encontra linha de cabeçalho (primeira linha que contém qSaldo)
  let headerRow = null;
  let headerIdx = 0;
  ws.eachRow((row, i) => {
    if (headerRow) return;
    const vals = [];
    row.eachCell(c => vals.push(String(c.value ?? '').trim()));
    if (vals.includes(COL_SALDO)) { headerRow = vals; headerIdx = i; }
  });

  if (!headerRow) throw new Error('Coluna qSaldo não encontrada na planilha.');

  const idxEan   = headerRow.indexOf(COL_EAN);
  const idxSaldo = headerRow.indexOf(COL_SALDO);
  const idxNome  = headerRow.indexOf(COL_NOME);

  const itens = [];
  ws.eachRow((row, i) => {
    if (i <= headerIdx) return;
    const get = (idx) => idx === -1 ? '' : String(row.getCell(idx + 1).value ?? '').trim();
    const ean   = get(idxEan);
    const nome  = get(idxNome);
    const saldo = parseFloat(get(idxSaldo).replace(',', '.')) || 0;
    if (saldo <= 0) return;
    itens.push({ ean: isEAN(ean) ? ean : null, nome, saldo });
  });

  return itens;
}

// Preview — lê o Excel e retorna o que será atualizado
exports.preview = async (req, res) => {
  if (!req.file) return res.status(400).json({ erro: 'Arquivo não enviado.' });
  const filePath = req.file.path;
  try {
    const itens = await parseSaurus(filePath);
    const padaria_id = req.padaria.id;
    const preview = [];

    for (const item of itens) {
      let prod = null;

      if (item.ean) {
        const [rows] = await db.query(
          'SELECT id, nome, estoque_atual, unidade FROM produtos WHERE padaria_id = ? AND codigo_barras = ? AND ativo = 1',
          [padaria_id, item.ean]
        );
        if (rows.length) prod = rows[0];
      }

      if (!prod && item.nome) {
        const [rows] = await db.query(
          'SELECT id, nome, estoque_atual, unidade FROM produtos WHERE padaria_id = ? AND nome = ? AND ativo = 1',
          [padaria_id, item.nome]
        );
        if (rows.length) prod = rows[0];
      }

      if (!prod) continue; // ignora produtos não cadastrados

      preview.push({
        id: prod.id,
        nome: prod.nome,
        unidade: prod.unidade,
        estoque_atual: parseFloat(prod.estoque_atual || 0),
        novo_estoque: item.saldo,
      });
    }

    res.json({ preview, total_planilha: itens.length, total_encontrados: preview.length });
  } catch (e) {
    console.error('Erro preview Saurus:', e);
    res.status(400).json({ erro: e.message || 'Erro ao ler planilha.' });
  } finally {
    fs.unlink(filePath, () => {});
  }
};

// Confirmar — aplica as atualizações
exports.confirmar = async (req, res) => {
  const { itens } = req.body; // [{id, novo_estoque}]
  if (!itens || !itens.length) return res.status(400).json({ erro: 'Nenhum item para atualizar.' });

  const padaria_id = req.padaria.id;
  let atualizados = 0;

  for (const item of itens) {
    const novo = parseFloat(item.novo_estoque);
    if (isNaN(novo) || novo < 0) continue;

    const [[prod]] = await db.query(
      'SELECT id, estoque_atual, custo_unitario FROM produtos WHERE id = ? AND padaria_id = ? AND ativo = 1',
      [item.id, padaria_id]
    );
    if (!prod) continue;

    await db.query(
      'UPDATE produtos SET estoque_atual = ? WHERE id = ? AND padaria_id = ?',
      [novo, item.id, padaria_id]
    );

    await db.query(
      `INSERT INTO movimentacoes (padaria_id, produto_id, tipo, quantidade, custo_unit, observacao, data)
       VALUES (?, ?, 'sync_saurus', ?, ?, ?, NOW())`,
      [padaria_id, item.id, novo, prod.custo_unitario || 0,
       `Atualização Saurus — ${new Date().toLocaleDateString('pt-BR')}`]
    );

    atualizados++;
  }

  res.json({ ok: true, atualizados });
};
