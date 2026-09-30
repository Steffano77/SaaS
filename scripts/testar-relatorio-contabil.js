require('dotenv').config();
const db = require('../src/database/connection');
const { montarZipDoMes, montarHtmlEmail } = require('../src/jobs/relatorioContabilMensal');

// Teste manual do relatório contábil — manda pra um e-mail escolhido (não o da
// contabilidade de verdade), forçando o mês/ano em vez de usar "mês anterior".
(async () => {
  const destinoTeste = process.argv[2];
  const competencia = process.argv[3]; // formato "2026-09"
  if (!destinoTeste || !competencia) {
    console.log('Uso: node scripts/testar-relatorio-contabil.js <email-destino> <AAAA-MM>');
    process.exit(1);
  }
  const [ano, mes] = competencia.split('-');
  const label = new Date(ano, mes - 1, 1).toLocaleDateString('pt-BR', { month: 'long', year: 'numeric' });

  const padaria_id = 1;
  const [[padaria]] = await db.query('SELECT nome FROM padarias WHERE id = ?', [padaria_id]);

  const { notas, zipBuffer } = await montarZipDoMes(padaria_id, ano, mes);
  if (!notas.length) {
    console.log(`Nenhuma nota autorizada em ${label} — nada pra mandar.`);
    process.exit(0);
  }

  const { Resend } = require('resend');
  const resend = new Resend(process.env.RESEND_API_KEY);
  const { data, error } = await resend.emails.send({
    from: process.env.EMAIL_FROM || 'PanificaPro <onboarding@resend.dev>',
    to: destinoTeste,
    subject: `[TESTE] 🧾 NFC-e ${label} — ${padaria.nome} (${notas.length} notas)`,
    html: montarHtmlEmail(padaria.nome, label, notas),
    attachments: [{
      filename: `NFCe_${padaria.nome.replace(/[^a-zA-Z0-9]/g, '_')}_${ano}-${mes}.zip`,
      content: zipBuffer.toString('base64'),
    }],
  });

  if (error) {
    console.error('Resend recusou o envio:', error);
    process.exit(1);
  }
  console.log(`Enviado para ${destinoTeste} — ${notas.length} notas, id: ${data?.id}`);
  process.exit(0);
})();
