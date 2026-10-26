const bcrypt = require('bcryptjs');
const db = require('../database/connection');

// O app manda o id do aparelho (PC/tablet) em todo pedido, no cabeçalho X-Aparelho.
// Caixa com dono e pedido vindo de outro aparelho = não pode mexer nele.
function aparelhoDoPedido(req) {
  const id = String(req.get('X-Aparelho') || '').trim();
  return /^[a-z0-9-]{8,40}$/i.test(id) ? id : null;
}
function caixaDeOutroAparelho(caixa, req) {
  const meu = aparelhoDoPedido(req);
  return !!(caixa && caixa.aparelho_id && meu && caixa.aparelho_id !== meu);
}
exports.aparelhoDoPedido = aparelhoDoPedido;
exports.caixaDeOutroAparelho = caixaDeOutroAparelho;
const ERRO_OUTRO_APARELHO = 'Esse caixa está aberto em outro aparelho. Abra um caixa próprio aqui (ex: "Caixa 2") ou use "Usar caixa" com o PIN pra trazer ele pra cá.';
exports.ERRO_OUTRO_APARELHO = ERRO_OUTRO_APARELHO;

// Lista todos os caixas abertos da padaria (pode haver mais de um — um por tablet/aparelho)
exports.abertos = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [caixas] = await db.query(
    `SELECT * FROM caixas WHERE padaria_id = ? AND status = 'aberto' ORDER BY aberto_em`,
    [padaria_id]
  );
  res.json(caixas);
};

// Detalhe de um caixa específico (com resumo), usado pelo tablet que já sabe qual é o seu
exports.buscar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [[caixa]] = await db.query(
    `SELECT * FROM caixas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado.' });
  const resumo = await montarResumoCaixa(caixa);
  res.json({ ...caixa, resumo });
};

// Histórico de caixas já fechados
exports.historico = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [caixas] = await db.query(
    `SELECT * FROM caixas WHERE padaria_id = ? AND status = 'fechado' ORDER BY fechado_em DESC LIMIT 30`,
    [padaria_id]
  );
  res.json(caixas);
};

// Pausa o caixa (a pessoa saiu pro intervalo) — trava a venda até alguém retomar.
exports.pausar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [[caixa]] = await db.query(`SELECT atendente FROM caixas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]);
  await db.query(
    `UPDATE caixas SET pausado = 1, pausado_por = ? WHERE id = ? AND padaria_id = ? AND status = 'aberto'`,
    [caixa?.atendente || null, req.params.id, padaria_id]
  );
  res.json({ ok: true });
};

// Retoma o caixa — exige login de atendente (papel caixa ou gerente), via o middleware
// exigirFuncionario aplicado na rota. Pode ser a mesma pessoa ou outra, tanto faz —
// o que importa é confirmar que é alguém autorizado a mexer no caixa.
exports.retomar = async (req, res) => {
  const padaria_id = req.padaria.id;
  await db.query(
    `UPDATE caixas SET pausado = 0, pausado_por = NULL WHERE id = ? AND padaria_id = ? AND status = 'aberto'`,
    [req.params.id, padaria_id]
  );
  res.json({ ok: true, retomado_por: req.funcionario?.nome || null });
};

