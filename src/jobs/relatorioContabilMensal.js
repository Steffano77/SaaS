const db = require('../database/connection');

// Monta o nome do mês anterior no formato que a contabilidade vai reconhecer,
// ex: "julho de 2026" e "2026-07".
function mesAnterior(referencia = new Date()) {
  const d = new Date(referencia.getFullYear(), referencia.getMonth() - 1, 1);
  const ano = d.getFullYear();
  const mes = String(d.getMonth() + 1).padStart(2, '0');
  const label = d.toLocaleDateString('pt-BR', { month: 'long', year: 'numeric' });
  return { ano, mes, competencia: `${ano}-${mes}`, label };
}

function fmtMoeda(v) {
  return 'R$ ' + parseFloat(v || 0).toLocaleString('pt-BR', { minimumFractionDigits: 2 });
}

// CSV simples com uma linha por nota — abre certinho no Excel (separador ; pro padrão BR).
function montarCsvResumo(notas) {
  const linhas = [
    ['Número', 'Série', 'Chave de acesso', 'Data/hora', 'Status', 'Valor'].join(';'),
  ];
  for (const n of notas) {
    linhas.push([
      n.numero,
      n.serie,
      n.chave_acesso || '',
      n.autorizada_em ? new Date(n.autorizada_em).toLocaleString('pt-BR') : '',
      n.status,
      fmtMoeda(n.valor_total).replace('R$ ', ''),
    ].join(';'));
  }
  return linhas.join('\r\n');
}

async function montarZipDoMes(padaria_id, ano, mes) {
  const inicio = `${ano}-${mes}-01 00:00:00`;
  const fimData = new Date(ano, parseInt(mes, 10), 1); // dia 1 do mês seguinte
  const fim = fimData.toISOString().slice(0, 10) + ' 00:00:00';

  // ambiente = 1 é Produção (nota que vale de verdade); ambiente = 2 é Homologação
  // (teste da Sefaz, não tem validade nenhuma) — a contabilidade só pode receber as de
  // Produção, senão mistura nota de teste com nota real no livro fiscal dela.
  const [notas] = await db.query(
    `SELECT id, numero, serie, chave_acesso, status, valor_total, xml_assinado, autorizada_em
     FROM notas_fiscais
     WHERE padaria_id = ? AND status = 'autorizada' AND ambiente = 1
       AND autorizada_em >= ? AND autorizada_em < ?
     ORDER BY numero`,
    [padaria_id, inicio, fim]
  );

  if (!notas.length) return { notas, zipBuffer: null };
  return { notas, zipBuffer: await zipDasNotas(notas) };
}

// ZIP com o XML de cada nota + resumo.csv só dessas notas.
async function zipDasNotas(notas) {
  const archiver = require('archiver');
  const chunks = [];
  const zip = archiver('zip', { zlib: { level: 9 } });
  zip.on('data', (chunk) => chunks.push(chunk));

  const zipDonePromise = new Promise((resolve, reject) => {
    zip.on('end', resolve);
    zip.on('error', reject);
  });

  for (const n of notas) {
    if (!n.xml_assinado) continue;
    const nomeArquivo = `NFCe_${String(n.numero).padStart(9, '0')}_${n.chave_acesso || n.id}.xml`;
    zip.append(n.xml_assinado, { name: nomeArquivo });
  }
  zip.append(montarCsvResumo(notas), { name: 'resumo.csv' });
  zip.finalize();

  await zipDonePromise;
  return Buffer.concat(chunks);
}

// ZIP de cada e-mail fica com no máximo isso. Bug real (Jota 3, outubro/2026): 9.147
// notas deram um ZIP de 35 MB (46,7 MB no e-mail, em base64) — passa do limite do
// Resend (40 MB) e de provedores como o Terra da contabilidade. 7 MB vira ~9,3 MB no
// e-mail, que a maioria dos provedores aceita.
const LIMITE_ZIP_POR_EMAIL = 7 * 1024 * 1024;

// Divide as notas do mês em partes, cada uma num ZIP até o limite. Começa pelo número
// de partes que o tamanho total sugere e aumenta se alguma passar do limite.
async function montarPartesDoMes(padaria_id, ano, mes, limite = LIMITE_ZIP_POR_EMAIL) {
  const { notas, zipBuffer } = await montarZipDoMes(padaria_id, ano, mes);
  if (!notas.length) return { notas, partes: [] };
  if (zipBuffer.length <= limite) return { notas, partes: [{ notas, zipBuffer }] };

  let qtd = Math.ceil(zipBuffer.length / limite);
  while (qtd <= notas.length) {
    const porParte = Math.ceil(notas.length / qtd);
    const partes = [];
    let coube = true;
    for (let i = 0; i < notas.length; i += porParte) {
      const fatia = notas.slice(i, i + porParte);
      const buf = await zipDasNotas(fatia);
      if (buf.length > limite) { coube = false; break; }
      partes.push({ notas: fatia, zipBuffer: buf });
    }
    if (coube) return { notas, partes };
    qtd++;
  }
  throw new Error('não foi possível dividir as notas em ZIPs dentro do limite');
}

