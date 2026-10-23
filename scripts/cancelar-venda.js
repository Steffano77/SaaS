// Cancela de vez uma venda (comanda fechada) lançada por engano: apaga a comanda, os
// itens e os pagamentos (inclusive Faturado, quitado ou não), o lançamento dela no
// Financeiro e, se pedir, devolve os itens pro estoque. Nunca mexe em venda com NFC-e
// autorizada (essa precisa ser cancelada na Sefaz).
// Uso (só mostra, não apaga nada):
//   node scripts\cancelar-venda.js "C151 15:59" 2026-10-23
// Pra apagar de verdade, acrescente --confirmar (e --devolver-estoque se os produtos
// voltaram pra prateleira desta loja):
//   node scripts\cancelar-venda.js "C151 15:59" 2026-10-23 --confirmar --devolver-estoque
require('dotenv').config();
const db = require('../src/database/connection');

(async () => {
  const [trecho, dia] = process.argv.slice(2);
  const confirmar = process.argv.includes('--confirmar');
  const devolver = process.argv.includes('--devolver-estoque');
  if (!trecho || !dia) { console.log('Uso: node scripts\\cancelar-venda.js "C151 15:59" 2026-10-23 [--confirmar] [--devolver-estoque]'); process.exit(1); }

  const [comandas] = await db.query(
    `SELECT id, padaria_id, identificador, total, status, forma_pagamento, fechada_em FROM comandas
     WHERE identificador LIKE ? AND DATE(aberta_em) = ?`, [`%${trecho}%`, dia]);
  if (comandas.length !== 1) {
    console.log(comandas.length ? 'Achei mais de uma comanda — use um trecho mais exato:' : 'Nenhuma comanda encontrada.');
    console.table(comandas); await db.end(); process.exit(1);
  }
  const c = comandas[0];
  const [itens] = await db.query(`SELECT produto_id, nome_produto, quantidade, subtotal FROM itens_comanda WHERE comanda_id = ?`, [c.id]);
  const [pags] = await db.query(`SELECT forma_pagamento, valor, troco, cliente_nome, quitado_em FROM comanda_pagamentos WHERE comanda_id = ?`, [c.id]);
  const [notas] = await db.query(`SELECT id, numero, status FROM notas_fiscais WHERE comanda_id = ?`, [c.id]);
  let fin = [];
  try { [fin] = await db.query(`SELECT id, valor, descricao, categoria, data FROM financeiro WHERE comanda_id = ?`, [c.id]); }
  catch (e) { if (e.code !== 'ER_BAD_FIELD_ERROR') throw e; }
  if (!fin.length) {
    [fin] = await db.query(`SELECT id, valor, descricao, categoria, data FROM financeiro WHERE padaria_id = ? AND descricao = ? AND DATE(data) = DATE(?)`,
      [c.padaria_id, `Comanda ${c.identificador}`, c.fechada_em]);
  }

  console.log('\n== COMANDA =='); console.table([c]);
  console.log('== ITENS =='); console.table(itens);
  console.log('== PAGAMENTOS =='); console.table(pags);
  console.log('== FINANCEIRO (vai ser apagado) =='); console.table(fin);
  console.log('== NOTAS FISCAIS =='); console.table(notas);

  if (notas.some(n => n.status === 'autorizada')) {
    console.log('\nESSA VENDA TEM NFC-e AUTORIZADA — não apago. Precisa cancelar a nota na Sefaz primeiro.');
    await db.end(); process.exit(1);
  }
  if (!confirmar) {
    console.log(`\nNada foi apagado. Pra apagar, rode de novo com --confirmar${itens.some(i => i.produto_id) ? ' (e --devolver-estoque se os produtos voltaram pra prateleira)' : ''}.`);
    await db.end(); return;
  }

  const conn = await db.getConnection();
  try {
    await conn.beginTransaction();
    if (devolver) {
      for (const i of itens) {
        if (!i.produto_id) continue;
        await conn.query(`UPDATE produtos SET estoque_atual = estoque_atual + ? WHERE id = ? AND padaria_id = ?`, [i.quantidade, i.produto_id, c.padaria_id]);
        await conn.query(`INSERT INTO movimentacoes (padaria_id, produto_id, tipo, quantidade, custo_unit, observacao, data) VALUES (?,?,?,?,0,?,NOW())`,
          [c.padaria_id, i.produto_id, 'entrada', i.quantidade, `Cancelamento da venda ${c.identificador}`]);
      }
    }
    if (fin.length) await conn.query(`DELETE FROM financeiro WHERE id IN (?)`, [fin.map(f => f.id)]);
    await conn.query(`DELETE FROM notas_fiscais WHERE comanda_id = ? AND status <> 'autorizada'`, [c.id]);
    await conn.query(`DELETE FROM comandas WHERE id = ?`, [c.id]); // itens e pagamentos saem junto (cascade)
    await conn.commit();
    console.log(`\nVenda ${c.identificador} cancelada: comanda, pagamentos e ${fin.length} lançamento(s) do Financeiro apagados${devolver ? ', itens devolvidos ao estoque' : ''}.`);
  } catch (e) {
    await conn.rollback(); console.error('Erro — nada foi apagado:', e.message); process.exitCode = 1;
  } finally { conn.release(); await db.end(); }
})().catch(e => { console.error('Erro:', e.message); process.exit(1); });
