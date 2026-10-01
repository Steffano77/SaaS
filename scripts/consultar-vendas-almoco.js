require('dotenv').config();
const db = require('../src/database/connection');

(async () => {
  const padaria_id = parseInt(process.env.PADARIA_ID_CONSULTA || '1', 10);

  const [itens] = await db.query(
    `SELECT DATE(c.fechada_em) AS dia, i.nome_produto, i.quantidade, i.subtotal
     FROM itens_comanda i
     JOIN comandas c ON c.id = i.comanda_id
     JOIN produtos p ON p.id = i.produto_id
     JOIN categorias cat ON cat.id = p.categoria_id
     WHERE c.padaria_id = ? AND c.status = 'fechada'
       AND cat.nome IN ('almoço', 'Marmitex')`,
    [padaria_id]
  );

  if (!itens.length) {
    console.log('Nenhuma venda de almoço/marmitex encontrada nesse servidor.');
    process.exit(0);
  }

  const dias = new Set();
  let qtdTotal = 0;
  let valorTotal = 0;
  const porDia = {};

  for (const i of itens) {
    const diaStr = i.dia.toISOString().slice(0, 10);
    dias.add(diaStr);
    const qtd = parseFloat(i.quantidade);
    qtdTotal += qtd;
    valorTotal += parseFloat(i.subtotal);
    porDia[diaStr] = (porDia[diaStr] || 0) + qtd;
  }

  const qtdDias = dias.size;
  console.log(`Período: ${qtdDias} dia(s) com venda de almoço/marmitex, de ${[...dias].sort()[0]} até ${[...dias].sort().slice(-1)[0]}`);
  console.log(`Quantidade total vendida: ${qtdTotal.toFixed(0)} unidades`);
  console.log(`Valor total: R$ ${valorTotal.toFixed(2)}`);
  console.log(`MÉDIA POR DIA: ${(qtdTotal / qtdDias).toFixed(1)} almoços/dia — R$ ${(valorTotal / qtdDias).toFixed(2)}/dia`);
  console.log('');
  console.log('--- Por dia ---');
  for (const dia of Object.keys(porDia).sort()) {
    console.log(`${dia}: ${porDia[dia].toFixed(0)} unidades`);
  }

  process.exit(0);
})();
