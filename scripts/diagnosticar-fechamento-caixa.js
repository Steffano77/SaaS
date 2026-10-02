require('dotenv').config();
const db = require('../src/database/connection');

(async () => {
  const padaria_id = parseInt(process.env.PADARIA_ID_CONSULTA || '1', 10);
  const nomeCaixa = process.argv[2] || 'Caixa 1';
  const dataAlvo = process.argv[3]; // formato "2026-10-01", opcional — default ontem

  const [caixas] = await db.query(
    `SELECT * FROM caixas WHERE padaria_id = ? AND nome = ? ORDER BY aberto_em DESC LIMIT 5`,
    [padaria_id, nomeCaixa]
  );

  for (const caixa of caixas) {
    const diaAbertura = new Date(caixa.aberto_em).toISOString().slice(0, 10);
    if (dataAlvo && diaAbertura !== dataAlvo) continue;

    console.log(`\n=== ${caixa.nome} — aberto em ${caixa.aberto_em} — atendente: ${caixa.atendente || '(não registrado)'} ===`);
    console.log(`Status: ${caixa.status} | Valor abertura: R$ ${parseFloat(caixa.valor_abertura).toFixed(2)}`);
    if (caixa.fechado_em) console.log(`Fechado em: ${caixa.fechado_em}`);
    if (caixa.observacao) console.log(`Observação: ${caixa.observacao}`);
    if (caixa.valor_esperado != null) console.log(`Valor esperado (pelo sistema): R$ ${parseFloat(caixa.valor_esperado).toFixed(2)}`);
    if (caixa.valor_fechamento != null) console.log(`Valor fechado (contado pela atendente, Dinheiro): R$ ${parseFloat(caixa.valor_fechamento).toFixed(2)}`);

    const [porForma] = await db.query(
      `SELECT cp.forma_pagamento, COUNT(*) AS qtd, COALESCE(SUM(cp.valor), 0) AS total
       FROM comanda_pagamentos cp
       JOIN comandas c ON c.id = cp.comanda_id
       WHERE c.caixa_id = ?
       GROUP BY cp.forma_pagamento`,
      [caixa.id]
    );
    console.log('--- Vendas por forma de pagamento (o que o SISTEMA registrou) ---');
    for (const f of porForma) {
      console.log(`  ${f.forma_pagamento}: ${f.qtd} venda(s) — R$ ${parseFloat(f.total).toFixed(2)}`);
    }

    const [movimentos] = await db.query(
      `SELECT * FROM caixa_movimentos WHERE caixa_id = ? ORDER BY criado_em`, [caixa.id]
    );
    if (movimentos.length) {
      console.log('--- Sangrias/Suprimentos/Despesas ---');
      for (const m of movimentos) {
        console.log(`  ${m.tipo}: R$ ${parseFloat(m.valor).toFixed(2)}${m.observacao ? ' — ' + m.observacao : ''}`);
      }
    }

    const totalDinheiro = parseFloat(porForma.find(f => f.forma_pagamento === 'Dinheiro')?.total || 0);
    const totalSangrias = movimentos.filter(m => m.tipo === 'sangria').reduce((s, m) => s + parseFloat(m.valor), 0);
    const totalSuprimentos = movimentos.filter(m => m.tipo === 'suprimento').reduce((s, m) => s + parseFloat(m.valor), 0);
    const totalDespesas = movimentos.filter(m => m.tipo === 'despesa').reduce((s, m) => s + parseFloat(m.valor), 0);
    const esperadoEmDinheiro = parseFloat(caixa.valor_abertura) + totalDinheiro + totalSuprimentos - totalSangrias - totalDespesas;

    console.log('--- Conta do dinheiro esperado na gaveta ---');
    console.log(`  Abertura: R$ ${parseFloat(caixa.valor_abertura).toFixed(2)}`);
    console.log(`  + Vendas em Dinheiro: R$ ${totalDinheiro.toFixed(2)}`);
    console.log(`  + Suprimentos: R$ ${totalSuprimentos.toFixed(2)}`);
    console.log(`  - Sangrias: R$ ${totalSangrias.toFixed(2)}`);
    console.log(`  - Despesas: R$ ${totalDespesas.toFixed(2)}`);
    console.log(`  = ESPERADO NA GAVETA: R$ ${esperadoEmDinheiro.toFixed(2)}`);

    if (caixa.fechamento_formas) {
      try {
        const dados = JSON.parse(caixa.fechamento_formas);
        console.log('--- O que a atendente digitou que CONTOU, por forma ---');
        for (const [forma, valor] of Object.entries(dados)) {
          console.log(`  ${forma}: contou R$ ${parseFloat(valor).toFixed(2)}`);
        }
      } catch (e) { /* formato antigo, ignora */ }
    }
  }

  process.exit(0);
})();
