const fs = require('fs');
const path = require('path');
const zlib = require('zlib');
const { execFile } = require('child_process');

const PASTA_BACKUPS = path.join(__dirname, '..', '..', 'backups');
const MAX_BACKUPS_GUARDADOS = 14;

// mysqldump nem sempre está no PATH do Windows — tenta os caminhos de instalação mais comuns
// antes de desistir.
function localizarMysqldump() {
  if (process.env.MYSQLDUMP_PATH && fs.existsSync(process.env.MYSQLDUMP_PATH)) {
    return process.env.MYSQLDUMP_PATH;
  }

  const candidatos = ['mysqldump', 'mysqldump.exe'];

  const basesWindows = [
    'C:\\xampp\\mysql\\bin',
    'C:\\wamp64\\bin\\mysql',
    'C:\\Program Files\\MySQL',
    'C:\\Program Files\\MariaDB',
  ];
  for (const base of basesWindows) {
    if (!fs.existsSync(base)) continue;
    try {
      for (const sub of fs.readdirSync(base)) {
        const full = path.join(base, sub, 'bin', 'mysqldump.exe');
        if (fs.existsSync(full)) candidatos.push(full);
      }
    } catch (_) { /* ignora pasta sem permissão */ }
  }
  candidatos.push('/usr/bin/mysqldump', '/usr/local/bin/mysqldump', '/usr/local/mysql/bin/mysqldump');

  for (const c of candidatos) {
    if (c.includes(path.sep) && !fs.existsSync(c)) continue;
    return c; // para os que não têm caminho completo (ex: "mysqldump"), deixa o PATH resolver na hora de rodar
  }
  return null;
}

function nomeArquivoBackup(padariaNome) {
  const agora = new Date();
  const stamp = agora.toISOString().replace(/[:T]/g, '-').slice(0, 19);
  const nomeLimpo = (padariaNome || 'padaria').replace(/[^a-zA-Z0-9]/g, '_');
  return `backup_${nomeLimpo}_${stamp}.sql.gz`;
}

async function gerarBackup() {
  const mysqldump = localizarMysqldump();
  if (!mysqldump) {
    throw new Error(
      'mysqldump não encontrado. Defina MYSQLDUMP_PATH no .env apontando pro mysqldump.exe (ex: dentro da pasta de instalação do MySQL/XAMPP).'
    );
  }

  if (!fs.existsSync(PASTA_BACKUPS)) fs.mkdirSync(PASTA_BACKUPS, { recursive: true });

  const nomeArquivo = nomeArquivoBackup(process.env.DB_NAME || 'panificapro');
  const caminhoFinal = path.join(PASTA_BACKUPS, nomeArquivo);

  const args = [
    `--host=${process.env.DB_HOST || 'localhost'}`,
    `--port=${process.env.DB_PORT || 3306}`,
    `--user=${process.env.DB_USER || 'root'}`,
    '--single-transaction',
    '--routines',
    '--triggers',
    process.env.DB_NAME || 'panificapro',
  ];

  const dump = await new Promise((resolve, reject) => {
    execFile(
      mysqldump,
      args,
      { env: { ...process.env, MYSQL_PWD: process.env.DB_PASS || '' }, maxBuffer: 1024 * 1024 * 512 },
      (erro, stdout, stderr) => {
        if (erro) return reject(new Error(`mysqldump falhou: ${stderr || erro.message}`));
        resolve(stdout);
      }
    );
  });

  await new Promise((resolve, reject) => {
    zlib.gzip(dump, (erro, buffer) => {
      if (erro) return reject(erro);
      fs.writeFile(caminhoFinal, buffer, (erroEscrita) => (erroEscrita ? reject(erroEscrita) : resolve()));
    });
  });

  return caminhoFinal;
}

function limparBackupsAntigos() {
  if (!fs.existsSync(PASTA_BACKUPS)) return;
  const arquivos = fs.readdirSync(PASTA_BACKUPS)
    .filter(f => f.startsWith('backup_') && f.endsWith('.sql.gz'))
    .map(f => ({ nome: f, caminho: path.join(PASTA_BACKUPS, f), mtime: fs.statSync(path.join(PASTA_BACKUPS, f)).mtimeMs }))
    .sort((a, b) => b.mtime - a.mtime);

  for (const antigo of arquivos.slice(MAX_BACKUPS_GUARDADOS)) {
    fs.unlinkSync(antigo.caminho);
  }
}

async function enviarBackupPorEmail(caminhoArquivo) {
  if (!process.env.RESEND_API_KEY) {
    console.log('[backup-local] RESEND_API_KEY não configurado, backup ficou só salvo localmente.');
    return;
  }
  const destino = process.env.BACKUP_EMAIL || process.env.EMAIL_FROM;
  if (!destino) {
    console.log('[backup-local] BACKUP_EMAIL não configurado, backup ficou só salvo localmente.');
    return;
  }

  const { Resend } = require('resend');
  const resend = new Resend(process.env.RESEND_API_KEY);
  const conteudo = fs.readFileSync(caminhoArquivo);
  const nomeArquivo = path.basename(caminhoArquivo);

  const { data, error } = await resend.emails.send({
    from: process.env.EMAIL_FROM || 'PanificaPro <onboarding@resend.dev>',
    to: destino,
    subject: `💾 Backup PanificaPro — ${new Date().toLocaleString('pt-BR')}`,
    html: `<p>Backup automático do banco de dados em anexo.</p><p style="color:#94a3b8;font-size:12px;">Guarde este e-mail — em caso de emergência, é esse arquivo que restaura o sistema.</p>`,
    attachments: [{ filename: nomeArquivo, content: conteudo.toString('base64') }],
  });

  if (error) throw new Error(`Resend recusou o envio do backup: ${JSON.stringify(error)}`);
  console.log(`[backup-local] Backup enviado por e-mail para ${destino}, id: ${data?.id}`);
}

async function rodarBackup() {
  console.log('[backup-local] Iniciando backup...');
  const caminho = await gerarBackup();
  console.log(`[backup-local] Backup salvo em ${caminho}`);
  limparBackupsAntigos();
  await enviarBackupPorEmail(caminho);
}

function iniciarJobBackupLocal() {
  const cron = require('node-cron');
  // A cada 6h (00h, 6h, 12h, 18h) — perda máxima de dados em caso de desastre fica em algumas horas.
  cron.schedule('0 */6 * * *', () => {
    rodarBackup().catch(e => console.error('[backup-local] Erro no backup automático:', e.message));
  }, { timezone: 'America/Sao_Paulo' });
  console.log('[backup-local] Job de backup agendado a cada 6h (America/Sao_Paulo).');
}

module.exports = { iniciarJobBackupLocal, rodarBackup, gerarBackup, localizarMysqldump };
