// Varredura só de LEITURA — não apaga nada sozinho, só mostra números pra decidir
// o que vale limpar de verdade. Cobre: tamanho de pastas pesadas (node_modules, .git,
// logs do PM2), tamanho/quantidade de linhas das tabelas do banco, e arquivos soltos
// na raiz do projeto que não deveriam estar lá (sobra de comando colado errado).
// Uso: node scripts\diagnosticar-servidor.js
require('dotenv').config();
const fs = require('fs');
const path = require('path');
const os = require('os');
const db = require('../src/database/connection');

function tamanhoPasta(pasta) {
  if (!fs.existsSync(pasta)) return 0;
  let total = 0;
  const itens = fs.readdirSync(pasta, { withFileTypes: true });
  for (const item of itens) {
    const caminho = path.join(pasta, item.name);
    try {
      if (item.isDirectory()) total += tamanhoPasta(caminho);
      else total += fs.statSync(caminho).size;
    } catch (e) { /* arquivo bloqueado/sem permissão — ignora e segue */ }
  }
  return total;
}

function fmtTamanho(bytes) {
  if (bytes > 1024 ** 3) return (bytes / 1024 ** 3).toFixed(2) + ' GB';
  if (bytes > 1024 ** 2) return (bytes / 1024 ** 2).toFixed(1) + ' MB';
  return (bytes / 1024).toFixed(0) + ' KB';
}

(async () => {
  const raiz = path.join(__dirname, '..');

  console.log('\n== PASTAS PESADAS DO PROJETO ==');
  const pastas = ['node_modules', '.git', 'logs', path.join('src', 'database', 'backups')]
    .map(p => path.join(raiz, p));
  for (const p of pastas) {
    if (!fs.existsSync(p)) continue;
    console.log(`${path.relative(raiz, p).padEnd(28)} ${fmtTamanho(tamanhoPasta(p))}`);
  }

  console.log('\n== LOGS DO PM2 (home do usuário) ==');
  const pm2Logs = path.join(os.homedir(), '.pm2', 'logs');
  if (fs.existsSync(pm2Logs)) {
    const arquivos = fs.readdirSync(pm2Logs).map(nome => {
      const stat = fs.statSync(path.join(pm2Logs, nome));
      return { nome, tamanho: stat.size, modificado: stat.mtime };
    }).sort((a, b) => b.tamanho - a.tamanho);
    console.table(arquivos.map(a => ({ arquivo: a.nome, tamanho: fmtTamanho(a.tamanho), modificado: a.modificado.toISOString().slice(0, 10) })));
  } else {
    console.log('(pasta de logs do PM2 não encontrada nesse usuário)');
  }

  console.log('\n== ARQUIVOS SOLTOS NA RAIZ DO PROJETO (fora da estrutura normal) ==');
  const esperados = new Set(['.env', '.env.test', '.git', '.gitignore', 'node_modules', 'package.json',
    'package-lock.json', 'public', 'src', 'scripts', 'tests', 'TODO.md', 'README.md', 'logs',
    'RECUPERACAO-DE-DESASTRE.md', 'database', 'docs']);
  const soltos = fs.readdirSync(raiz).filter(nome => !esperados.has(nome));
  if (soltos.length) console.table(soltos.map(nome => ({ nome })));
  else console.log('Nenhum.');

  console.log('\n== TAMANHO DAS TABELAS NO BANCO (as 15 maiores) ==');
  const [tabelas] = await db.query(`
    SELECT table_name AS tabela, table_rows AS linhas,
           ROUND((data_length + index_length) / 1024 / 1024, 2) AS tamanho_mb
    FROM information_schema.tables
    WHERE table_schema = DATABASE()
    ORDER BY (data_length + index_length) DESC
    LIMIT 15
  `);
  console.table(tabelas);

  console.log('\n== COMANDAS/NOTAS MUITO ANTIGAS (candidatas a arquivar, não apagar) ==');
  const [[antigas]] = await db.query(`
    SELECT COUNT(*) AS qtd_comandas_mais_de_1_ano
    FROM comandas WHERE fechada_em < DATE_SUB(NOW(), INTERVAL 1 YEAR)
  `);
  console.table([antigas]);

  console.log('\nNada foi apagado — isso é só diagnóstico. Me manda o resultado que eu digo o que vale limpar.');
  await db.end();
})().catch(e => { console.error('Erro:', e.message); process.exit(1); });
