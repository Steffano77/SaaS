const db = require('../database/connection');

function fmtMoeda(v) {
  return 'R$ ' + parseFloat(v || 0).toLocaleString('pt-BR', { minimumFractionDigits: 2 });
}

const ICONES_FORMA = { 'Crédito': '💳', 'Débito': '💳', 'Voucher': '🎫', 'Pix': '⚡', 'Dinheiro': '💵' };

async function montarResumoDia(padaria_id, dia) {
  const [porForma] = await db.query(
    `SELECT forma_pagamento, COALESCE(SUM(valor),0) AS total
     FROM financeiro WHERE padaria_id = ? AND tipo = 'entrada' AND data = ?
     GROUP BY forma_pagamento ORDER BY total DESC`,
    [padaria_id, dia]
  );
  const [[totais]] = await db.query(
    `SELECT
       COALESCE(SUM(CASE WHEN tipo='entrada' THEN valor ELSE 0 END),0) AS total_entradas,
       COALESCE(SUM(CASE WHEN tipo='saida'   THEN valor ELSE 0 END),0) AS total_saidas
     FROM financeiro WHERE padaria_id = ? AND data = ?`,
    [padaria_id, dia]
  );
  return {
    total_entradas: parseFloat(totais.total_entradas),
    total_saidas: parseFloat(totais.total_saidas),
    saldo: parseFloat(totais.total_entradas) - parseFloat(totais.total_saidas),
    entradas_por_forma: porForma.map(p => ({ forma_pagamento: p.forma_pagamento, total: parseFloat(p.total) })),
  };
}

function montarHtmlEmail(padariaNome, dataLabel, resumo) {
  const linhasForma = resumo.entradas_por_forma.length
    ? resumo.entradas_por_forma.map(f => `
        <tr>
          <td style="padding:8px 0;color:#334155;">${ICONES_FORMA[f.forma_pagamento] || '💰'} ${f.forma_pagamento}</td>
          <td style="padding:8px 0;text-align:right;font-weight:600;color:#1e3a5f;">${fmtMoeda(f.total)}</td>
        </tr>`).join('')
    : `<tr><td colspan="2" style="padding:8px 0;color:#94a3b8;">Nenhuma entrada registrada hoje.</td></tr>`;

  return `
    <div style="font-family:Inter,Arial,sans-serif;max-width:480px;margin:0 auto;padding:32px;background:#f8fafc;">
      <div style="background:#fff;border-radius:16px;padding:28px;box-shadow:0 1px 3px rgba(0,0,0,0.08);">
        <h2 style="color:#1e3a5f;margin:0 0 4px;">📊 Resumo de hoje</h2>
        <p style="color:#94a3b8;margin:0 0 20px;font-size:13px;">${padariaNome} · ${dataLabel}</p>

        <table style="width:100%;border-collapse:collapse;margin-bottom:16px;">
          ${linhasForma}
        </table>

        <div style="border-top:1px solid #e2e8f0;padding-top:12px;">
          <table style="width:100%;">
            <tr><td style="color:#16a34a;font-weight:700;">Total de entradas</td><td style="text-align:right;font-weight:700;color:#16a34a;">${fmtMoeda(resumo.total_entradas)}</td></tr>
            <tr><td style="color:#dc2626;font-weight:700;padding-top:6px;">Total de saídas</td><td style="text-align:right;font-weight:700;color:#dc2626;padding-top:6px;">${fmtMoeda(resumo.total_saidas)}</td></tr>
          </table>
        </div>

        <div style="background:#1e3a5f;border-radius:12px;padding:14px 18px;margin-top:16px;display:flex;justify-content:space-between;align-items:center;">
          <span style="color:#fff;font-size:14px;">Saldo do dia</span>
          <strong style="color:#f97316;font-size:20px;">${fmtMoeda(resumo.saldo)}</strong>
        </div>
      </div>
      <p style="color:#94a3b8;font-size:11px;text-align:center;margin-top:16px;">PanificaPro — enviado automaticamente todo dia às 21h.</p>
    </div>`;
}

async function enviarResumoDiarioParaTodos() {
  if (!process.env.RESEND_API_KEY) {
    console.log('[relatorio-diario] RESEND_API_KEY não configurado, pulando envio.');
    return;
  }
  const hoje = new Date().toISOString().slice(0, 10);
  const dataLabel = new Date().toLocaleDateString('pt-BR', { day: '2-digit', month: 'long', year: 'numeric' });

  const [padarias] = await db.query(
    `SELECT id, nome, COALESCE(NULLIF(email_relatorio, ''), email) AS email_destino
     FROM padarias WHERE ativo = 1 AND plano = 'premium'
       AND COALESCE(NULLIF(email_relatorio, ''), email) IS NOT NULL`
  );

  const { Resend } = require('resend');
  const resend = new Resend(process.env.RESEND_API_KEY);

  for (const padaria of padarias) {
    try {
      const resumo = await montarResumoDia(padaria.id, hoje);
      // Não manda email se não teve nenhuma movimentação no dia
      if (resumo.total_entradas === 0 && resumo.total_saidas === 0) continue;

      const { data, error } = await resend.emails.send({
        from: process.env.EMAIL_FROM || 'PanificaPro <onboarding@resend.dev>',
        to: padaria.email_destino,
        subject: `📊 Resumo de hoje — ${padaria.nome}`,
        html: montarHtmlEmail(padaria.nome, dataLabel, resumo),
      });
      if (error) {
        console.error(`[relatorio-diario] Resend recusou o envio para ${padaria.email_destino}:`, error);
        continue;
      }
      console.log(`[relatorio-diario] Enviado para ${padaria.email_destino} (${padaria.nome}), id: ${data?.id}`);
    } catch (e) {
      console.error(`[relatorio-diario] Erro ao enviar para padaria ${padaria.id}:`, e.message);
    }
  }
}

function iniciarJobRelatorioDiario() {
  const cron = require('node-cron');
  // Todo dia às 21h, horário de Brasília
  cron.schedule('0 21 * * *', () => {
    console.log('[relatorio-diario] Iniciando envio dos resumos diários...');
    enviarResumoDiarioParaTodos().catch(e => console.error('[relatorio-diario] Erro geral:', e));
  }, { timezone: 'America/Sao_Paulo' });
  console.log('[relatorio-diario] Job agendado para 21h (America/Sao_Paulo).');
}

module.exports = { iniciarJobRelatorioDiario, enviarResumoDiarioParaTodos, montarResumoDia, montarHtmlEmail };
