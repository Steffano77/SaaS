// Exporta dados da padaria em arquivos CSV (abre no Excel), num período escolhido —
// vendas (com/sem nota), consumo de Faturado por cliente/funcionário, entradas e
// saídas de estoque, movimentações do Financeiro. Só leitura, não apaga nada.
//
// Uso (exporta TUDO por padrão):
//   node scripts\exportar-tudo.js                              (desde o início até hoje, tudo)
//   node scripts\exportar-tudo.js 2026-01-01 2026-10-31         (período escolhido, tudo)
//
// Pra escolher só algumas partes (útil pra mandar pro patrão sem info extra), acrescenta
// as opções no final — qualquer combinação, nessa ordem de datas sempre primeiro:
//   node scripts\exportar-tudo.js 2026-01-01 2026-10-31 --vendas --faturado
// Opções disponíveis: --vendas --faturado --estoque --financeiro --caixa --notas
// Sem nenhuma opção, exporta tudo (igual antes).
//
// Dentro de --faturado, acrescenta --funcionarios pra pegar só o CPF cadastrado
// como funcionário (exclui empresa/CNPJ e quem comprou sem cadastro formal):
//   node scripts\exportar-tudo.js 2026-01-01 2026-10-31 --faturado --funcionarios
//
// Os arquivos saem numa pasta "exportado_AAAA-MM-DD_a_AAAA-MM-DD" dentro de scripts\,
// um .csv por tipo de dado. Abre cada um no Excel normalmente. Pra mandar em PDF pro
// patrão: abre o .csv no Excel e usa "Arquivo → Salvar como → PDF" de lá — gerar PDF
// direto por aqui exigiria instalar uma peça nova no sistema, não é algo pra fazer
// correndo; se quiser isso de verdade, me fala que a gente planeja com calma.
require('dotenv').config();
const fs = require('fs');
const path = require('path');
const db = require('../src/database/connection');

