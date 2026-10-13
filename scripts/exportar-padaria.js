// Exporta TODOS os dados de UMA padaria (produtos, compras, fornecedores, movimentações,
// fichas, financeiro...) do banco onde roda — usado pra levar a conta da nuvem pro
// servidor local de uma loja, sem levar nada de outros clientes.
//
// Uso (na pasta do sistema, no servidor de onde os dados vão sair):
//   node scripts/exportar-padaria.js <email-da-conta> <padaria_id-no-destino>
// Gera: exportacao_padaria_<id>.sql na pasta atual.
//
// Como acha os dados da padaria:
//   - tabela com coluna padaria_id  -> filtra por padaria_id
//   - tabela sem padaria_id         -> segue a chave estrangeira até uma tabela que tem
//                                      (ex: itens_pedido.pedido_id -> pedidos_compra)
//   - tabela que não deu pra ligar  -> NÃO exporta e lista no final, pra decidir na mão
// O padaria_id é trocado pelo id da padaria no destino. Os outros ids são mantidos, pra
// compras/itens/movimentações continuarem ligados entre si.

const path = require('path');
const fs = require('fs');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });
const mysql = require('mysql2/promise');
const { escape } = require('mysql2');

const IGNORAR = new Set([
  'padarias',                  // a conta no destino já existe (com a config fiscal dela)
  'codigos_ativacao',          // do painel admin, não da padaria
  'sync_resumo_local',         // resumo que os servidores locais mandam pra nuvem
  'nfce_emissao_em_andamento', // trava temporária de emissão
]);

async function main() {
  const [email, destinoArg] = process.argv.slice(2);
  const destinoId = parseInt(destinoArg, 10);
  if (!email || !destinoId) {
    console.error('Uso: node scripts/exportar-padaria.js <email-da-conta> <padaria_id-no-destino>');
    process.exit(1);
  }

  const db = await mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || '',
    database: process.env.DB_NAME || 'panificapro',
    dateStrings: true, // datas saem exatamente como estão gravadas, sem conversão de fuso
  });

  const [[padaria]] = await db.query('SELECT id, nome FROM padarias WHERE email = ?', [email]);
  if (!padaria) { console.error(`Nenhuma padaria com o email ${email}.`); process.exit(1); }
  const origemId = padaria.id;
  console.log(`Padaria encontrada: ${padaria.nome} (id ${origemId}) -> vai virar id ${destinoId} no destino.`);

  const [tabelas] = await db.query(
    "SELECT TABLE_NAME AS t FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_TYPE = 'BASE TABLE'"
  );
  const [colunas] = await db.query(
    'SELECT TABLE_NAME AS t, COLUMN_NAME AS c, EXTRA AS extra FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() ORDER BY ORDINAL_POSITION'
  );
  const [fks] = await db.query(
    `SELECT TABLE_NAME AS t, COLUMN_NAME AS c, REFERENCED_TABLE_NAME AS rt, REFERENCED_COLUMN_NAME AS rc
     FROM information_schema.KEY_COLUMN_USAGE
     WHERE TABLE_SCHEMA = DATABASE() AND REFERENCED_TABLE_NAME IS NOT NULL`
  );

  const colsDe = {};
  const geradas = new Set(); // colunas calculadas pelo banco (ex: itens_pedido.total) não aceitam valor no INSERT
  for (const { t, c, extra } of colunas) {
    (colsDe[t] = colsDe[t] || []).push(c);
    if (/GENERATED/i.test(extra || '')) geradas.add(`${t}.${c}`);
  }

  // filtro[t] = trecho WHERE que seleciona as linhas dessa padaria na tabela t
  const filtro = {};
  for (const { t } of tabelas) {
    if (!IGNORAR.has(t) && colsDe[t].includes('padaria_id')) filtro[t] = `padaria_id = ${origemId}`;
  }
  // Tabelas filhas: liga pela chave estrangeira até uma tabela já resolvida (vários níveis).
  let mudou = true;
  while (mudou) {
    mudou = false;
    for (const { t } of tabelas) {
      if (filtro[t] || IGNORAR.has(t)) continue;
      const fk = fks.find(f => f.t === t && filtro[f.rt] && f.rt !== t);
      if (fk) {
        filtro[t] = `\`${fk.c}\` IN (SELECT \`${fk.rc}\` FROM \`${fk.rt}\` WHERE ${filtro[fk.rt]})`;
        mudou = true;
      }
    }
  }

  const saida = path.join(process.cwd(), `exportacao_padaria_${destinoId}.sql`);
  const out = fs.createWriteStream(saida, { encoding: 'utf8' });
  out.write(`-- Exportação da padaria "${padaria.nome}" (origem id ${origemId}) para padaria_id ${destinoId}\n`);
  out.write('SET NAMES utf8mb4;\nSET FOREIGN_KEY_CHECKS = 0;\n');

  // Configurações da conta que não são login nem fiscal (o fiscal do destino é próprio,
  // e a senha do certificado/CSC é criptografada com a chave de cada servidor).
  const configConta = ['pin_financeiro', 'email_relatorio', 'email_contabilidade']
    .filter(c => colsDe.padarias.includes(c));
  if (configConta.length) {
    const [[cfg]] = await db.query(`SELECT ${configConta.join(', ')} FROM padarias WHERE id = ?`, [origemId]);
    const sets = configConta.map(c => `${c} = ${escape(cfg[c])}`).join(', ');
    out.write(`UPDATE padarias SET ${sets} WHERE id = ${destinoId};\n`);
  }

  const resumo = [];
  for (const { t } of tabelas) {
    if (!filtro[t]) continue;
    const [linhas] = await db.query(`SELECT * FROM \`${t}\` WHERE ${filtro[t]}`);
    resumo.push([t, linhas.length]);
    if (!linhas.length) continue;
    const cols = Object.keys(linhas[0]).filter(c => !geradas.has(`${t}.${c}`));
    const listaCols = cols.map(c => `\`${c}\``).join(', ');
    for (let i = 0; i < linhas.length; i += 200) {
      const lote = linhas.slice(i, i + 200).map(l => '(' + cols.map(c => {
        let v = l[c];
        if (c === 'padaria_id') v = destinoId;
        else if (v !== null && typeof v === 'object' && !Buffer.isBuffer(v)) v = JSON.stringify(v);
        return escape(v);
      }).join(', ') + ')');
      // REPLACE: o banco de destino está vazio pra essa padaria; se a migração do boot
      // criou alguma linha padrão com o mesmo id, a da nuvem prevalece.
      out.write(`REPLACE INTO \`${t}\` (${listaCols}) VALUES\n${lote.join(',\n')};\n`);
    }
  }
  out.write('SET FOREIGN_KEY_CHECKS = 1;\n');
  await new Promise(r => out.end(r));

  console.log('\nExportado (tabela: linhas):');
  for (const [t, n] of resumo) console.log(`  ${t}: ${n}`);
  const naoLigadas = tabelas.map(x => x.t).filter(t => !filtro[t] && !IGNORAR.has(t));
  if (naoLigadas.length) {
    console.log('\nNÃO exportadas (sem padaria_id nem chave estrangeira pra uma tabela da padaria):');
    for (const t of naoLigadas) console.log(`  ${t}: colunas ${colsDe[t].join(', ')}`);
  }
  console.log(`\nArquivo gerado: ${saida}`);
  await db.end();
}

main().catch(e => { console.error('Erro:', e.message); process.exit(1); });
