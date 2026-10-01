require('dotenv').config();
const db = require('../src/database/connection');

// Alguns itens de balança são gravados com quantidade=1 (fixa) e o "preco_unitario"
// na verdade é o VALOR TOTAL da etiqueta (código de barras com preço embutido, não
// peso embutido) — nesses casos o peso real é: valor_total / preço-do-quilo-atual-do-
// produto. Outros já vêm com a quantidade certa (peso real em kg). Esse script separa
// os dois casos e mostra o peso real calculado.
(async () => {
  const padaria_id = parseInt(process.env.PADARIA_ID_CONSULTA || '1', 10);

  const [pagamentos] = await db.query(
    `SELECT DISTINCT cp.comanda_id, cf.nome, c.identificador, DATE(cp.criado_em) AS data
     FROM comanda_pagamentos cp
     JOIN comandas c ON c.id = cp.comanda_id
     JOIN clientes_faturado cf ON cf.cnpj = cp.cliente_documento AND cf.padaria_id = c.padaria_id
     WHERE c.padaria_id = ? AND cp.forma_pagamento = 'Faturado' AND cf.tipo = 'empresa'
     ORDER BY data DESC`,
    [padaria_id]
  );

  console.log(`${pagamentos.length} comandas de faturado CNPJ encontradas.\n`);

  for (const p of pagamentos) {
    const [itens] = await db.query(
      `SELECT i.nome_produto, i.quantidade, i.unidade, i.preco_unitario, i.produto_id,
              pr.preco_venda AS preco_kg_atual, pr.unidade AS unidade_produto
       FROM itens_comanda i
       LEFT JOIN produtos pr ON pr.id = i.produto_id
       WHERE i.comanda_id = ? ORDER BY i.id`,
      [p.comanda_id]
    );
    const dataFmt = new Date(p.data).toLocaleDateString('pt-BR');
    console.log(`--- ${p.nome} — Comanda ${p.identificador} — ${dataFmt} ---`);
    for (const i of itens) {
      const qtd = parseFloat(i.quantidade);
      const precoItem = parseFloat(i.preco_unitario);
      const ehPlaceholder = Math.abs(qtd - 1) < 0.0001 && i.preco_kg_atual;
      if (ehPlaceholder) {
        const pesoKgReal = precoItem / parseFloat(i.preco_kg_atual);
        console.log(`  ${i.nome_produto}: valor etiqueta R$ ${precoItem.toFixed(2)} ÷ R$/kg atual ${parseFloat(i.preco_kg_atual).toFixed(2)} = PESO REAL ${(pesoKgReal*1000).toFixed(0)}g (${pesoKgReal.toFixed(3)}kg) [calculado pelo preço/kg de hoje]`);
      } else {
        console.log(`  ${i.nome_produto}: ${qtd} ${i.unidade || ''} (peso já gravado certo) x R$ ${precoItem.toFixed(2)}`);
      }
    }
    console.log('');
  }

  process.exit(0);
})();
