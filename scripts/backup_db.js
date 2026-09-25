// Backup automático do banco — gera um .sql com CREATE TABLE + INSERT de tudo,
// compacta em .gz, e apaga backups mais velhos que RETENCAO_DIAS. Não depende do
// programa "mysqldump" (que não está disponível no PATH do Windows) — faz tudo via
// mysql2, então roda igual no VPS (Linux) e no servidor local (Windows).
// Uso: node scripts/backup_db.js
require('dotenv').config();
const fs = require('fs');
const path = require('path');
const zlib = require('zlib');
const mysql = require('mysql2/promise');

const RETENCAO_DIAS = 14;
const PASTA_BACKUP = path.join(__dirname, '..', 'backups');

function aspasSql(valor) {
  if (valor === null) return 'NULL';
  if (valor instanceof Date) return `'${valor.toISOString().slice(0, 19).replace('T', ' ')}'`;
  if (Buffer.isBuffer(valor)) return `X'${valor.toString('hex')}'`;
  if (typeof valor === 'number' || typeof valor === 'bigint') return String(valor);
  return `'${String(valor).replace(/\\/g, '\\\\').replace(/'/g, "''")}'`;
}

async function main() {
  const conn = await mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || '',
    database: process.env.DB_NAME || 'panificapro',
    timezone: '-03:00',
    multipleStatements: true,
  });

  const [tabelas] = await conn.query('SHOW TABLES');
  const nomeColuna = `Tables_in_${process.env.DB_NAME || 'panificapro'}`;
  const partes = [`-- Backup PanificaPro — ${new Date().toISOString()}\nSET FOREIGN_KEY_CHECKS=0;\n`];

  for (const linha of tabelas) {
    const tabela = linha[nomeColuna];
    const [[{ 'Create Table': createTable }]] = await conn.query(`SHOW CREATE TABLE \`${tabela}\``);
    partes.push(`\nDROP TABLE IF EXISTS \`${tabela}\`;\n${createTable};\n`);

    const [linhasTabela] = await conn.query(`SELECT * FROM \`${tabela}\``);
    if (linhasTabela.length) {
      const colunas = Object.keys(linhasTabela[0]);
      const valoresSql = linhasTabela
        .map(row => `(${colunas.map(c => aspasSql(row[c])).join(',')})`)
        .join(',\n');
      partes.push(`INSERT INTO \`${tabela}\` (${colunas.map(c => `\`${c}\``).join(',')}) VALUES\n${valoresSql};\n`);
    }
  }
  partes.push('\nSET FOREIGN_KEY_CHECKS=1;\n');
  await conn.end();

  if (!fs.existsSync(PASTA_BACKUP)) fs.mkdirSync(PASTA_BACKUP, { recursive: true });
  const carimbo = new Date().toISOString().replace(/[:.]/g, '-').slice(0, 19);
  const arquivoFinal = path.join(PASTA_BACKUP, `panificapro_${carimbo}.sql.gz`);
  const conteudoGz = zlib.gzipSync(Buffer.from(partes.join(''), 'utf8'));
  fs.writeFileSync(arquivoFinal, conteudoGz);
  console.log(`Backup salvo: ${arquivoFinal} (${(conteudoGz.length / 1024 / 1024).toFixed(2)} MB)`);

  // Rotação — apaga backups mais velhos que RETENCAO_DIAS, pra não lotar o disco.
  const agora = Date.now();
  const arquivos = fs.readdirSync(PASTA_BACKUP).filter(f => f.startsWith('panificapro_') && f.endsWith('.sql.gz'));
  for (const f of arquivos) {
    const caminho = path.join(PASTA_BACKUP, f);
    const idadeDias = (agora - fs.statSync(caminho).mtimeMs) / (1000 * 60 * 60 * 24);
    if (idadeDias > RETENCAO_DIAS) {
      fs.unlinkSync(caminho);
      console.log(`Backup antigo removido: ${f}`);
    }
  }
}

main().catch(e => { console.error('Falha no backup:', e.message); process.exit(1); });
