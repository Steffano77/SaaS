// Manda uma cópia do .env atual por e-mail, pra guardar num lugar seguro fora do PC da padaria.
// Uso: node scripts/enviar-copia-env.js
require('dotenv').config();
const fs = require('fs');
const path = require('path');

async function main() {
  if (!process.env.RESEND_API_KEY) {
    console.error('RESEND_API_KEY não configurado — não dá pra enviar por e-mail.');
    process.exit(1);
  }
  const destino = process.env.BACKUP_EMAIL || process.env.EMAIL_FROM;
  if (!destino) {
    console.error('BACKUP_EMAIL não configurado no .env.');
    process.exit(1);
  }

  const caminhoEnv = path.join(__dirname, '..', '.env');
  const conteudo = fs.readFileSync(caminhoEnv);

  const { Resend } = require('resend');
  const resend = new Resend(process.env.RESEND_API_KEY);

  const { data, error } = await resend.emails.send({
    from: process.env.EMAIL_FROM || 'PanificaPro <onboarding@resend.dev>',
    to: destino,
    subject: `🔐 Cópia de segurança do .env — ${new Date().toLocaleDateString('pt-BR')}`,
    html: `<p>Em anexo, uma cópia do arquivo de configuração (.env) do sistema.</p>
           <p style="color:#dc2626;font-weight:600;">Guarde esse e-mail num lugar seguro — ele tem senhas e dados sensíveis. Só precisa dele em caso de restaurar o sistema numa máquina nova.</p>`,
    attachments: [{ filename: 'env-backup.txt', content: conteudo.toString('base64') }],
  });

  if (error) {
    console.error('ERRO ao enviar:', JSON.stringify(error));
    process.exit(1);
  }
  console.log(`Enviado para ${destino}, id: ${data?.id}`);
}

main();