exports.abrir = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { valor_abertura, atendente_id, pin, observacao } = req.body;
  const nome = String(req.body.nome || '').trim() || 'Caixa 1';

  let atendenteNome = null;
  if (atendente_id) {
    const [[atendente]] = await db.query(
      `SELECT id, nome, pin_hash FROM atendentes WHERE id = ? AND padaria_id = ? AND ativo = 1`,
      [atendente_id, padaria_id]
    );
    if (!atendente) return res.status(404).json({ erro: 'Atendente não encontrado.' });
    if (atendente.pin_hash) {
      const ok = await bcrypt.compare(String(pin || ''), atendente.pin_hash);
      if (!ok) return res.status(401).json({ erro: 'PIN incorreto.' });
    }
    atendenteNome = atendente.nome;
  }

  // Nunca deixa abrir 2 caixas com o mesmo nome ao mesmo tempo (ex: dois aparelhos
  // logando como "Caixa 1" junto) — isso já causou vendas de um se misturarem com o
  // outro, porque o app usa o nome pra saber qual caixa é "o meu" depois de um F5.
  const [[jaAberto]] = await db.query(
    `SELECT id FROM caixas WHERE padaria_id = ? AND nome = ? AND status = 'aberto' LIMIT 1`,
    [padaria_id, nome]
  );
  if (jaAberto) {
    return res.status(409).json({ erro: `Já existe um caixa aberto com o nome "${nome}". Escolha outro nome (ex: "${nome} B") ou feche o outro caixa primeiro.` });
  }

  try {
    const [r] = await db.query(
      `INSERT INTO caixas (padaria_id, nome, atendente, valor_abertura, observacao, aparelho_id) VALUES (?,?,?,?,?,?)`,
      [padaria_id, nome, atendenteNome, parseFloat(valor_abertura) || 0, observacao || null, aparelhoDoPedido(req)]
    );
    res.status(201).json({ id: r.insertId, nome, atendente: atendenteNome });
  } catch (e) {
    // Corrida (2 aparelhos clicando "abrir" no mesmíssimo instante) — a trava do banco
    // (uq_caixas_nome_ativo) pega o que a checagem acima não pegou a tempo.
    if (e.code === 'ER_DUP_ENTRY') {
      return res.status(409).json({ erro: `Já existe um caixa aberto com o nome "${nome}". Escolha outro nome ou feche o outro caixa primeiro.` });
    }
    console.error('Erro ao abrir caixa:', e);
    res.status(500).json({ erro: 'Erro ao abrir caixa.' });
  }
};

// "Usar caixa" — traz um caixa aberto pra este aparelho (ex: o PC reiniciou e perdeu
// o vínculo). Exige PIN de caixa/gerente (na rota). O aparelho antigo perde o caixa.
exports.assumir = async (req, res) => {
  const padaria_id = req.padaria.id;
  const aparelho = aparelhoDoPedido(req);
  if (!aparelho) return res.status(400).json({ erro: 'Aparelho não identificado. Recarregue a página.' });
  const [r] = await db.query(
    `UPDATE caixas SET aparelho_id = ? WHERE id = ? AND padaria_id = ? AND status = 'aberto'`,
    [aparelho, req.params.id, padaria_id]
  );
  if (!r.affectedRows) return res.status(404).json({ erro: 'Caixa não encontrado ou já fechado.' });
  res.json({ ok: true });
};

// Caixa sem dono (aberto antes dessa trava existir) — o primeiro aparelho que estiver
// com ele aberto vira o dono, sem PIN. Se já tem dono, não mexe.
exports.vincular = async (req, res) => {
  const padaria_id = req.padaria.id;
  const aparelho = aparelhoDoPedido(req);
  if (!aparelho) return res.status(400).json({ erro: 'Aparelho não identificado. Recarregue a página.' });
  const [r] = await db.query(
    `UPDATE caixas SET aparelho_id = ? WHERE id = ? AND padaria_id = ? AND status = 'aberto' AND aparelho_id IS NULL`,
    [aparelho, req.params.id, padaria_id]
  );
  res.json({ ok: true, vinculado: r.affectedRows > 0 });
};

