const ExcelJS = require('exceljs');
const db      = require('../database/connection');
const fs      = require('fs');

exports.importarSaurus = async (req, res) => {
  if (!req.file) return res.status(400).json({ erro: 'Arquivo não enviado.' });

  const padaria_id = req.padaria.id;
  const filePath   = req.file.path;

  try {
    const wb = new ExcelJS.Workbook();
    await wb.xlsx.readFile(filePath);
    const ws = wb.worksheets[0];

    // Mapear cabeçalhos
    const headers = {};
    ws.getRow(1).eachCell((cell, col) => { headers[String(cell.value).trim()] = col; });

    const colCod   = headers['pro_codProduto'];
    const colDesc  = headers['pro_descProduto'];
    const colSaldo = headers['qSaldo'];
    const colVenda = headers['pro_vProd'];
    const colCusto = headers['vCustoProd'] || headers['pro_vCusto'];
    const colCat   = headers['pro_descCategoria'];
    const colMed   = headers['pro_descMedida'];

    let atualizados = 0, criados = 0, ignorados = 0, balcaoAtualizados = 0, balcaoCriados = 0;

    // Coluna de loja (Saurus exporta com codLoja ou cod_loja)
    const colLoja = headers['codLoja'] || headers['cod_loja'] || headers['loja'] || headers['pro_codLoja'] || null;
    const filtroLoja = req.body.loja ? String(req.body.loja).trim() : null;

    const rows = [];
    ws.eachRow((row, i) => { if (i > 1) rows.push(row); });

    for (const row of rows) {
      const cod   = String(row.getCell(colCod).value  || '').trim();
      const nome  = String(row.getCell(colDesc).value || '').trim();
      const saldo = parseFloat(row.getCell(colSaldo).value) || 0;
      const custo = parseFloat(row.getCell(colCusto).value) || 0;
      const venda = parseFloat(row.getCell(colVenda).value) || 0;
      const cat   = String(row.getCell(colCat).value  || '').trim();
      const med   = String(row.getCell(colMed).value  || 'UNIDADE').trim();

      if (!nome) { ignorados++; continue; }

      // Filtra por loja se solicitado
      if (filtroLoja && colLoja) {
        const lojaRow = String(row.getCell(colLoja).value || '').trim();
        if (lojaRow !== filtroLoja) { ignorados++; continue; }
      }

      const isEAN13   = /^\d{13}$/.test(cod);
      const isBalcao  = !isEAN13 && /^\d{1,4}$/.test(cod); // código curto = item de balcão (chapa, esfiha, pastel...)
      if (!isEAN13 && !isBalcao) { ignorados++; continue; }

      // Busca categoria
      let [catRows] = await db.query(
        'SELECT id FROM categorias WHERE padaria_id = ? AND nome = ?', [padaria_id, cat]
      );
      let categoria_id = null;
      if (catRows.length) {
        categoria_id = catRows[0].id;
      } else if (cat) {
        const [r] = await db.query('INSERT INTO categorias (padaria_id, nome) VALUES (?,?)', [padaria_id, cat]);
        categoria_id = r.insertId;
      }

      if (isEAN13) {
        // Produtos de mercado — segue a lógica original: ignora saldo ≤ 0, controla estoque pelo EAN
        if (saldo <= 0) { ignorados++; continue; }

        const [existe] = await db.query(
          'SELECT id, estoque_atual FROM produtos WHERE padaria_id = ? AND codigo_barras = ?',
          [padaria_id, cod]
        );

        if (existe.length) {
          const anterior = parseFloat(existe[0].estoque_atual);
          const diff     = anterior - saldo;

          await db.query(
            `UPDATE produtos SET estoque_atual = ?, custo_unitario = IF(? > 0, ?, custo_unitario),
             preco_venda = IF(? > 0, ?, preco_venda), categoria_id = COALESCE(?, categoria_id), unidade = ?
             WHERE id = ?`,
            [saldo, custo, custo, venda, venda, categoria_id, med, existe[0].id]
          );

          if (diff !== 0) {
            await db.query(
              'INSERT INTO movimentacoes (padaria_id, produto_id, tipo, quantidade, custo_unit, observacao) VALUES (?,?,?,?,?,?)',
              [padaria_id, existe[0].id, 'sync_saurus', Math.abs(diff), custo,
               `Sync Saurus — ${new Date().toLocaleString('pt-BR')}`]
            );
          }
          atualizados++;
        } else {
          const [r] = await db.query(
            `INSERT INTO produtos (padaria_id, categoria_id, codigo_barras, nome, unidade,
             custo_unitario, preco_venda, estoque_atual)
             VALUES (?,?,?,?,?,?,?,?)`,
            [padaria_id, categoria_id, cod, nome, med, custo, venda, saldo]
          );
          if (saldo > 0) {
            await db.query(
              'INSERT INTO movimentacoes (padaria_id, produto_id, tipo, quantidade, custo_unit, observacao) VALUES (?,?,?,?,?,?)',
              [padaria_id, r.insertId, 'entrada', saldo, custo, 'Importação inicial Saurus']
            );
          }
          criados++;
        }
      } else {
        // Itens de balcão (feitos na hora) — código curto sem EAN. Não têm controle de estoque
        // real no Saurus (saldo costuma vir negativo/zerado), então aqui só cadastramos/atualizamos
        // nome e preço de venda, sem mexer em estoque nem gerar movimentação.
        const [existe] = await db.query(
          'SELECT id FROM produtos WHERE padaria_id = ? AND LOWER(nome) = LOWER(?)',
          [padaria_id, nome]
        );

        if (existe.length) {
          await db.query(
            `UPDATE produtos SET custo_unitario = IF(? > 0, ?, custo_unitario),
             preco_venda = IF(? > 0, ?, preco_venda), categoria_id = COALESCE(?, categoria_id),
             codigo_barras = ?
             WHERE id = ?`,
            [custo, custo, venda, venda, categoria_id, cod, existe[0].id]
          );
          balcaoAtualizados++;
        } else {
          await db.query(
            `INSERT INTO produtos (padaria_id, categoria_id, codigo_barras, nome, unidade,
             custo_unitario, preco_venda, estoque_atual, ativo)
             VALUES (?,?,?,?,?,?,?,0,1)`,
            [padaria_id, categoria_id, cod, nome, med || 'un', custo, venda]
          );
          balcaoCriados++;
        }
      }
    }

    res.json({ ok: true, atualizados, criados, ignorados, balcaoAtualizados, balcaoCriados });
  } finally {
    fs.unlink(filePath, () => {});
  }
};
