const fs = require('fs');
const { createWorker } = require('tesseract.js');
const db = require('../database/connection');

// Tipos de pagamento reconhecidos — comparação por "contém", pois o OCR às
// vezes junta palavras (ex: "PIX COMPRA", "VYoucher") ou erra letras.
const TIPOS_PAGAMENTO = [
  { chave: 'credito',  tipo: 'Crédito' },
  { chave: 'debito',   tipo: 'Débito' },
  { chave: 'voucher',  tipo: 'Voucher' },
  { chave: 'pix',      tipo: 'Pix' },
  { chave: 'dinheiro', tipo: 'Dinheiro' },
];

function normalizarTexto(t) {
  return String(t || '').trim().toLowerCase().normalize('NFD').replace(/[̀-ͯ]/g, '');
}

// Sub-linhas de bandeira/operadora que aparecem dentro de cada tipo de
// pagamento no comprovante (ex: Elo, Mastercard, Visa dentro de Crédito;
// Alelo, Ticket, VR dentro de Voucher). Comparação por "contém" tolera
// ruído do OCR (ex: "ev VR Beneficios").
const BANDEIRAS_CONHECIDAS = ['elo','mastercard','visa','amex','hipercard','diners','discover','banescard','cabal','alelo','ticket','pluxee','pluxe','vr benef','sodexo'];
function pareceBandeira(nomeNormalizado) {
  return BANDEIRAS_CONHECIDAS.some(b => nomeNormalizado.includes(b));
}

// Identifica se a linha corresponde a um tipo de pagamento conhecido.
// Retorna o rótulo bonito (Crédito/Débito/...) ou null se for bandeira,
// linha de agregação (TOTAIS/Bandeiras) ou lixo de OCR.
function classificarTipo(tipoBruto) {
  const n = normalizarTexto(tipoBruto);
  if (!n) return null;
  if (n.includes('totais') || n.includes('bandeiras')) return null;
  const match = TIPOS_PAGAMENTO.find(t => n.includes(t.chave));
  return match ? match.tipo : null;
}

// Converte um valor monetário lido por OCR, tolerando vírgula, ponto ou
// espaço como separador decimal (o OCR troca esses símbolos com frequência).
// Ex: "1.536,49" → 1536.49 | "909 62" → 909.62 | "814.41" → 814.41
function parseValorOCR(str) {
  const m = String(str || '').match(/(\d(?:[\d.,\s]*\d)?)[,.\s](\d{2})\s*$/);
  if (!m) return null;
  const inteiro = m[1].replace(/[.,\s]/g, '');
  const valor = parseFloat(`${inteiro}.${m[2]}`);
  return isNaN(valor) ? null : valor;
}

