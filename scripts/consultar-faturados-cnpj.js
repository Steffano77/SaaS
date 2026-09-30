require('dotenv').config();
const db = require('../src/database/connection');

(async () => {
  const padaria_id = parseInt(process.env.PADARIA_ID_CONSULTA || '1', 10);

  const [rows] = await db.query(
    `SELECT cf.nome, cf.cnpj, cp.valor, cp.criado_em, cp.quitado_em, cp.lancado_em
     FROM comanda_pagamentos cp
     JOIN comandas c ON c.id = cp.comanda_id
     JOIN clientes_faturado cf ON cf.cnpj = cp.cliente_documento AND cf.padaria_id = c.padaria_id
     WHERE c.padaria_id = ? AND cp.forma_pagamento = 'Faturado' AND cf.tipo = 'empresa'
     ORDER BY cp.criado_em ASC`,
    [padaria_id]
  );

  console.log(`Total de lançamentos "Faturado" (CNPJ) encontrados no banco: ${rows.length}`);
  if (rows.length > 0) {
    console.log(`Do mais antigo: ${rows[0].criado_em.toISOString()} até o mais recente: ${rows[rows.length - 1].criado_em.toISOString()}`);
  }
  console.log('');

  const porCliente = {};
  let totalGeral = 0;
  let totalAberto = 0;
  for (const r of rows) {
    const valor = parseFloat(r.valor);
    totalGeral += valor;
    if (!r.quitado_em) totalAberto += valor;
    if (!porCliente[r.nome]) porCliente[r.nome] = { cnpj: r.cnpj, total: 0, aberto: 0, qtd: 0 };
    porCliente[r.nome].total += valor;
    porCliente[r.nome].qtd += 1;
    if (!r.quitado_em) porCliente[r.nome].aberto += valor;
  }

  console.log('--- RESUMO POR CLIENTE ---');
  for (const [nome, d] of Object.entries(porCliente)) {
    console.log(`${nome} (${d.cnpj}) — ${d.qtd} lançamentos — total histórico: R$ ${d.total.toFixed(2)} — em aberto: R$ ${d.aberto.toFixed(2)}`);
  }
  console.log('');
  console.log(`TOTAL HISTÓRICO (tudo que já passou, pago ou não): R$ ${totalGeral.toFixed(2)}`);
  console.log(`TOTAL EM ABERTO (ainda não quitado): R$ ${totalAberto.toFixed(2)}`);

  process.exit(0);
})();
