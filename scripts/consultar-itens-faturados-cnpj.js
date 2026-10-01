require('dotenv').config();
const db = require('../src/database/connection');

(async () => {
  const padaria_id = parseInt(process.env.PADARIA_ID_CONSULTA || '1', 10);

  const [pagamentos] = await db.query(
    `SELECT DISTINCT cp.comanda_id, cf.nome, c.identificador, DATE(cp.criado_em) AS data
     FROM comanda_pagamentos cp
     JOIN comandas c ON c.id = cp.comanda_id
     JOIN clientes_faturado cf ON cf.cnpj = cp.cliente_documento AND cf.padaria_id = c.padaria_id
     WHERE c.padaria_id = ? AND cp.forma_pagamento = 'Faturado' AND cf.tipo = 'empresa'
     ORDER BY cp.criado_em DESC`,
    [padaria_id]
  );

  console.log(`${pagamentos.length} comandas de faturado CNPJ encontradas.\n`);

  for (const p of pagamentos) {
    const [itens] = await db.query(
      `SELECT nome_produto, quantidade, unidade, preco_unitario FROM itens_comanda WHERE comanda_id = ? ORDER BY id`,
      [p.comanda_id]
    );
    const dataFmt = new Date(p.data).toLocaleDateString('pt-BR');
    console.log(`--- ${p.nome} — Comanda ${p.identificador} — ${dataFmt} ---`);
    for (const i of itens) {
      console.log(`  ${i.quantidade} ${i.unidade || ''} x ${i.nome_produto} (R$ ${parseFloat(i.preco_unitario).toFixed(2)} cada)`);
    }
    console.log('');
  }

  process.exit(0);
})();