function parseRelatorioMaquininha(texto) {
  const linhas = texto.split('\n').map(l => l.trim()).filter(Boolean);
  // Linha típica: "DEBITO 0107 1.536,49" ou "PIX COMPRA 0047 909 62"
  // Tolera lixo de OCR no início da linha (traços, pipes, aspas — comum
  // quando a foto pega uma sombra/borda do papel na lateral do recibo).
  const regexLinha = /^[\s\-—_|=~"'´`.,;:]*([A-Za-zÀ-ÖØ-öø-ÿ][A-Za-zÀ-ÖØ-öø-ÿ\s]{1,25}?)\s+(\d{1,6})\s+([\d][\d.,\s]{0,12}\d)/;

  // Extrai período de vendas, se existir no texto
  let periodo_inicio = null, periodo_fim = null;
  const periodoMatch = texto.match(
    /De\s+(\d{2}\/\d{2}\/\d{2,4})[^\d]+(\d{2}:\d{2})[\s\S]{0,20}?Ate\s+(\d{2}\/\d{2}\/\d{2,4})[^\d]+(\d{2}:\d{2})/i
  );
  if (periodoMatch) {
    periodo_inicio = periodoMatch[1];
    periodo_fim = periodoMatch[3];
  }

  // O comprovante costuma repetir os totais (tabela detalhada + resumo final).
  // Fica com a primeira ocorrência de cada tipo — evita lançar duplicado.
  const vistos = new Set();
  const itens = [];
  let totalImpresso = null; // valor da linha "TOTAIS" do comprovante, para conferência
  let itemAtual = null; // item de pagamento sendo lido agora, para anexar as bandeiras dele
  for (const linha of linhas) {
    const m = linha.match(regexLinha);
    if (!m) continue;
    const nomeNormalizado = normalizarTexto(m[1]);

    if (totalImpresso === null && nomeNormalizado.includes('totais')) {
      totalImpresso = parseValorOCR(m[3]);
      itemAtual = null; // depois do TOTAIS vem o resumo repetido — não anexar mais bandeiras
      continue;
    }

    const tipo = classificarTipo(m[1]);
    if (tipo) {
      itemAtual = null;
      if (vistos.has(tipo)) continue;
      const total = parseValorOCR(m[3]);
      if (total === null || total <= 0) continue;
      vistos.add(tipo);
      itemAtual = { tipo, quantidade: parseInt(m[2], 10), total, bandeiras: [] };
      itens.push(itemAtual);
      continue;
    }

    // Não é um tipo de pagamento nem TOTAIS — pode ser uma bandeira/operadora
    // dentro do tipo que estamos lendo agora (ex: Elo, Mastercard, Visa).
    if (itemAtual && pareceBandeira(nomeNormalizado)) {
      const totalBandeira = parseValorOCR(m[3]);
      if (totalBandeira !== null && totalBandeira > 0) {
        itemAtual.bandeiras.push({ nome: m[1].trim(), total: totalBandeira });
      }
    }
  }

  const totalGeral = itens.reduce((s, i) => s + i.total, 0);
  const itensComPct = itens.map(i => ({
    ...i,
    percentual: totalGeral > 0 ? parseFloat((i.total / totalGeral * 100).toFixed(1)) : 0,
  }));

  // Confere a soma dos itens lidos com o total impresso no comprovante —
  // se não bater, o OCR provavelmente errou algum dígito.
  const bateComTotalImpresso = totalImpresso === null
    ? null
    : Math.abs(totalGeral - totalImpresso) < 0.02;

  return {
    periodo_inicio, periodo_fim,
    itens: itensComPct,
    total_geral: parseFloat(totalGeral.toFixed(2)),
    total_impresso: totalImpresso,
    bate_com_total_impresso: bateComTotalImpresso,
  };
}

// Casa cada tipo/bandeira com uma "Modalidade de Pagamento" cadastrada em
// Configurações de Precificação (mesmo nome, sem diferenciar maiúsculas/
// acentos) e anexa a taxa configurada + o valor da taxa naquele período.
async function anexarTaxasConfiguradas(padaria_id, itens) {
  const [modalidades] = await db.query(
    'SELECT nome, taxa_pct FROM modalidades_pagamento WHERE padaria_id = ?', [padaria_id]
  );
  if (!modalidades.length) return itens;
  const mapa = new Map(modalidades.map(m => [normalizarTexto(m.nome), parseFloat(m.taxa_pct) || 0]));

  const comTaxa = (nome, total) => {
    const taxa_pct = mapa.get(normalizarTexto(nome));
    if (taxa_pct === undefined) return {};
    return { taxa_pct, taxa_valor: parseFloat((total * taxa_pct / 100).toFixed(2)) };
  };

  return itens.map(item => ({
    ...item,
    ...comTaxa(item.tipo, item.total),
    bandeiras: (item.bandeiras || []).map(b => ({ ...b, ...comTaxa(b.nome, b.total) })),
  }));
}

// Pré-visualização: lê a foto, faz OCR, devolve os dados extraídos (sem salvar nada)
exports.preview = async (req, res) => {
  if (!req.file) return res.status(400).json({ erro: 'Envie uma foto do comprovante.' });
  const filePath = req.file.path;
  let worker;
  try {
    worker = await createWorker('por');
    const { data: { text } } = await worker.recognize(filePath);
    console.log('--- OCR maquininha: texto bruto ---\n' + text + '\n--- fim texto bruto ---');
    const resultado = parseRelatorioMaquininha(text);
    console.log('--- OCR maquininha: itens reconhecidos ---', JSON.stringify(resultado.itens));

    if (!resultado.itens.length) {
      return res.status(422).json({
        erro: 'Não consegui identificar os valores nesse comprovante. Tente uma foto mais nítida ou preencha manualmente.',
        texto_bruto: text,
      });
    }
    resultado.itens = await anexarTaxasConfiguradas(req.padaria.id, resultado.itens);
    res.json(resultado);
  } catch (e) {
    console.error('Erro OCR maquininha:', e);
    res.status(500).json({ erro: 'Erro ao processar a imagem.' });
  } finally {
    if (worker) await worker.terminate().catch(() => {});
    fs.unlink(filePath, () => {});
  }
};

exports._parseRelatorioMaquininha = parseRelatorioMaquininha; // exposto para testes

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
    const bandeirasTexto = Array.isArray(item.bandeiras) && item.bandeiras.length
      ? ' [' + item.bandeiras.map(b => {
          const taxa = b.taxa_pct != null ? ` taxa ${b.taxa_pct}%=R$${b.taxa_valor.toFixed(2)}` : '';
          return `${b.nome} R$${parseFloat(b.total).toFixed(2)}${taxa}`;
        }).join(', ') + ']'
      : '';
    const taxaTipoTexto = item.taxa_pct != null ? ` (taxa ${item.taxa_pct}% = R$${item.taxa_valor.toFixed(2)})` : '';
    const descricao = `Fechamento maquininha${periodo_label ? ' — ' + periodo_label : ''} (${item.tipo})${taxaTipoTexto}${bandeirasTexto}`;
    await db.query(
      `INSERT INTO financeiro (padaria_id, tipo, valor, descricao, categoria, forma_pagamento, data) VALUES (?,?,?,?,?,?,?)`,
      [padaria_id, 'entrada', valor, descricao, 'Vendas', item.tipo, data]
    );
    lancados++;
  }

  res.json({ ok: true, lancados });
};
