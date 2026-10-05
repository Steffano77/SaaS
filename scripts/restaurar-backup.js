// Restaura um backup .sql.gz num banco MySQL/MariaDB novo.
// Uso: node scripts/restaurar-backup.js caminho/para/backup_xxx.sql.gz
require('dotenv').config();
const fs = require('fs');
const path = require('path');
const zlib = require('zlib');
const { execFile } = require('child_process');
const { localizarMysqldump } = require('../src/jobs/backupLocal');

function localizarMysql() {
  if (process.env.MYSQL_CLI_PATH && fs.existsSync(process.env.MYSQL_CLI_PATH)) {
    return process.env.MYSQL_CLI_PATH;
  }
  // mysqldump e mysql ficam sempre na mesma pasta bin/ — reaproveita a busca do mysqldump.
  const dump = localizarMysqldump();
  if (dump && dump.toLowerCase().includes('mysqldump')) {
    const candidato = dump.replace(/mysqldump(\.exe)?$/i, process.platform === 'win32' ? 'mysql.exe' : 'mysql');
    if (fs.existsSync(candidato) || !candidato.includes(path.sep)) return candidato;
  }
  return 'mysql';
}

async function main() {
  const caminhoBackup = process.argv[2];
  if (!caminhoBackup) {
    console.error('Uso: node scripts/restaurar-backup.js caminho/para/backup_xxx.sql.gz');
    process.exit(1);
  }
  if (!fs.existsSync(caminhoBackup)) {
    console.error(`Arquivo não encontrado: ${caminhoBackup}`);
    process.exit(1);
  }

  console.log('Descompactando backup...');
  const comprimido = fs.readFileSync(caminhoBackup);
  const sql = zlib.gunzipSync(comprimido);

  const mysql = localizarMysql();
  const dbName = process.env.DB_NAME || 'panificapro';

  console.log(`Criando banco "${dbName}" (se não existir)...`);
  await new Promise((resolve, reject) => {
    execFile(
      mysql,
      [
        `--host=${process.env.DB_HOST || 'localhost'}`,
        `--port=${process.env.DB_PORT || 3306}`,
        `--user=${process.env.DB_USER || 'root'}`,
        '-e', `CREATE DATABASE IF NOT EXISTS \`${dbName}\` CHARACTER SET utf8mb4;`,
      ],
      { env: { ...process.env, MYSQL_PWD: process.env.DB_PASS || '' } },
      (erro, _stdout, stderr) => (erro ? reject(new Error(stderr || erro.message)) : resolve())
    );
  });

  console.log('Restaurando dados (pode levar alguns minutos)...');
  await new Promise((resolve, reject) => {
    const proc = execFile(
      mysql,
      [
        `--host=${process.env.DB_HOST || 'localhost'}`,
        `--port=${process.env.DB_PORT || 3306}`,
        `--user=${process.env.DB_USER || 'root'}`,
        dbName,
      ],
      { env: { ...process.env, MYSQL_PWD: process.env.DB_PASS || '' }, maxBuffer: 1024 * 1024 * 512 },
      (erro, _stdout, stderr) => (erro ? reject(new Error(stderr || erro.message)) : resolve())
    );
    proc.stdin.write(sql);
    proc.stdin.end();
  });

  console.log('Restauração concluída! Agora rode: npm install && pm2 start src/index.js --name panificapro-local');
}

main().catch(e => { console.error('ERRO na restauração:', e.message); process.exit(1); });