async function montarResumoCaixa(caixa) {
  const [porForma] = await db.query(
    `SELECT cp.forma_pagamento, COUNT(*) AS qtd, COALESCE(SUM(cp.valor), 0) AS total
     FROM comanda_pagamentos cp
     JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.caixa_id = ?
     GROUP BY cp.forma_pagamento`,
    [caixa.id]
  );
  // "Padaria" (consumo interno) e "Cortesia" não são receita de verdade — exclui do
  // Total Vendido pra bater exatamente com o Financeiro (mesma regra de lá), evitando
  // dois números diferentes de "total vendido" pro mesmo turno. "Faturado" conta
  // normal aqui (igual Pix/Débito/etc) — decisão da gerência.
  const [[totalVendas]] = await db.query(
    `SELECT COALESCE(SUM(cp.valor), 0) AS total
     FROM comanda_pagamentos cp
     JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.caixa_id = ? AND cp.forma_pagamento NOT IN ('Padaria', 'Cortesia')`,
    [caixa.id]
  );
  const [[totalDinheiro]] = await db.query(
    `SELECT COALESCE(SUM(cp.valor), 0) AS total
     FROM comanda_pagamentos cp
     JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.caixa_id = ? AND cp.forma_pagamento = 'Dinheiro'`,
    [caixa.id]
  );
  const [movimentos] = await db.query(
    `SELECT * FROM caixa_movimentos WHERE caixa_id = ? ORDER BY criado_em`, [caixa.id]
  );
  const totalSangrias = movimentos.filter(m => m.tipo === 'sangria').reduce((s, m) => s + parseFloat(m.valor), 0);
  const totalSuprimentos = movimentos.filter(m => m.tipo === 'suprimento').reduce((s, m) => s + parseFloat(m.valor), 0);
  // Despesas — sangria com motivo detalhado, lançada pela atendente na hora de fechar.
  // Sai da gaveta igual sangria, mas fica listada uma a uma no relatório (não só o total).
  const despesas = movimentos.filter(m => m.tipo === 'despesa');
  const totalDespesas = despesas.reduce((s, m) => s + parseFloat(m.valor), 0);

  const [[ajustes]] = await db.query(
    `SELECT COALESCE(SUM(desconto), 0) AS totalDescontos, COALESCE(SUM(acrescimo), 0) AS totalAcrescimos
     FROM comandas WHERE caixa_id = ? AND status = 'fechada'`,
    [caixa.id]
  );

  // Contagem de vendas (comandas fechadas nesse caixa) e total de itens vendidos —
  // igual ao "Qtd. Vendas" e "Total Itens" do relatório de fechamento do Saurus.
  const [[contagem]] = await db.query(
    `SELECT COUNT(DISTINCT c.id) AS qtdVendas, COALESCE(SUM(i.quantidade), 0) AS totalItens
     FROM comandas c
     LEFT JOIN itens_comanda i ON i.comanda_id = c.id
     WHERE c.caixa_id = ? AND c.status = 'fechada'`,
    [caixa.id]
  );

  // Recebimentos de fiado feitos nesse caixa (cliente Faturado pagando a conta) — o
  // dinheiro/pix entra no "Em Caixa" da forma em que foi pago. Try/catch: banco sem a
  // tabela ainda (migração não rodou) não pode derrubar o fechamento de caixa.
  let receitas = [];
  try {
    [receitas] = await db.query(
      `SELECT cliente_documento, cliente_nome, valor, forma_pagamento, criado_em
       FROM recebimentos_faturado WHERE caixa_id = ? ORDER BY criado_em, id`, [caixa.id]);
  } catch (e) { if (e.code !== 'ER_NO_SUCH_TABLE') throw e; }
  receitas = receitas.map(x => ({ ...x, valor: parseFloat(x.valor) }));
  const receitasPorFormaMap = {};
  for (const x of receitas) receitasPorFormaMap[x.forma_pagamento] = (receitasPorFormaMap[x.forma_pagamento] || 0) + x.valor;
  const receitasPorForma = Object.entries(receitasPorFormaMap).map(([forma_pagamento, total]) => ({ forma_pagamento, total }));
  const totalReceitas = receitas.reduce((s, x) => s + x.valor, 0);

  const esperadoEmDinheiro = parseFloat(caixa.valor_abertura) + parseFloat(totalDinheiro.total)
    + totalSuprimentos - totalSangrias - totalDespesas + (receitasPorFormaMap.Dinheiro || 0);

  return {
    porForma,
    totalVendas: parseFloat(totalVendas.total),
    totalDinheiro: parseFloat(totalDinheiro.total),
    totalDescontos: parseFloat(ajustes.totalDescontos),
    totalAcrescimos: parseFloat(ajustes.totalAcrescimos),
    totalSangrias, totalSuprimentos,
    totalDespesas,
    despesas: despesas.map(d => ({ descricao: d.observacao || '(sem descrição)', valor: parseFloat(d.valor) })),
    movimentos,
    esperadoEmDinheiro,
    receitas, receitasPorForma, totalReceitas,
    qtdVendas: contagem.qtdVendas,
    totalItens: parseFloat(contagem.totalItens),
  };
}

