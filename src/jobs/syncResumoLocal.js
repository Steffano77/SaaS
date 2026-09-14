// Projeto "servidor local" (resiliência offline) — SÓ roda quando o próprio servidor
// está configurado como o servidor local da padaria (variáveis de ambiente próprias,
// nunca configuradas no servidor de produção). No servidor de produção normal, essas
// variáveis não existem, então esse job nem inicia — zero efeito lá.
//
// O que faz: de tempos em tempos, quando tiver internet, calcula um RESUMO do dia
// (total vendido, comandas fechadas/abertas — nunca dado bruto linha a linha) e manda
// pra nuvem via a própria API pública do sistema (login normal + POST autenticado).
// Isso NUNCA mistura banco de dados — é só um boletim informativo pro dono acompanhar
// de casa enquanto o servidor local continua sendo a única fonte de verdade das vendas.

const db = require('../database/connection');

let tokenCache = null;
let tokenObtidoEm = 0;

async function obterToken(cloudUrl, email, senha) {
  // Reaproveita o token por um tempo — não faz login toda hora à toa.
  if (tokenCache && (Date.now() - tokenObtidoEm) < 50 * 60 * 1000) return tokenCache;
  const r = await fetch(`${cloudUrl}/api/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, senha }),
  });
  if (!r.ok) throw new Error(`Login na nuvem falhou (${r.status})`);
  const data = await r.json();
  tokenCache = data.token;
  tokenObtidoEm = Date.now();
  return tokenCache;
}

async function montarResumoDeHoje() {
  const hoje = new Date().toISOString().slice(0, 10);
  const [[vendas]] = await db.query(
    `SELECT COALESCE(SUM(cp.valor), 0) AS total, COUNT(DISTINCT c.id) AS qtd
     FROM comanda_pagamentos cp
     JOIN comandas c ON c.id = cp.comanda_id
     WHERE c.status = 'fechada' AND DATE(c.fechada_em) = ? AND cp.forma_pagamento NOT IN ('Padaria', 'Cortesia')`,
    [hoje]
  );
  const [[abertas]] = await db.query(
    `SELECT COUNT(*) AS qtd FROM comandas WHERE status = 'aberta'`
  );
  // Notas fiscais com problema hoje (rejeitada, erro, ou ainda pendente) — dono acompanha
  // de longe que tem algo pra resolver, mesmo sem poder resolver de longe ainda (só ver).
  const [[notasProblema]] = await db.query(
    `SELECT COUNT(*) AS qtd FROM notas_fiscais WHERE DATE(criado_em) = ? AND status IN ('rejeitada','erro','pendente')`,
    [hoje]
  );
  return {
    data: hoje,
    total_vendas: parseFloat(vendas.total),
    qtd_comandas_fechadas: vendas.qtd,
    qtd_comandas_abertas: abertas.qtd,
    qtd_notas_problema: notasProblema.qtd,
  };
}

async function enviarResumo() {
  const cloudUrl = process.env.SYNC_CLOUD_URL;
  const email = process.env.SYNC_CLOUD_EMAIL;
  const senha = process.env.SYNC_CLOUD_SENHA;
  if (!cloudUrl || !email || !senha) return; // não configurado como servidor local — não faz nada

  try {
    const resumo = await montarResumoDeHoje();
    const token = await obterToken(cloudUrl, email, senha);
    const r = await fetch(`${cloudUrl}/api/sync/resumo-local`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${token}` },
      body: JSON.stringify(resumo),
    });
    if (!r.ok) {
      tokenCache = null; // token pode ter expirado/inválido — força login de novo na próxima
      console.error('[sync-resumo-local] Falha ao mandar resumo:', r.status);
      return;
    }
    console.log('[sync-resumo-local] Resumo enviado:', resumo);
  } catch (e) {
    // Sem internet, ou nuvem fora do ar — normal acontecer, não trava nada local.
    console.error('[sync-resumo-local] Não deu pra enviar (sem internet?):', e.message);
  }
}

function iniciarJobSyncResumoLocal() {
  // SYNC_INTERVALO_SEGUNDOS tem prioridade (intervalos curtos tipo 30s); cai pro antigo
  // _MINUTOS se não tiver (compatibilidade), padrão 15 minutos.
  const intervaloSeg = parseInt(process.env.SYNC_INTERVALO_SEGUNDOS, 10)
    || (parseInt(process.env.SYNC_INTERVALO_MINUTOS, 10) || 15) * 60;
  if (!process.env.SYNC_CLOUD_URL) return; // servidor normal (produção) — não ativa esse job

  console.log(`[sync-resumo-local] Ativado — mandando resumo a cada ${intervaloSeg}s pra ${process.env.SYNC_CLOUD_URL}`);
  enviarResumo(); // já manda um assim que liga, sem esperar o primeiro intervalo
  setInterval(enviarResumo, intervaloSeg * 1000);
}

module.exports = { iniciarJobSyncResumoLocal, montarResumoDeHoje, enviarResumo };
