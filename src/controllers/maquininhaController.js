const fs = require('fs');
const { createWorker } = require('tesseract.js');
const db = require('../database/connection');

// Bandeiras que aparecem como sub-linhas dentro de CRÉDITO/DÉBITO nos relatórios
// de maquininha — não viram lançamento próprio, só detalhe informativo.
const BANDEIRAS_CONHECIDAS = ['elo', 'mastercard', 'visa', 'amex', 'hipercard', 'diners', 'discover', 'banescard', 'cabal'];

// Tipos de pagamento que viram lançamento no Financeiro
const TIPOS_PAGAMENTO = ['credito', 'debito', 'voucher', 'pix', 'dinheiro'];

function normalizarTipo(t) {
  return String(t || '').trim().toLowerCase()
    .normalize('NFD').replace(/[̀-ͯ]/g, ''); // remove acentos
}

function labelTipo(t) {
  const n = normalizarTipo(t);
  const labels = { credito: 'Crédito', debito: 'Débito', voucher: 'Voucher', pix: 'Pix', dinheiro: 'Dinheiro' };
  return labels[n] || t;
}

function parseRelatorioMaquininha(texto) {
  const linhas = texto.split('\n').map(l => l.trim()).filter(Boolean);
  const itensBrutos = [];
  // Linha típica: "CREDITO    0032    477,95" ou "Mastercard   0015   277,15"
  const regexLinha = /^([A-Za-zÀ-ÖØ-öø-ÿ][A-Za-zÀ-ÖØ-öø-ÿ\s]{1,20}?)\s+(\d{1,6})\s+([\d]{1,3}(?:\.\d{3})*,\d{2})$/;

  for (const linha of linhas) {
    const m = linha.match(regexLinha);
    if (m) {
      const tipoBruto = m[1].trim();
      const qtde = parseInt(m[2], 10);
      const total = parseFloat(m[3].replace(/\./g, '').replace(',', '.'));
      itensBrutos.push({ tipoBruto, qtde, total });
    }
  }

  // Extrai período de vendas, se existir no texto
  let periodo_inicio = null, periodo_fim = null;
  const periodoMatch = texto.match(
    /De\s+(\d{2}\/\d{2}\/\d{2,4})[^\d]+(\d{2}:\d{2})[\s\S]{0,20}?Ate\s+(\d{2}\/\d{2}\/\d{2,4})[^\d]+(\d{2}:\d{2})/i
  );
  if (periodoMatch) {
    periodo_inicio = periodoMatch[1];
    periodo_fim = periodoMatch[3];
  }

  // Separa: categorias de pagamento reais x sub-linhas de bandeira x agregados (TOTAIS/BANDEIRAS)
  const itens = [];
  for (const it of itensBrutos) {
    const n = normalizarTipo(it.tipoBruto);
    if (BANDEIRAS_CONHECIDAS.includes(n)) continue; // sub-detalhe de bandeira, ignora
    if (n === 'totais' || n === 'bandeiras') continue; // linha de agregação, não é um tipo de pagamento
    if (!TIPOS_PAGAMENTO.includes(n)) continue; // linha desconhecida, ignora com segurança
    if (it.total <= 0) continue; // tipo sem movimento no período
    itens.push({ tipo: labelTipo(it.tipoBruto), quantidade: it.qtde, total: it.total });
  }

  const totalGeral = itens.reduce((s, i) => s + i.total, 0);
  const itensComPct = itens.map(i => ({
    ...i,
    percentual: totalGeral > 0 ? parseFloat((i.total / totalGeral * 100).toFixed(1)) : 0,
  }));

  return { periodo_inicio, periodo_fim, itens: itensComPct, total_geral: parseFloat(totalGeral.toFixed(2)) };
}

// Pré-visualização: lê a foto, faz OCR, devolve os dados extraídos (sem salvar nada)
exports.preview = async (req, res) => {
  if (!req.file) return res.status(400).json({ erro: 'Envie uma foto do comprovante.' });
  const filePath = req.file.path;
  let worker;
  try {
    worker = await createWorker('por');
    const { data: { text } } = await worker.recognize(filePath);
    const resultado = parseRelatorioMaquininha(text);

    if (!resultado.itens.length) {
      return res.status(422).json({
        erro: 'Não consegui identificar os valores nesse comprovante. Tente uma foto mais nítida ou preencha manualmente.',
        texto_bruto: text,
      });
    }
    res.json(resultado);
  } catch (e) {
    console.error('Erro OCR maquininha:', e);
    res.status(500).json({ erro: 'Erro ao processar a imagem.' });
  } finally {
    if (worker) await worker.terminate().catch(() => {});
    fs.unlink(filePath, () => {});
  }
};

// Confirma os itens (já revisados/editados pelo usuário) e lança no Financeiro
exports.confirmar = async (req, res) => {
  const padaria_id = req.padaria.id;
  const { itens, data, periodo_label } = req.body;

  if (!Array.isArray(itens) || !itens.length)
    return res.status(400).json({ erro: 'Nenhum item para lançar.' });
  if (!data) return res.status(400).json({ erro: 'Data é obrigatória.' });

  let lancados = 0;
  for (const item of itens) {
    const valor = parseFloat(item.total);
    if (!item.tipo || isNaN(valor) || valor <= 0) continue;
    const descricao = `Fechamento maquininha${periodo_label ? ' — ' + periodo_label : ''} (${item.tipo})`;
    await db.query(
      `INSERT INTO financeiro (padaria_id, tipo, valor, descricao, categoria, forma_pagamento, data) VALUES (?,?,?,?,?,?,?)`,
      [padaria_id, 'entrada', valor, descricao, 'Vendas', item.tipo, data]
    );
    lancados++;
  }

  res.json({ ok: true, lancados });
};
