// Importa a validade (em dias) dos produtos já cadastrados, usando um arquivo real
// exportado da balança (formato: código(6) + tipo(1) + descrição(22) + preço(7) + validade(3)).
// Casa pelo código de balança (codigo_balanca), só dentro da padaria informada.
// Uso: node scripts/importar_validade_balanca.js caminho/do/arquivo.txt PADARIA_ID

require('dotenv').config();
const fs = require('fs');
const db = require('../src/database/connection');

const caminhoArquivo = process.argv[2];
const padariaId = parseInt(process.argv[3], 10);

if (!caminhoArquivo || !padariaId) {
  console.error('Uso: node scripts/importar_validade_balanca.js caminho/do/arquivo.txt PADARIA_ID');
  process.exit(1);
}

(async () => {
  const conteudo = fs.readFileSync(caminhoArquivo, 'latin1');
  const linhas = conteudo.split(/\r?\n/).filter(l => l.trim().length > 0);

  let atualizados = 0;
  let semProdutoCorrespondente = 0;
  let semValidade = 0;

  for (const linha of linhas) {
    if (linha.length < 33) continue; // linha curta demais, ignora
    const codigo = linha.slice(0, 6).replace(/^0+/, '') || '0'; // tira zeros à esquerda pra comparar
    const validadeDias = parseInt(linha.slice(-3), 10) || 0;
    if (validadeDias === 0) { semValidade++; continue; } // não sobrescreve com 0 — só atualiza quem tem validade de verdade no arquivo

    const [result] = await db.query(
      `UPDATE produtos SET validade_dias = ?
       WHERE padaria_id = ? AND codigo_balanca IS NOT NULL
         AND CAST(codigo_balanca AS UNSIGNED) = ?`,
      [validadeDias, padariaId, parseInt(codigo, 10) * 100]
    );
    if (result.affectedRows > 0) atualizados += result.affectedRows;
    else semProdutoCorrespondente++;
  }

  console.log(`Produtos atualizados com validade: ${atualizados}`);
  console.log(`Linhas do arquivo sem produto correspondente no cadastro: ${semProdutoCorrespondente}`);
  console.log(`Linhas do arquivo com validade "000" (puladas, não sobrescreve): ${semValidade}`);
  process.exit(0);
})().catch(e => { console.error(e); process.exit(1); });