// Conferência por forma de pagamento: pra cada forma que teve movimento (mais
// "Dinheiro" sempre, mesmo sem venda, porque a gaveta sempre tem o troco de
// abertura pra conferir), calcula quanto o sistema lançou ("em caixa") e compara
// com o que a atendente digitou que contou/bateu do extrato ("fechado"). Forma
// não preenchida assume que bateu certinho — só a que ela digitar é conferida.
// Compartilhada entre fechar() e reimprimirFechamento() (mesma conta, os dois).
function calcularConferencia(caixa, resumo, formasInformadas) {
  // "Faturado" entra na conferência igual qualquer outra forma de pagamento
  // (Pix/Débito/etc) — a atendente confirma o valor e ele conta pra diferença
  // oficial do caixa se não bater, e soma normal no Total Vendido também.
  const formasParaConferir = [...(resumo.porForma || [])];
  if (!formasParaConferir.some(f => f.forma_pagamento === 'Dinheiro')) {
    formasParaConferir.unshift({ forma_pagamento: 'Dinheiro', total: 0 });
  }
  // Forma que só teve recebimento de fiado (sem venda) também precisa ser conferida.
  for (const rf of (resumo.receitasPorForma || [])) {
    if (!formasParaConferir.some(f => f.forma_pagamento === rf.forma_pagamento)) formasParaConferir.push({ forma_pagamento: rf.forma_pagamento, total: 0 });
  }
  const receitaDa = forma => (resumo.receitasPorForma || []).find(x => x.forma_pagamento === forma)?.total || 0;
  return formasParaConferir.map(f => {
    const ehDinheiro = f.forma_pagamento === 'Dinheiro';
    const emCaixa = (ehDinheiro
      ? parseFloat(caixa.valor_abertura) + parseFloat(f.total) + resumo.totalSuprimentos - resumo.totalSangrias - (resumo.totalDespesas || 0)
      : parseFloat(f.total)) + receitaDa(f.forma_pagamento);
    const bruto = formasInformadas[f.forma_pagamento];
    const fechado = (bruto !== undefined && bruto !== null && bruto !== '') ? (parseFloat(bruto) || 0) : emCaixa;
    return { forma_pagamento: f.forma_pagamento, em_caixa: emCaixa, fechado, diferenca: fechado - emCaixa };
  });
}