function csvEscape(v) {
  if (v === null || v === undefined) return '';
  // Datas vindas do banco chegam como objeto Date — sem isso, o Excel recebia o
  // texto longo do JavaScript ("Mon Oct 26 2026 19:46:21 GMT+0000 (...)") em vez
  // de uma data normal.
  if (v instanceof Date) {
    const p = n => String(n).padStart(2, '0');
    const dataOnly = v.getUTCHours() === 0 && v.getUTCMinutes() === 0 && v.getUTCSeconds() === 0;
    const base = `${p(v.getUTCDate())}/${p(v.getUTCMonth() + 1)}/${v.getUTCFullYear()}`;
    return dataOnly ? base : `${base} ${p(v.getUTCHours())}:${p(v.getUTCMinutes())}:${p(v.getUTCSeconds())}`;
  }
  const s = String(v);
  return /[;"\n]/.test(s) ? `"${s.replace(/"/g, '""')}"` : s;
}

function escreverCsv(pasta, nomeArquivo, linhas) {
  if (!linhas.length) {
    fs.writeFileSync(path.join(pasta, nomeArquivo), '(sem registros nesse período)\n', 'utf8');
    return;
  }
  const colunas = Object.keys(linhas[0]);
  const cabecalho = colunas.join(';');
  const corpo = linhas.map(l => colunas.map(c => csvEscape(l[c])).join(';')).join('\n');
  // BOM no início — sem isso o Excel lê acento errado (UTF-8 sem BOM vira "Ã£" etc).
  fs.writeFileSync(path.join(pasta, nomeArquivo), '﻿' + cabecalho + '\n' + corpo + '\n', 'utf8');
  console.log(`  ${nomeArquivo}: ${linhas.length} linha(s)`);
}

(async () => {
  const args = process.argv.slice(2);
  const opcoes = args.filter(a => a.startsWith('--'));
  const datas = args.filter(a => !a.startsWith('--'));
  const inicio = datas[0] || '2000-01-01';
  const fim = datas[1] || new Date().toISOString().slice(0, 10);
  if (!/^\d{4}-\d{2}-\d{2}$/.test(inicio) || !/^\d{4}-\d{2}-\d{2}$/.test(fim)) {
    console.log('Uso: node scripts\\exportar-tudo.js [2026-01-01] [2026-10-31] [--vendas --faturado --estoque --financeiro --caixa --notas]');
    process.exit(1);
  }
  // Sem nenhuma --opção, exporta tudo (comportamento padrão, igual sempre foi).
  const tudo = opcoes.length === 0;
  const quer = secao => tudo || opcoes.includes(`--${secao}`);
  const fimExclusivo = fim; // comparação é "< fim + 1 dia" lá embaixo

  const pastaNome = `exportado_${inicio}_a_${fim}`;
  const pasta = path.join(__dirname, pastaNome);
  fs.mkdirSync(pasta, { recursive: true });
  console.log(`\nExportando de ${inicio} até ${fim} pra ${pasta}\n`);

  // ── 1. VENDAS (comandas fechadas) — com ou sem nota fiscal ──────────────────
  if (quer('vendas')) {
    const [vendas] = await db.query(`
      SELECT c.id, c.identificador, c.atendente, c.fechada_em, c.total, c.desconto, c.acrescimo,
        (SELECT GROUP_CONCAT(DISTINCT cp.forma_pagamento SEPARATOR ' + ') FROM comanda_pagamentos cp WHERE cp.comanda_id = c.id) AS formas_pagamento,
        (SELECT n.status FROM notas_fiscais n WHERE n.comanda_id = c.id ORDER BY n.id DESC LIMIT 1) AS status_nota,
        (SELECT n.chave_acesso FROM notas_fiscais n WHERE n.comanda_id = c.id AND n.status IN ('autorizada','contingencia') ORDER BY n.id DESC LIMIT 1) AS chave_nfce
      FROM comandas c
      WHERE c.status = 'fechada' AND c.fechada_em >= ? AND c.fechada_em < DATE_ADD(?, INTERVAL 1 DAY)
      ORDER BY c.fechada_em
    `, [inicio, fimExclusivo]);
    escreverCsv(pasta, 'vendas.csv', vendas);
  }

  // ── 2 e 3. FATURADO — consumo (almoço/fiado lançado) e pagamentos recebidos (baixas) ──
  if (quer('faturado')) {
    // --funcionarios: só CPF cadastrado como funcionário, exclui empresa (CNPJ) e
    // quem comprou sem cadastro formal (não dá pra saber o tipo desses).
    const somenteFuncionario = opcoes.includes('--funcionarios');
    const [faturado] = await db.query(`
      SELECT COALESCE(cf.nome, cp.cliente_nome, 'Sem cadastro') AS cliente, cf.tipo, cp.cliente_documento AS documento, c.identificador AS comanda,
        c.fechada_em AS data_consumo,
        (SELECT GROUP_CONCAT(CONCAT(
           TRIM(TRAILING '.' FROM TRIM(TRAILING '0' FROM CAST(i.quantidade AS CHAR))),
           'x ', i.nome_produto) SEPARATOR ', ')
         FROM itens_comanda i WHERE i.comanda_id = c.id) AS itens,
        cp.valor, cp.valor_pago,
        (cp.valor - cp.valor_pago) AS saldo_em_aberto,
        CASE WHEN cp.quitado_em IS NOT NULL THEN 'Quitado' ELSE 'Em aberto' END AS status,
        cp.forma_quitacao, cp.quitado_em
      FROM comanda_pagamentos cp
      JOIN comandas c ON c.id = cp.comanda_id
      LEFT JOIN clientes_faturado cf ON cf.cnpj = cp.cliente_documento AND cf.padaria_id = c.padaria_id
      WHERE cp.forma_pagamento = 'Faturado' AND c.fechada_em >= ? AND c.fechada_em < DATE_ADD(?, INTERVAL 1 DAY)
        ${somenteFuncionario ? "AND cf.tipo = 'funcionario'" : ''}
      ORDER BY cliente, data_consumo
    `, [inicio, fimExclusivo]);
    escreverCsv(pasta, 'faturado_consumo.csv', faturado);

    const [faturadoPagamentos] = await db.query(`
      SELECT r.criado_em AS data, r.cliente_nome, r.cliente_documento, r.valor, r.forma_pagamento
      FROM recebimentos_faturado r
      ${somenteFuncionario ? "JOIN clientes_faturado cf ON cf.cnpj = r.cliente_documento AND cf.tipo = 'funcionario'" : ''}
      WHERE r.criado_em >= ? AND r.criado_em < DATE_ADD(?, INTERVAL 1 DAY)
      ORDER BY r.criado_em
    `, [inicio, fimExclusivo]).catch(() => [[]]);
    escreverCsv(pasta, 'faturado_pagamentos_recebidos.csv', faturadoPagamentos);
  }

  // ── 4 e 5. ESTOQUE: entradas e saídas (de verdade — sem baixa de venda/produção) ──
  if (quer('estoque')) {
    const [entradas] = await db.query(`
      SELECT m.data, p.nome AS produto, m.quantidade, m.custo_unit, m.valor_total, m.observacao
      FROM movimentacoes m JOIN produtos p ON p.id = m.produto_id
      WHERE m.tipo = 'entrada' AND m.data >= ? AND m.data < DATE_ADD(?, INTERVAL 1 DAY)
      ORDER BY m.data
    `, [inicio, fimExclusivo]);
    escreverCsv(pasta, 'estoque_entradas.csv', entradas);

    const [saidasEstoque] = await db.query(`
      SELECT m.data, p.nome AS produto, m.quantidade, m.custo_unit, m.valor_total, m.observacao
      FROM movimentacoes m JOIN produtos p ON p.id = m.produto_id
      WHERE m.tipo = 'saida' AND m.data >= ? AND m.data < DATE_ADD(?, INTERVAL 1 DAY)
        AND (m.observacao IS NULL OR (m.observacao NOT LIKE 'Comanda %' AND m.observacao NOT LIKE 'Produção #%'))
      ORDER BY m.data
    `, [inicio, fimExclusivo]);
    escreverCsv(pasta, 'estoque_saidas.csv', saidasEstoque);
  }

  // ── 6. FINANCEIRO (entradas e saídas manuais: despesas, recebimentos avulsos) ──
  if (quer('financeiro')) {
    const [financeiro] = await db.query(`
      SELECT data, tipo, categoria, descricao, valor, forma_pagamento, criado_em
      FROM financeiro
      WHERE data >= ? AND data < DATE_ADD(?, INTERVAL 1 DAY)
      ORDER BY data
    `, [inicio, fimExclusivo]);
    escreverCsv(pasta, 'financeiro.csv', financeiro);
  }

  // ── 7. MOVIMENTAÇÕES DE CAIXA (sangria/suprimento) ──────────────────────────
  if (quer('caixa')) {
    const [caixaMov] = await db.query(`
      SELECT cm.criado_em AS data, cx.nome AS caixa, cm.tipo, cm.valor, cm.observacao
      FROM caixa_movimentos cm JOIN caixas cx ON cx.id = cm.caixa_id
      WHERE cm.criado_em >= ? AND cm.criado_em < DATE_ADD(?, INTERVAL 1 DAY)
      ORDER BY cm.criado_em
    `, [inicio, fimExclusivo]);
    escreverCsv(pasta, 'caixa_sangria_suprimento.csv', caixaMov);
  }

  // ── 8. NOTAS FISCAIS — resumo por status ─────────────────────────────────────
  if (quer('notas')) {
    const [notasResumo] = await db.query(`
      SELECT status, COUNT(*) AS qtd, COALESCE(SUM(valor_total), 0) AS total
      FROM notas_fiscais
      WHERE criado_em >= ? AND criado_em < DATE_ADD(?, INTERVAL 1 DAY)
      GROUP BY status
    `, [inicio, fimExclusivo]);
    escreverCsv(pasta, 'notas_fiscais_resumo.csv', notasResumo);
  }

  console.log(`\n✅ Pronto! Abre a pasta: ${pasta}\n`);
  await db.end();
})().catch(e => { console.error('Erro:', e.message); process.exit(1); });
