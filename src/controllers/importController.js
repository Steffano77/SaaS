const ExcelJS = require('exceljs');
const db      = require('../database/connection');
const fs      = require('fs');

// Retorna as colunas do arquivo para o frontend montar o mapeamento
exports.preview = async (req, res) => {
  if (!req.file) return res.status(400).json({ erro: 'Arquivo não enviado.' });
  const filePath = req.file.path;

  try {
    const headers = await extrairCabecalhos(filePath, req.file.originalname);
    res.json({ colunas: headers });
  } catch (e) {
    console.error('Erro preview importação:', e);
    res.status(400).json({ erro: 'Não foi possível ler o arquivo. Verifique se é um .xlsx ou .csv válido.' });
  } finally {
    fs.unlink(filePath, () => {});
  }
};

// Importa com base no mapeamento enviado pelo frontend
exports.importarGenerico = async (req, res) => {
  if (!req.file) return res.status(400).json({ erro: 'Arquivo não enviado.' });

  let mapeamento;
  try {
    mapeamento = JSON.parse(req.body.mapeamento || '{}');
  } catch {
    return res.status(400).json({ erro: 'Mapeamento inválido.' });
  }

  if (!mapeamento.nome) return res.status(400).json({ erro: 'O campo "Nome do produto" é obrigatório no mapeamento.' });

  const padaria_id = req.padaria.id;
  const filePath   = req.file.path;

  try {
    const { headers, rows } = await lerArquivo(filePath, req.file.originalname);

    // Converte nomes de colunas para índices (1-based para ExcelJS, 0-based para CSV)
    const idx = {};
    for (const [campo, colNome] of Object.entries(mapeamento)) {
      if (colNome) idx[campo] = headers.indexOf(colNome);
    }

    let atualizados = 0, criados = 0, ignorados = 0;

    for (const row of rows) {
      const get = (campo) => {
        const i = idx[campo];
        if (i === undefined || i === -1) return '';
        return String(row[i] ?? '').trim();
      };

      const nome = get('nome');
      if (!nome) { ignorados++; continue; }

      const cod   = get('codigo_barras') || null;
      const saldo = parseFloat(get('estoque_atual'))  || 0;
      const custo = parseFloat(get('custo_unitario')) || 0;
      const venda = parseFloat(get('preco_venda'))    || 0;
      const unid  = get('unidade') || 'UNIDADE';
      const cat   = get('categoria') || '';
      const emin  = parseFloat(get('estoque_minimo')) || 0;

      // Resolve categoria
      let categoria_id = null;
      if (cat) {
        const [catRows] = await db.query(
          'SELECT id FROM categorias WHERE padaria_id = ? AND nome = ?', [padaria_id, cat]
        );
        if (catRows.length) {
          categoria_id = catRows[0].id;
        } else {
          const [r] = await db.query('INSERT INTO categorias (padaria_id, nome) VALUES (?,?)', [padaria_id, cat]);
          categoria_id = r.insertId;
        }
      }

      // Tenta localizar produto por código de barras ou nome
      let existe = null;
      if (cod) {
        const [rows2] = await db.query(
          'SELECT id, estoque_atual FROM produtos WHERE padaria_id = ? AND codigo_barras = ?',
          [padaria_id, cod]
        );
        if (rows2.length) existe = rows2[0];
      }
      if (!existe) {
        const [rows3] = await db.query(
          'SELECT id, estoque_atual FROM produtos WHERE padaria_id = ? AND nome = ? AND ativo = 1',
          [padaria_id, nome]
        );
        if (rows3.length) existe = rows3[0];
      }

      if (existe) {
        const anterior = parseFloat(existe.estoque_atual);
        const diff     = anterior - saldo;

        await db.query(
          `UPDATE produtos SET
             nome = ?, unidade = ?,
             estoque_atual = ?,
             custo_unitario = IF(? > 0, ?, custo_unitario),
             preco_venda    = IF(? > 0, ?, preco_venda),
             categoria_id   = COALESCE(?, categoria_id),
             estoque_minimo = IF(? > 0, ?, estoque_minimo)
           WHERE id = ? AND padaria_id = ?`,
          [nome, unid, saldo,
           custo, custo,
           venda, venda,
           categoria_id,
           emin, emin,
           existe.id, padaria_id]
        );

        if (diff !== 0) {
          await db.query(
            `INSERT INTO movimentacoes (padaria_id, produto_id, tipo, quantidade, custo_unit, observacao)
             VALUES (?,?,?,?,?,?)`,
            [padaria_id, existe.id, 'sync_saurus', Math.abs(diff), custo,
             `Importação genérica — ${new Date().toLocaleString('pt-BR')}`]
          );
        }
        atualizados++;
      } else {
        const [r] = await db.query(
          `INSERT INTO produtos (padaria_id, categoria_id, codigo_barras, nome, unidade,
           custo_unitario, preco_venda, estoque_atual, estoque_minimo)
           VALUES (?,?,?,?,?,?,?,?,?)`,
          [padaria_id, categoria_id, cod || null, nome, unid, custo, venda, saldo, emin]
        );
        if (saldo > 0) {
          await db.query(
            `INSERT INTO movimentacoes (padaria_id, produto_id, tipo, quantidade, custo_unit, observacao)
             VALUES (?,?,?,?,?,?)`,
            [padaria_id, r.insertId, 'entrada', saldo, custo, 'Importação genérica — inicial']
          );
        }
        criados++;
      }
    }

    res.json({ ok: true, atualizados, criados, ignorados });
  } catch (e) {
    console.error('Erro importação genérica:', e);
    res.status(500).json({ erro: 'Erro ao processar arquivo.' });
  } finally {
    fs.unlink(filePath, () => {});
  }
};

