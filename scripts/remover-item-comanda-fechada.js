// Tira um item de uma comanda JÁ FECHADA e recalcula o total — usado quando a comanda
// fechou com item sem pagar (ex: Balcão C57 de 21/10, bipado no mesmo segundo da
// cobrança) e a NFC-e fica rejeitada (865). Depois disso é só "Reemitir corrigida".
// Uso: node scripts\remover-item-comanda-fechada.js <comanda_id> <item_id>
require('dotenv').config();
const db = require('../src/database/connection');

(async () => {
  const [comandaId, itemId] = process.argv.slice(2).map(Number);
  if (!comandaId || !itemId) { console.log('Uso: node scripts\\remover-item-comanda-fechada.js <comanda_id> <item_id>'); process.exit(1); }

  const [[item]] = await db.query(`SELECT * FROM itens_comanda WHERE id = ? AND comanda_id = ?`, [itemId, comandaId]);
  if (!item) { console.log('Item não encontrado nessa comanda — nada foi alterado.'); process.exit(1); }
  const [[autorizada]] = await db.query(`SELECT id FROM notas_fiscais WHERE comanda_id = ? AND status = 'autorizada'`, [comandaId]);
  if (autorizada) { console.log('Essa comanda já tem nota autorizada — não mexo nela.'); process.exit(1); }

  await db.query(`DELETE FROM itens_comanda WHERE id = ? AND comanda_id = ?`, [itemId, comandaId]);
  const [[{ subtotal }]] = await db.query(`SELECT COALESCE(SUM(subtotal),0) AS subtotal FROM itens_comanda WHERE comanda_id = ?`, [comandaId]);
  const [[c]] = await db.query(`SELECT desconto, acrescimo FROM comandas WHERE id = ?`, [comandaId]);
  const total = Math.max(0, parseFloat(subtotal) - parseFloat(c.desconto || 0) + parseFloat(c.acrescimo || 0));
  await db.query(`UPDATE comandas SET total = ? WHERE id = ?`, [total, comandaId]);
  const [[{ pago }]] = await db.query(`SELECT COALESCE(SUM(valor),0) AS pago FROM comanda_pagamentos WHERE comanda_id = ?`, [comandaId]);

  console.log(`Removido: ${item.nome_produto} (${item.subtotal}). Novo total: ${total.toFixed(2)} · Pago: ${parseFloat(pago).toFixed(2)}`);
  console.log(Math.abs(total - parseFloat(pago)) < 0.01 ? 'OK — total bate com o pago. Agora é só "Reemitir corrigida".' : 'ATENÇÃO — ainda não bate com o pago.');
  await db.end();
})().catch(e => { console.error('Erro:', e.message); process.exit(1); });
