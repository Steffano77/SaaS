// Gera um .sql pra copiar o cadastro de produtos desta loja pra OUTRA loja (outro
// servidor local), acrescentando só o que a outra loja ainda não tem.
//
// Uso (na pasta do sistema, no PC da loja de ONDE os produtos vão sair):
//   node scripts/exportar-produtos-para-loja.js <email-da-conta-aqui> <padaria_id-no-destino>
// Gera: produtos_para_padaria_<id>.sql na pasta atual.
//
// No destino, cada produto só entra se ainda não existir lá um com o mesmo código de
// barras (ou, pra produto sem código, com o mesmo nome) — o que a outra loja já tem
// continua com o preço e o estoque dela. Estoque entra zerado (é de outra loja) e sem
// categoria/fornecedor (os ids de lá são outros). Vai junto o que a nota fiscal precisa:
// NCM, situação ICMS (ST), origem e CEST.

const path = require('path');
const fs = require('fs');
require('dotenv').config({ path: path.join(__dirname, '..', '.env') });
const mysql = require('mysql2/promise');
const { escape } = require('mysql2');

async function main() {
  const [email, destinoArg] = process.argv.slice(2);
  const destinoId = parseInt(destinoArg, 10);
  if (!email || !destinoId) {
    console.error('Uso: node scripts/exportar-produtos-para-loja.js <email-da-conta-aqui> <padaria_id-no-destino>');
    process.exit(1);
  }

  const db = await mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    port: process.env.DB_PORT || 3306,
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASS || '',
    database: process.env.DB_NAME || 'panificapro',
  });

  const [[padaria]] = await db.query('SELECT id, nome FROM padarias WHERE email = ?', [email]);
  if (!padaria) { console.error(`Nenhuma padaria com o email ${email}.`); process.exit(1); }

  const [colunas] = await db.query(
    "SELECT COLUMN_NAME AS c FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'produtos'"
  );
  const existe = new Set(colunas.map(x => x.c));
  const campos = ['nome', 'codigo_barras', 'codigo_balanca', 'unidade', 'custo_unitario', 'preco_venda',
    'estoque_minimo', 'ncm', 'situacao_icms', 'origem_producao', 'cest', 'controla_estoque',
    'venda_rapida', 'validade_dias', 'embalagem_preco', 'embalagem_qtd'].filter(c => existe.has(c));

  const [produtos] = await db.query(
    `SELECT ${campos.join(', ')} FROM produtos WHERE padaria_id = ? AND ativo = 1 ORDER BY nome`, [padaria.id]
  );

  const saida = path.join(process.cwd(), `produtos_para_padaria_${destinoId}.sql`);
  const linhas = [
    `-- Produtos de "${padaria.nome}" pra padaria_id ${destinoId}: só entra o que o destino ainda não tem.`,
    'SET NAMES utf8mb4;',
  ];
  for (const p of produtos) {
    const cod = String(p.codigo_barras || '').trim();
    const jaExiste = cod
      ? `codigo_barras = ${escape(cod)}`
      : `(codigo_barras IS NULL OR codigo_barras = '') AND nome = ${escape(p.nome)}`;
    const valores = campos.map(c => escape(c === 'codigo_barras' ? (cod || null) : p[c]));
    linhas.push(
      `INSERT INTO produtos (padaria_id, ${campos.join(', ')}, estoque_atual, ativo)\n` +
      `SELECT ${destinoId}, ${valores.join(', ')}, 0, 1\n` +
      `WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = ${destinoId} AND ${jaExiste});`
    );
  }
  linhas.push(`SELECT COUNT(*) AS produtos_no_destino FROM produtos WHERE padaria_id = ${destinoId};`);
  fs.writeFileSync(saida, linhas.join('\n') + '\n', 'utf8');

  console.log(`${padaria.nome}: ${produtos.length} produtos ativos exportados.`);
  console.log(`Arquivo gerado: ${saida}`);
  await db.end();
}

main().catch(e => { console.error('Erro:', e.message); process.exit(1); });
