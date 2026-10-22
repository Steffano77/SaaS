// Audita um mês inteiro procurando o motivo mais comum de imposto "a mais": comanda
// com MAIS DE UMA nota fiscal autorizada (cada autorizada conta pra Sefaz de verdade,
// então duplicar = pagar imposto em dobro sobre a mesma venda). Também soma o total
// das notas autorizadas no mês, pra comparar com o total de comandas fechadas.
// Uso: node scripts\auditar-notas-duplicadas-mes.js 2026-10
require('dotenv').config();
const db = require('../src/database/connection');

(async () => {
  const mes = process.argv[2]; // formato YYYY-MM
  if (!mes || !/^\d{4}-\d{2}$/.test(mes)) {
    console.log('Uso: node scripts\\auditar-notas-duplicadas-mes.js 2026-10');
    process.exit(1);
  }

  console.log(`\n== Comandas com MAIS DE UMA nota autorizada em ${mes} (duplicidade — causa mais provável de imposto a mais) ==`);
  const [duplicadas] = await db.query(
    `SELECT n.comanda_id, COUNT(*) AS qtd_notas_autorizadas, SUM(n.valor_total) AS soma_valor,
            GROUP_CONCAT(n.id) AS ids_notas, GROUP_CONCAT(n.numero) AS numeros
     FROM notas_fiscais n
     WHERE n.status = 'autorizada' AND DATE_FORMAT(n.autorizada_em, '%Y-%m') = ?
     GROUP BY n.comanda_id
     HAVING COUNT(*) > 1
     ORDER BY soma_valor DESC`,
    [mes]
  );
  console.table(duplicadas);
  if (duplicadas.length) {
    const totalDuplicado = duplicadas.reduce((s, d) => s + parseFloat(d.soma_valor) - parseFloat(d.soma_valor) / d.qtd_notas_autorizadas, 0);
    console.log(`\n⚠️  ${duplicadas.length} comanda(s) com nota duplicada. Valor pago "a mais" estimado (contando a nota extra): R$ ${totalDuplicado.toFixed(2)}`);
  } else {
    console.log('Nenhuma duplicidade encontrada — não foi isso.');
  }

  console.log(`\n== Resumo do mês ${mes} ==`);
  // Nota em "contingência" (Sefaz fora do ar na hora) também é válida e conta fiscalmente
  // — por isso entra junto com "autorizada" aqui, pra não parecer que falta nota à toa.
  const [[resumoNotas]] = await db.query(
    `SELECT COUNT(*) AS qtd_notas_validas, COALESCE(SUM(valor_total),0) AS total_notas_validas
     FROM notas_fiscais WHERE status IN ('autorizada','contingencia') AND DATE_FORMAT(COALESCE(autorizada_em, criado_em), '%Y-%m') = ?`,
    [mes]
  );
  const [[resumoComandas]] = await db.query(
    `SELECT COUNT(*) AS qtd_comandas_fechadas, COALESCE(SUM(total),0) AS total_comandas_fechadas
     FROM comandas WHERE status = 'fechada' AND DATE_FORMAT(fechada_em, '%Y-%m') = ?`,
    [mes]
  );
  console.table([{ ...resumoNotas, ...resumoComandas }]);
  const diferenca = parseFloat(resumoNotas.total_notas_validas) - parseFloat(resumoComandas.total_comandas_fechadas);
  console.log(`Diferença (notas válidas - comandas): R$ ${diferenca.toFixed(2)} ${Math.abs(diferenca) > 1 ? '⚠️  investigar' : '✅ bate certinho'}`);

  // Quebra o que está faltando: comanda fechada sem NENHUMA nota, com nota rejeitada
  // (nunca corrigida), ou cancelada — ajuda a entender de onde vem a diferença acima.
  console.log(`\n== Comandas fechadas em ${mes} SEM nota válida (nem autorizada, nem contingência) ==`);
  const [[semNota]] = await db.query(
    `SELECT COUNT(*) AS qtd, COALESCE(SUM(c.total),0) AS total
     FROM comandas c
     WHERE c.status = 'fechada' AND DATE_FORMAT(c.fechada_em, '%Y-%m') = ?
       AND NOT EXISTS (SELECT 1 FROM notas_fiscais n WHERE n.comanda_id = c.id AND n.status IN ('autorizada','contingencia'))`,
    [mes]
  );
  console.table([semNota]);
  const [porStatus] = await db.query(
    `SELECT n.status, COUNT(*) AS qtd, COALESCE(SUM(n.valor_total),0) AS total
     FROM notas_fiscais n
     JOIN comandas c ON c.id = n.comanda_id
     WHERE c.status = 'fechada' AND DATE_FORMAT(c.fechada_em, '%Y-%m') = ?
     GROUP BY n.status`,
    [mes]
  );
  console.log('\n== Status das notas das comandas fechadas desse mês (qualquer tentativa) ==');
  console.table(porStatus);

  await db.end();
})().catch(e => { console.error('Erro:', e.message); process.exit(1); });
