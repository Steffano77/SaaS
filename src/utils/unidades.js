// Conversão de unidades de medida entre o que foi digitado na ficha técnica
// e a unidade em que o produto está cadastrado no estoque. Suporta apenas as
// famílias massa (kg/g) e volume (L/ml) — fora dessas famílias, a conversão
// exige unidade igual (mesmo comportamento de antes, para não quebrar dados
// legados com nomes de unidade inconsistentes, ex: "UNIDADE", "KG", "un").
function normalizar(u) {
  const s = String(u || '').trim().toLowerCase();
  if (['kg', 'quilo', 'quilos', 'kilo', 'kilograma', 'kilograma(s)'].includes(s)) return 'kg';
  if (['g', 'grama', 'gramas'].includes(s)) return 'g';
  if (['l', 'litro', 'litros'].includes(s)) return 'l';
  if (['ml', 'mililitro', 'mililitros'].includes(s)) return 'ml';
  return s;
}

const FATORES = {
  'g->kg': 0.001, 'kg->g': 1000,
  'ml->l': 0.001, 'l->ml': 1000,
};

// Converte `qtd` da unidade `de` para a unidade `para`. Se a conversão não for
// reconhecida, devolve `qtd` sem alterar.
function converterQtd(qtd, de, para) {
  const nDe = normalizar(de);
  const nPara = normalizar(para);
  if (nDe === nPara) return qtd;
  const fator = FATORES[`${nDe}->${nPara}`];
  return fator !== undefined ? qtd * fator : qtd;
}

// Dado o código de unidade do produto (o que está salvo em produtos.unidade),
// devolve as unidades de entrada compatíveis para uso na ficha técnica —
// a própria unidade do produto, mais a unidade "fina" da mesma família
// (ex: produto em kg → pode digitar em kg ou g).
function unidadesCompativeis(unidadeProduto) {
  const n = normalizar(unidadeProduto);
  if (n === 'kg') return [{ valor: unidadeProduto, label: unidadeProduto }, { valor: 'g', label: 'g' }];
  if (n === 'g')  return [{ valor: unidadeProduto, label: unidadeProduto }, { valor: 'kg', label: 'kg' }];
  if (n === 'l')  return [{ valor: unidadeProduto, label: unidadeProduto }, { valor: 'ml', label: 'ml' }];
  if (n === 'ml') return [{ valor: unidadeProduto, label: unidadeProduto }, { valor: 'l', label: 'L' }];
  return [{ valor: unidadeProduto, label: unidadeProduto }];
}

module.exports = { normalizar, converterQtd, unidadesCompativeis };
