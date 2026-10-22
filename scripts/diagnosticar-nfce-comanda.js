// Mostra tudo de uma comanda com nota rejeitada (itens, pagamentos e tentativas de NFC-e)
// pra diagnosticar rejeições como 704/865 sem precisar do mysql.exe.
// Uso: node scripts\diagnosticar-nfce-comanda.js "C57 07:15" 2026-10-21
require('dotenv').config();
const db = require('../src/database/connection');

(async () => {
  const trecho = process.argv[2];
  const dia = process.argv[3];
  if (!trecho || !dia) { console.log('Uso: node scripts\\diagnosticar-nfce-comanda.js "C57 07:15" 2026-10-21'); process.exit(1); }

  const [comandas] = await db.query(
    `SELECT id, identificador, total, desconto, acrescimo, status, aberta_em, fechada_em FROM comandas
     WHERE identificador LIKE ? AND DATE(aberta_em) = ?`, [`%${trecho}%`, dia]
  );
  console.log('\n== COMANDAS =='); console.table(comandas);
  for (const c of comandas) {
    const [itens] = await db.query(
      `SELECT id, produto_id, nome_produto, unidade, quantidade, preco_unitario, subtotal, criado_em FROM itens_comanda WHERE comanda_id = ? ORDER BY id`, [c.id]);
    console.log(`\n== ITENS da comanda ${c.id} ==`); console.table(itens);
    const [pags] = await db.query(`SELECT * FROM comanda_pagamentos WHERE comanda_id = ? ORDER BY id`, [c.id]);
    console.log(`\n== PAGAMENTOS da comanda ${c.id} ==`); console.table(pags);
    const [notas] = await db.query(
      `SELECT id, numero, status, criado_em, valor_total, motivo_rejeicao, xml_assinado FROM notas_fiscais WHERE comanda_id = ? ORDER BY id`, [c.id]);
    console.log(`\n== NOTAS da comanda ${c.id} ==`);
    console.table(notas.map(n => {
      const x = n.xml_assinado || '';
      const tag = t => (x.match(new RegExp(`<${t}>([^<]*)</${t}>`)) || [])[1] || '';
      const vPags = [...x.matchAll(/<vPag>([^<]*)<\/vPag>/g)].map(m => m[1]).join('+');
      return { id: n.id, numero: n.numero, status: n.status, criado_em: n.criado_em, valor_total: n.valor_total,
        tpEmis: tag('tpEmis'), dhEmi: tag('dhEmi'), vNF: tag('vNF'), vPag: vPags, vTroco: tag('vTroco'),
        motivo: (n.motivo_rejeicao || '').slice(0, 60) };
    }));
  }
  await db.end();
})().catch(e => { console.error('Erro:', e.message); process.exit(1); });
