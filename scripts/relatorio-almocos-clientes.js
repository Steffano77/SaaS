// Gera um PDF com o consumo "Faturado" (almoço/consumo lançado) de clientes de
// verdade (empresas cadastradas em Clientes Faturado) nos últimos 30 dias —
// pra mandar pro patrão. Não inclui funcionários nem compras sem cadastro
// formal (só dá pra confiar no documento de quem está cadastrado como cliente).
//
// Uso (últimos 30 dias, padrão):
//   node scripts\relatorio-almocos-clientes.js
//
// Período escolhido:
//   node scripts\relatorio-almocos-clientes.js 2026-10-01 2026-10-30
//
// Sai um arquivo relatorio-almocos-clientes_AAAA-MM-DD_a_AAAA-MM-DD.pdf
// dentro de scripts\. Abre ele e manda pro patrão.
require('dotenv').config();
const fs = require('fs');
const path = require('path');
const PDFDocument = require('pdfkit');
const db = require('../src/database/connection');

function formatarData(d) {
  const p = n => String(n).padStart(2, '0');
  return `${p(d.getUTCDate())}/${p(d.getUTCMonth() + 1)}/${d.getUTCFullYear()}`;
}
function formatarMoeda(v) {
  return 'R$ ' + Number(v).toFixed(2).replace('.', ',');
}

(async () => {
  const args = process.argv.slice(2);
  let fim = args[1] || new Date().toISOString().slice(0, 10);
  let inicio = args[0];
  if (!inicio) {
    const d = new Date(fim + 'T00:00:00Z');
    d.setUTCDate(d.getUTCDate() - 30);
    inicio = d.toISOString().slice(0, 10);
  }
  if (!/^\d{4}-\d{2}-\d{2}$/.test(inicio) || !/^\d{4}-\d{2}-\d{2}$/.test(fim)) {
    console.log('Uso: node scripts\\relatorio-almocos-clientes.js [2026-10-01] [2026-10-30]');
    process.exit(1);
  }

  const [linhas] = await db.query(`
    SELECT cf.nome AS cliente, cp.cliente_documento AS documento, c.identificador AS comanda,
      c.fechada_em AS data_consumo,
      (SELECT GROUP_CONCAT(CONCAT(
         TRIM(TRAILING '.' FROM TRIM(TRAILING '0' FROM CAST(i.quantidade AS CHAR))),
         'x ', i.nome_produto) SEPARATOR ', ')
       FROM itens_comanda i WHERE i.comanda_id = c.id) AS itens,
      cp.valor
    FROM comanda_pagamentos cp
    JOIN comandas c ON c.id = cp.comanda_id
    JOIN clientes_faturado cf ON cf.cnpj = cp.cliente_documento AND cf.padaria_id = c.padaria_id AND cf.tipo = 'empresa'
    WHERE cp.forma_pagamento = 'Faturado' AND c.fechada_em >= ? AND c.fechada_em < DATE_ADD(?, INTERVAL 1 DAY)
    ORDER BY cliente, data_consumo
  `, [inicio, fim]);

  if (!linhas.length) {
    console.log(`Nenhum consumo de cliente (empresa) de ${inicio} até ${fim}.`);
    await db.end();
    return;
  }

  const porCliente = {};
  for (const l of linhas) {
    if (!porCliente[l.cliente]) porCliente[l.cliente] = { documento: l.documento, linhas: [], total: 0 };
    porCliente[l.cliente].linhas.push(l);
    porCliente[l.cliente].total += Number(l.valor);
  }

  const nomeArquivo = `relatorio-almocos-clientes_${inicio}_a_${fim}.pdf`;
  const caminho = path.join(__dirname, nomeArquivo);
  const doc = new PDFDocument({ margin: 50, size: 'A4' });
  const stream = fs.createWriteStream(caminho);
  doc.pipe(stream);

  doc.fontSize(18).font('Helvetica-Bold').text('Consumo Faturado de Clientes', { align: 'center' });
  doc.fontSize(11).font('Helvetica').fillColor('#555')
    .text(`Período: ${formatarData(new Date(inicio + 'T00:00:00Z'))} até ${formatarData(new Date(fim + 'T00:00:00Z'))}`, { align: 'center' });
  doc.moveDown(1);
  doc.fillColor('#000');

  let totalGeral = 0;
  for (const [nomeCliente, dados] of Object.entries(porCliente)) {
    if (doc.y > 680) doc.addPage();
    doc.fontSize(13).font('Helvetica-Bold').text(nomeCliente);
    doc.fontSize(9).font('Helvetica').fillColor('#555').text(`Documento: ${dados.documento}`);
    doc.fillColor('#000');
    doc.moveDown(0.3);

    for (const l of dados.linhas) {
      if (doc.y > 700) doc.addPage();
      const dataTxt = formatarData(l.data_consumo);
      const linhaTxt = `${dataTxt} — Comanda ${l.comanda} — ${l.itens || '(sem itens registrados)'}`;
      doc.fontSize(10).font('Helvetica').text(linhaTxt, { width: 430, continued: false });
      doc.font('Helvetica-Bold').text(formatarMoeda(l.valor), 480, doc.y - doc.currentLineHeight(), { width: 65, align: 'right' });
      doc.moveDown(0.15);
    }

    doc.moveDown(0.2);
    doc.fontSize(10).font('Helvetica-Bold').text(`Subtotal ${nomeCliente}: ${formatarMoeda(dados.total)}`, { align: 'right' });
    doc.moveDown(0.6);
    doc.moveTo(50, doc.y).lineTo(545, doc.y).strokeColor('#ccc').stroke();
    doc.moveDown(0.6);
    totalGeral += dados.total;
  }

  if (doc.y > 680) doc.addPage();
  doc.moveDown(0.5);
  doc.fontSize(14).font('Helvetica-Bold').text(`TOTAL GERAL: ${formatarMoeda(totalGeral)}`, { align: 'right' });

  doc.end();
  await new Promise((resolve, reject) => {
    stream.on('finish', resolve);
    stream.on('error', reject);
  });
  console.log(`\n✅ PDF gerado: ${caminho}`);
  console.log(`   ${linhas.length} lançamento(s) de ${Object.keys(porCliente).length} cliente(s), total ${formatarMoeda(totalGeral)}`);
  await db.end();
})().catch(e => { console.error('Erro:', e.message); process.exit(1); });