// ── helpers ──────────────────────────────────────────────────────

async function extrairCabecalhos(filePath, originalName) {
  if (isCsv(originalName)) {
    const content = fs.readFileSync(filePath, 'utf-8');
    const linhas = content.split(/\r?\n/);
    const sep = detectarSeparador(linhas[0]);
    return parseCsvLinha(linhas[0], sep);
  }
  const wb = new ExcelJS.Workbook();
  await wb.xlsx.readFile(filePath);
  const ws = wb.worksheets[0];
  const headers = [];
  ws.getRow(1).eachCell((cell) => { headers.push(String(cell.value ?? '').trim()); });
  return headers;
}

async function lerArquivo(filePath, originalName) {
  if (isCsv(originalName)) {
    const content = fs.readFileSync(filePath, 'utf-8');
    const linhas  = content.split(/\r?\n/).filter(l => l.trim());
    const sep     = detectarSeparador(linhas[0]);
    const headers = parseCsvLinha(linhas[0], sep);
    const rows    = linhas.slice(1).map(l => parseCsvLinha(l, sep));
    return { headers, rows };
  }
  const wb = new ExcelJS.Workbook();
  await wb.xlsx.readFile(filePath);
  const ws = wb.worksheets[0];
  const headers = [];
  ws.getRow(1).eachCell((cell) => { headers.push(String(cell.value ?? '').trim()); });
  const rows = [];
  ws.eachRow((row, i) => {
    if (i === 1) return;
    const r = [];
    for (let c = 1; c <= headers.length; c++) r.push(row.getCell(c).value ?? '');
    rows.push(r);
  });
  return { headers, rows };
}

function isCsv(nome) {
  return /\.(csv|txt)$/i.test(nome);
}

function detectarSeparador(linha) {
  const contagens = { ',': 0, ';': 0, '\t': 0 };
  for (const c of linha) if (contagens[c] !== undefined) contagens[c]++;
  return Object.entries(contagens).sort((a, b) => b[1] - a[1])[0][0];
}

function parseCsvLinha(linha, sep) {
  const result = [];
  let cur = '', inQuote = false;
  for (let i = 0; i < linha.length; i++) {
    const c = linha[i];
    if (c === '"') {
      if (inQuote && linha[i + 1] === '"') { cur += '"'; i++; }
      else inQuote = !inQuote;
    } else if (c === sep && !inQuote) {
      result.push(cur.trim());
      cur = '';
    } else {
      cur += c;
    }
  }
  result.push(cur.trim());
  return result;
}