exports.fechar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { valor_fechamento, observacao, fechamento_formas } = req.body;
  const [[caixa]] = await db.query(
    `SELECT * FROM caixas WHERE id = ? AND padaria_id = ? AND status = 'aberto'`,
    [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado ou já fechado.' });
  if (caixaDeOutroAparelho(caixa, req)) return res.status(409).json({ erro: ERRO_OUTRO_APARELHO });

  // Despesas lançadas pela atendente na hora de fechar — grava ANTES de montar o
  // resumo, pra já entrarem na conta do "esperado em dinheiro" e na conferência.
  const despesas = Array.isArray(req.body.despesas) ? req.body.despesas : [];
  for (const d of despesas) {
    const valor = parseFloat(d.valor) || 0;
    const descricao = String(d.descricao || '').trim();
    if (valor <= 0 || !descricao) continue;
    // Se o banco ainda não tem 'despesa' na lista de tipos (ALTER TABLE sem permissão no
    // servidor), não pode derrubar o fechamento do caixa inteiro por causa disso — avisa
    // no log e segue sem essa despesa, em vez de travar a atendente sem conseguir fechar.
    try {
      await db.query(
        `INSERT INTO caixa_movimentos (caixa_id, tipo, valor, observacao) VALUES (?, 'despesa', ?, ?)`,
        [caixa.id, valor, descricao]
      );
    } catch (e) {
      console.error('Despesa do caixa não gravada (tipo "despesa" ainda não existe nesse banco?):', e.code || e.message);
    }
  }

  const resumo = await montarResumoCaixa(caixa);
  const formasInformadas = fechamento_formas && typeof fechamento_formas === 'object' ? fechamento_formas : {};
  const conferencia = calcularConferencia(caixa, resumo, formasInformadas);
  const diferencaTotal = conferencia.reduce((s, c) => s + c.diferenca, 0);
  const informadoDinheiro = conferencia.find(c => c.forma_pagamento === 'Dinheiro')?.fechado
    ?? (parseFloat(valor_fechamento) || 0);

  await db.query(
    `UPDATE caixas SET status = 'fechado', valor_fechamento = ?, valor_esperado = ?, fechamento_formas = ?, observacao = COALESCE(?, observacao), fechado_em = NOW()
     WHERE id = ?`,
    [informadoDinheiro, resumo.esperadoEmDinheiro, JSON.stringify(formasInformadas), observacao || null, caixa.id]
  );

  res.json({
    ok: true,
    esperado: resumo.esperadoEmDinheiro,
    informado: informadoDinheiro,
    diferenca: diferencaTotal,
    conferencia,
    resumo,
  });
};

// Refaz o mesmo comprovante de fechamento pra reimprimir depois — usado quando a
// impressão travou/foi bloqueada na hora. Funciona pra caixa aberto ou já fechado
// (nesse caso usa o que ficou salvo em fechamento_formas na hora do fechamento).
exports.reimprimirFechamento = async (req, res) => {
  const padaria_id = req.padaria.id;
  const [[caixa]] = await db.query(
    `SELECT * FROM caixas WHERE id = ? AND padaria_id = ?`, [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado.' });

  const resumo = await montarResumoCaixa(caixa);
  let formasInformadas = {};
  if (caixa.fechamento_formas) {
    try { formasInformadas = JSON.parse(caixa.fechamento_formas) || {}; } catch { formasInformadas = {}; }
  }
  const conferencia = calcularConferencia(caixa, resumo, formasInformadas);
  const diferencaTotal = conferencia.reduce((s, c) => s + c.diferenca, 0);

  res.json({ caixa: { ...caixa, resumo }, conferencia, diferenca: diferencaTotal });
};

exports.sangria = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { valor, observacao } = req.body;
  if (!valor || valor <= 0) return res.status(400).json({ erro: 'Valor inválido.' });

  const [[caixa]] = await db.query(
    `SELECT id FROM caixas WHERE id = ? AND padaria_id = ? AND status = 'aberto'`, [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado ou já fechado.' });

  await db.query(
    `INSERT INTO caixa_movimentos (caixa_id, tipo, valor, observacao) VALUES (?, 'sangria', ?, ?)`,
    [caixa.id, valor, observacao || null]
  );
  res.status(201).json({ ok: true });
};

exports.suprimento = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { valor, observacao } = req.body;
  if (!valor || valor <= 0) return res.status(400).json({ erro: 'Valor inválido.' });

  const [[caixa]] = await db.query(
    `SELECT id FROM caixas WHERE id = ? AND padaria_id = ? AND status = 'aberto'`, [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado ou já fechado.' });

  await db.query(
    `INSERT INTO caixa_movimentos (caixa_id, tipo, valor, observacao) VALUES (?, 'suprimento', ?, ?)`,
    [caixa.id, valor, observacao || null]
  );
  res.status(201).json({ ok: true });
};

// Despesa lançada na hora que acontece (não só na hora de fechar) — pensado pra
// atendente não precisar guardar papelzinho de fornecedor até o fim do turno, já
// que isso se perde fácil. Mesma tabela/efeito da despesa lançada no fechamento.
exports.despesa = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { valor, observacao } = req.body;
  const descricao = String(observacao || '').trim();
  if (!valor || valor <= 0) return res.status(400).json({ erro: 'Valor inválido.' });
  if (!descricao) return res.status(400).json({ erro: 'Descreve o que foi essa despesa.' });
  // Quem recebeu o dinheiro — opcional (nome, CPF ou CNPJ), vai no comprovante impresso.
  const favNome = String(req.body.favorecido_nome || '').trim().slice(0, 120) || null;
  const favDoc = String(req.body.favorecido_documento || '').replace(/\D/g, '') || null;
  if (favDoc && favDoc.length !== 11 && favDoc.length !== 14) {
    return res.status(400).json({ erro: 'CPF precisa ter 11 números e CNPJ 14.' });
  }

  const [[caixa]] = await db.query(
    `SELECT id FROM caixas WHERE id = ? AND padaria_id = ? AND status = 'aberto'`, [req.params.id, padaria_id]
  );
  if (!caixa) return res.status(404).json({ erro: 'Caixa não encontrado ou já fechado.' });

  try {
    await db.query(
      `INSERT INTO caixa_movimentos (caixa_id, tipo, valor, observacao, favorecido_nome, favorecido_documento) VALUES (?, 'despesa', ?, ?, ?, ?)`,
      [caixa.id, valor, descricao, favNome, favDoc]
    );
  } catch (e) {
    // Banco ainda sem as colunas novas — grava a despesa mesmo assim (o comprovante sai igual).
    if (e.code !== 'ER_BAD_FIELD_ERROR') throw e;
    await db.query(
      `INSERT INTO caixa_movimentos (caixa_id, tipo, valor, observacao) VALUES (?, 'despesa', ?, ?)`,
      [caixa.id, valor, descricao]
    );
  }
  res.status(201).json({ ok: true });
};
