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
     ORDER BY cp.criado_em DESC`,
    [padaria_id]
  );
  console.log(JSON.stringify(rows, null, 2));
  process.exit(0);
})();