function montarHtmlEmail(padariaNome, label, notas, parte) {
  const total = notas.reduce((s, n) => s + parseFloat(n.valor_total || 0), 0);
  const avisoParte = parte && parte.de > 1 ? `
        <p style="color:#9a3412;font-size:13px;margin-top:16px;font-weight:700;">Parte ${parte.num} de ${parte.de}: notas nº ${parte.primeira} a ${parte.ultima} (${parte.qtd} notas). Os XMLs do mês vieram divididos em ${parte.de} e-mails por causa do tamanho do anexo.</p>` : '';
  return `
    <div style="font-family:Inter,Arial,sans-serif;max-width:480px;margin:0 auto;padding:32px;background:#f8fafc;">
      <div style="background:#fff;border-radius:16px;padding:28px;box-shadow:0 1px 3px rgba(0,0,0,0.08);">
        <h2 style="color:#1e3a5f;margin:0 0 4px;">🧾 Notas fiscais — ${label}</h2>
        <p style="color:#94a3b8;margin:0 0 20px;font-size:13px;">${padariaNome}</p>
        <table style="width:100%;">
          <tr><td style="color:#334155;">Notas emitidas</td><td style="text-align:right;font-weight:700;color:#1e3a5f;">${notas.length}</td></tr>
          <tr><td style="color:#334155;padding-top:6px;">Valor total</td><td style="text-align:right;font-weight:700;color:#1e3a5f;padding-top:6px;">${fmtMoeda(total)}</td></tr>
        </table>
        ${avisoParte}
        <p style="color:#64748b;font-size:13px;margin-top:16px;">Em anexo, o zip com os XMLs das notas autorizadas no período e uma planilha resumo (resumo.csv).</p>
      </div>
      <p style="color:#94a3b8;font-size:11px;text-align:center;margin-top:16px;">PanificaPro — enviado automaticamente todo dia 1º do mês.</p>
    </div>`;
}

async function enviarRelatorioContabilMensal(referencia = new Date()) {
  if (!process.env.RESEND_API_KEY) {
    console.log('[relatorio-contabil] RESEND_API_KEY não configurado, pulando envio.');
    return;
  }
  const { ano, mes, label } = mesAnterior(referencia);

  const [padarias] = await db.query(
    `SELECT id, nome, email_contabilidade FROM padarias
     WHERE ativo = 1 AND email_contabilidade IS NOT NULL AND email_contabilidade <> ''`
  );

  if (!padarias.length) {
    console.log('[relatorio-contabil] Nenhuma padaria com email_contabilidade configurado.');
    return;
  }

  const { Resend } = require('resend');
  const resend = new Resend(process.env.RESEND_API_KEY);

  for (const padaria of padarias) {
    try {
      const { notas, partes } = await montarPartesDoMes(padaria.id, ano, mes);
      if (!notas.length) {
        console.log(`[relatorio-contabil] Padaria ${padaria.id} (${padaria.nome}) sem notas autorizadas em ${label}, pulando.`);
        continue;
      }

      const nomeBase = `NFCe_${padaria.nome.replace(/[^a-zA-Z0-9]/g, '_')}_${ano}-${mes}`;
      for (let i = 0; i < partes.length; i++) {
        const p = partes[i];
        const de = partes.length;
        const sufixo = de > 1 ? ` — parte ${i + 1} de ${de}` : '';
        const infoParte = { num: i + 1, de, qtd: p.notas.length, primeira: p.notas[0].numero, ultima: p.notas[p.notas.length - 1].numero };
        const { data, error } = await resend.emails.send({
          from: process.env.EMAIL_FROM || 'PanificaPro <onboarding@resend.dev>',
          to: padaria.email_contabilidade,
          subject: `🧾 NFC-e ${label} — ${padaria.nome} (${notas.length} notas)${sufixo}`,
          html: montarHtmlEmail(padaria.nome, label, notas, infoParte),
          attachments: [{
            filename: de > 1 ? `${nomeBase}_parte${i + 1}de${de}.zip` : `${nomeBase}.zip`,
            content: p.zipBuffer.toString('base64'),
          }],
        });
        if (error) {
          console.error(`[relatorio-contabil] Resend recusou o envio${sufixo} para ${padaria.email_contabilidade}:`, error);
        } else {
          console.log(`[relatorio-contabil] Enviado${sufixo} para ${padaria.email_contabilidade} (${padaria.nome}), ${p.notas.length} de ${notas.length} notas, ${(p.zipBuffer.length / 1048576).toFixed(1)} MB, id: ${data?.id}`);
        }
        // O Resend aceita poucos envios por segundo — espaça as partes.
        if (i < partes.length - 1) await new Promise(r => setTimeout(r, 1500));
      }
    } catch (e) {
      console.error(`[relatorio-contabil] Erro ao enviar para padaria ${padaria.id}:`, e.message);
    }
  }
}

function iniciarJobRelatorioContabilMensal() {
  const cron = require('node-cron');
  // Todo dia 1º do mês às 6h, horário de Brasília — manda o relatório do mês que acabou de fechar.
  cron.schedule('0 6 1 * *', () => {
    console.log('[relatorio-contabil] Iniciando envio do relatório contábil mensal...');
    enviarRelatorioContabilMensal().catch(e => console.error('[relatorio-contabil] Erro geral:', e));
  }, { timezone: 'America/Sao_Paulo' });
  console.log('[relatorio-contabil] Job agendado para dia 1º às 6h (America/Sao_Paulo).');
}

module.exports = { iniciarJobRelatorioContabilMensal, enviarRelatorioContabilMensal, mesAnterior, montarZipDoMes, montarPartesDoMes, montarHtmlEmail };
