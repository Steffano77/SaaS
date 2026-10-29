// Só leitura — lista as comandas abertas agora, mostrando o identificador exato (entre
// aspas, pra ver espaço/caractere escondido) e se bate com o filtro "só número" do
// tablet de Modo Lançamento.
// Uso: node scripts\listar-comandas-abertas.js
require('dotenv').config();
const db = require('../src/database/connection');

(async () => {
  const [abertas] = await db.query(
    `SELECT id, identificador, pronta_pagamento, aberta_em FROM comandas WHERE status = 'aberta' ORDER BY aberta_em`
  );
  console.log(`\n== ${abertas.length} COMANDA(S) ABERTA(S) ==`);
  console.table(abertas.map(c => ({
    id: c.id,
    identificador: `"${c.identificador}"`,
    pronta_pagamento: c.pronta_pagamento,
    so_numero: /^\d+$/.test(String(c.identificador || '').trim()) ? 'SIM' : 'não',
    aberta_em: c.aberta_em,
  })));
  await db.end();
})().catch(e => { console.error('Erro:', e.message); process.exit(1); });
