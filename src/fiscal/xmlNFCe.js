// Monta o XML da NFC-e (modelo 65, layout 4.00) a partir dos dados da comanda +
// dados fiscais da padaria. Fase inicial: cobre o caso comum (Simples Nacional,
// CSOSN 102, venda dentro do estado, consumidor final não identificado).
//
// Simplificações assumidas nessa primeira versão (documentadas pra revisar com o
// contador antes de ir pra produção de verdade):
//  - CFOP fixo 5102 (venda de mercadoria de terceiros, dentro do estado)
//  - NCM genérico 21069090 quando o produto não tem um cadastrado
//  - CSOSN 102 (Simples Nacional, sem permissão de crédito) pra todos os itens
const { gerarChaveAcesso, gerarCodigoNumerico } = require('./chaveAcesso');

const FORMA_PAGAMENTO_TPAG = {
  'Dinheiro': '01',
  'Crédito': '03',
  'Débito': '04',
  'Pix': '17',
  'Voucher': '99',
};

function escaparXml(texto) {
  // A Sefaz só aceita um conjunto restrito de caracteres em campos de texto (letras,
  // números, acentos comuns) — troca travessão, aspas curvas, emoji etc. por algo simples
  // pra não travar a nota por causa de um caractere "estranho" digitado sem querer.
  const limpo = String(texto ?? '')
    .replace(/[‒-―]/g, '-')   // travessões variados -> hífen simples
    .replace(/[‘’]/g, "'")    // aspas curvas simples
    .replace(/[“”]/g, '"')    // aspas curvas duplas
    .replace(/[^\x20-\x7EÀ-ÿ]/g, '');   // remove qualquer coisa fora do intervalo aceito
  return limpo
    .replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;').replace(/'/g, '&apos;');
}

function num2(valor) { return parseFloat(valor || 0).toFixed(2); }
function num4(valor) { return parseFloat(valor || 0).toFixed(4); }

// CFOP e CSOSN certos dependem de duas coisas do produto (não do NCM): se é fabricado
// na própria padaria ou comprado pronto pra revender, e se tem Substituição Tributária
// (ICMS já recolhido antes, tipo bebida/cerveja/água) — orientação do contador.
function definirCfop(item) {
  if (item.origem_producao === 'propria') return '5101'; // venda de produção do estabelecimento
  if (item.situacao_icms === 'st') return '5405'; // revenda de mercadoria com ST (substituído)
  return '5102'; // revenda normal
}
function montarBlocoIcms(item) {
  if (item.situacao_icms === 'st') return '<ICMSSN500><orig>0</orig><CSOSN>500</CSOSN></ICMSSN500>';
  // Não existe um grupo "ICMSSN400" separado no schema oficial — CSOSN 400 (não
  // tributada) usa o MESMO grupo ICMSSN102, só troca o número do CSOSN por dentro.
  if (item.situacao_icms === 'isento') return '<ICMSSN102><orig>0</orig><CSOSN>400</CSOSN></ICMSSN102>';
  return '<ICMSSN102><orig>0</orig><CSOSN>102</CSOSN></ICMSSN102>'; // normal, sem permissão de crédito
}

// padaria: linha da tabela padarias (com os campos nfce_*) · comanda: { itens, total, ... }
// pagamentos: [{forma_pagamento, valor}] · numero: nNF sequencial · ambiente: 1 ou 2
function montarXmlNFCe({ padaria, comanda, itens, pagamentos, numero, ambiente }) {
  const agora = new Date();
  const cUF = 35; // São Paulo
  const cnpjLimpo = String(padaria.cnpj || '').replace(/\D/g, '');
  const cNF = gerarCodigoNumerico();
  const serie = padaria.nfce_serie || 1;

  const chave = gerarChaveAcesso({
    cUF, dhEmi: agora, cnpj: cnpjLimpo, mod: 65, serie, numero, tpEmi: 1, cNF,
  });

  // Bug corrigido: toISOString() já devolve o horário em UTC — só grudar "-03:00" no
  // final SEM converter a hora deixava a data 3h no futuro (a Sefaz rejeitou por isso:
  // "Data-Hora de Emissão posterior ao horário de recebimento"). Precisa converter de
  // verdade pro horário de Brasília antes de formatar.
  const partesHorario = new Intl.DateTimeFormat('en-CA', {
    timeZone: 'America/Sao_Paulo', hour12: false,
    year: 'numeric', month: '2-digit', day: '2-digit',
    hour: '2-digit', minute: '2-digit', second: '2-digit',
  }).formatToParts(agora).reduce((acc, p) => { acc[p.type] = p.value; return acc; }, {});
  const dhEmiIso = `${partesHorario.year}-${partesHorario.month}-${partesHorario.day}T${partesHorario.hour}:${partesHorario.minute}:${partesHorario.second}-03:00`;

  // Importante: o total de IBS/CBS no <total> precisa bater EXATAMENTE com a soma
  // dos valores por item — se cada item arredonda pra 2 casas separado e o total é
  // recalculado direto em cima do valor cheio da nota, pode sobrar 1 centavo de
  // diferença (a Sefaz rejeita: "Total de CBS difere da soma dos itens"). Por isso
  // calcula o vIBS/vCBS de cada item primeiro, junta num array, e o total da nota
  // é a SOMA desses valores já arredondados — nunca um cálculo novo em cima do total.
  let somaVIBS = 0;
  let somaVCBS = 0;
  let somaVDesc = 0;
  let somaVOutro = 0;

  // Desconto da comanda é um valor único (dado no fechamento), mas a Sefaz exige que o
  // <vDesc> total bata com a SOMA do <vDesc> de cada item (rejeição 537) — distribui
  // proporcionalmente ao peso de cada item no total, e joga a sobra de arredondamento
  // no último item, pro mesmo motivo do comentário acima (vIBS/vCBS): nunca recalcular
  // o total, sempre somar os valores já arredondados de item.
  const vProdTotalBruto = itens.reduce((s, i) => s + parseFloat(i.subtotal), 0);
  const vDescontoBruto = parseFloat(comanda.desconto || 0);
  const descontosPorItem = itens.map((item, idx) => {
    if (vDescontoBruto <= 0 || vProdTotalBruto <= 0) return 0;
    if (idx === itens.length - 1) {
      // último item leva o resto, garantindo soma exata
      const somaAnteriores = itens.slice(0, -1).reduce((s, i, j) =>
        s + parseFloat(num2(vDescontoBruto * (parseFloat(i.subtotal) / vProdTotalBruto))), 0);
      return Math.max(0, parseFloat(num2(vDescontoBruto - somaAnteriores)));
    }
    return parseFloat(num2(vDescontoBruto * (parseFloat(item.subtotal) / vProdTotalBruto)));
  });

  // Mesma lógica pro acréscimo (rejeição 604: "Total do vOutro difere do somatório dos
  // itens") — distribui proporcionalmente e joga a sobra no último item.
  const vAcrescimoBruto = parseFloat(comanda.acrescimo || 0);
  const acrescimosPorItem = itens.map((item, idx) => {
    if (vAcrescimoBruto <= 0 || vProdTotalBruto <= 0) return 0;
    if (idx === itens.length - 1) {
      const somaAnteriores = itens.slice(0, -1).reduce((s, i) =>
        s + parseFloat(num2(vAcrescimoBruto * (parseFloat(i.subtotal) / vProdTotalBruto))), 0);
      return Math.max(0, parseFloat(num2(vAcrescimoBruto - somaAnteriores)));
    }
    return parseFloat(num2(vAcrescimoBruto * (parseFloat(item.subtotal) / vProdTotalBruto)));
  });

  const detXml = itens.map((item, idx) => {
    const nItem = idx + 1;
    const qCom = num4(item.quantidade);
    const vUnCom = num4(item.preco_unitario);
    const vProd = num2(item.subtotal);
    const vDescItem = num2(descontosPorItem[idx]);
    somaVDesc += parseFloat(vDescItem);
    const vOutroItem = num2(acrescimosPorItem[idx]);
    somaVOutro += parseFloat(vOutroItem);
    const vIBSItem = (parseFloat(vProd) * 0.001).toFixed(2);
    const vCBSItem = (parseFloat(vProd) * 0.009).toFixed(2);
    somaVIBS += parseFloat(vIBSItem);
    somaVCBS += parseFloat(vCBSItem);
    // Exigência da Sefaz: em ambiente de teste (homologação), o 1º item da nota
    // precisa ter esse nome exato — é assim que garantem que ninguém confunde
    // nota de teste com nota de verdade.
    const nomeProduto = (Number(ambiente) === 2 && nItem === 1)
      ? 'NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL'
      : item.nome_produto;
    return `
    <det nItem="${nItem}">
      <prod>
        <cProd>${escaparXml(item.produto_id || item.id)}</cProd>
        <cEAN>SEM GTIN</cEAN>
        <xProd>${escaparXml(nomeProduto)}</xProd>
        <NCM>${(item.ncm_produto || '').replace(/\D/g, '') || '21069090'}</NCM>
        ${item.situacao_icms === 'st' && item.cest ? `<CEST>${item.cest.replace(/\D/g, '')}</CEST>` : ''}
        <CFOP>${definirCfop(item)}</CFOP>
        <uCom>${escaparXml((item.unidade || 'UN').toUpperCase().slice(0, 6))}</uCom>
        <qCom>${qCom}</qCom>
        <vUnCom>${vUnCom}</vUnCom>
        <vProd>${vProd}</vProd>
        <cEANTrib>SEM GTIN</cEANTrib>
        <uTrib>${escaparXml((item.unidade || 'UN').toUpperCase().slice(0, 6))}</uTrib>
        <qTrib>${qCom}</qTrib>
        <vUnTrib>${vUnCom}</vUnTrib>
        ${parseFloat(vDescItem) > 0 ? `<vDesc>${vDescItem}</vDesc>` : ''}
        ${parseFloat(vOutroItem) > 0 ? `<vOutro>${vOutroItem}</vOutro>` : ''}
        <indTot>1</indTot>
      </prod>
      <imposto>
        <ICMS>${montarBlocoIcms(item)}</ICMS>
        <PIS><PISNT><CST>07</CST></PISNT></PIS>
        <COFINS><COFINSNT><CST>07</CST></COFINSNT></COFINS>
        <IBSCBS>
          <CST>000</CST>
          <cClassTrib>000001</cClassTrib>
          <gIBSCBS>
            <vBC>${vProd}</vBC>
            <gIBSUF>
              <pIBSUF>0.10</pIBSUF>
              <vIBSUF>${vIBSItem}</vIBSUF>
            </gIBSUF>
            <gIBSMun>
              <pIBSMun>0.00</pIBSMun>
              <vIBSMun>0.00</vIBSMun>
            </gIBSMun>
            <vIBS>${vIBSItem}</vIBS>
            <gCBS>
              <pCBS>0.90</pCBS>
              <vCBS>${vCBSItem}</vCBS>
            </gCBS>
          </gIBSCBS>
        </IBSCBS>
      </imposto>
    </det>`;
  }).join('');

  const vProdTotal = itens.reduce((s, i) => s + parseFloat(i.subtotal), 0);
  // Usa a SOMA dos vDesc de item (já arredondados, calculados acima) — nunca o valor
  // bruto da comanda direto — pro total bater exatamente com a soma declarada por item.
  const vDesconto = somaVDesc;
  // Usa a SOMA dos vOutro de item (já arredondados), nunca o valor bruto direto —
  // mesmo motivo do vDesconto acima, pro total bater exatamente com a Sefaz.
  const vAcrescimo = somaVOutro;
  const vNF = Math.max(0, vProdTotal - vDesconto + vAcrescimo);

  const pagXml = pagamentos.map(p => {
    const tPag = FORMA_PAGAMENTO_TPAG[p.forma_pagamento] || '99';
    // Pagamento em cartão (crédito/débito) OU Pix exige o bloco <card> — a Sefaz-SP passou
    // a cobrar isso também pro Pix (rejeição 391), não só cartão. Como a maquininha/Pix
    // não é integrado eletronicamente ao PanificaPro, usa tpIntegra=2 (não integrado) e
    // tBand=99 (Outros), já que não temos a bandeira real da maquininha.
    const cardXml = (tPag === '03' || tPag === '04' || tPag === '17') ? '<card><tpIntegra>2</tpIntegra><tBand>99</tBand></card>' : '';
    // Meio de pagamento "99 - Outros" (ex: Voucher) exige uma descrição textual —
    // usa o próprio nome da forma de pagamento cadastrada na comanda.
    const xPagXml = tPag === '99' ? `<xPag>${escaparXml(p.forma_pagamento || 'Outros')}</xPag>` : '';
    // vPag precisa ser o valor FÍSICO entregue (com o troco embutido), não o valor líquido
    // já aplicado na comanda — a Sefaz rejeita (869) se a soma dos vPag não bater com
    // vNF + vTroco. Nosso banco guarda p.valor já líquido (sem o troco) e p.troco à parte,
    // então soma os dois de volta aqui só pra declarar na nota.
    const vPagComTroco = parseFloat(p.valor || 0) + (parseFloat(p.troco) || 0);
    return `
      <detPag>
        <tPag>${tPag}</tPag>${xPagXml}
        <vPag>${num2(vPagComTroco)}</vPag>${cardXml}
      </detPag>`;
  }).join('');

  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<NFe xmlns="http://www.portalfiscal.inf.br/nfe">
  <infNFe Id="NFe${chave}" versao="4.00">
    <ide>
      <cUF>${cUF}</cUF>
      <cNF>${cNF}</cNF>
      <natOp>Venda</natOp>
      <mod>65</mod>
      <serie>${serie}</serie>
      <nNF>${numero}</nNF>
      <dhEmi>${dhEmiIso}</dhEmi>
      <tpNF>1</tpNF>
      <idDest>1</idDest>
      <cMunFG>${padaria.nfce_codigo_municipio_ibge}</cMunFG>
      <tpImp>4</tpImp>
      <tpEmis>1</tpEmis>
      <cDV>${chave.slice(-1)}</cDV>
      <tpAmb>${ambiente}</tpAmb>
      <finNFe>1</finNFe>
      <indFinal>1</indFinal>
      <indPres>1</indPres>
      <procEmi>0</procEmi>
      <verProc>PanificaPro 1.0</verProc>
    </ide>
    <emit>
      <CNPJ>${cnpjLimpo}</CNPJ>
      <xNome>${escaparXml(padaria.nfce_razao_social || padaria.nome)}</xNome>
      <enderEmit>
        <xLgr>${escaparXml(padaria.nfce_logradouro)}</xLgr>
        <nro>${escaparXml(padaria.nfce_numero)}</nro>
        <xBairro>${escaparXml(padaria.nfce_bairro)}</xBairro>
        <cMun>${padaria.nfce_codigo_municipio_ibge}</cMun>
        <xMun>${escaparXml(padaria.nfce_municipio)}</xMun>
        <UF>${padaria.nfce_uf}</UF>
        <CEP>${String(padaria.nfce_cep || '').replace(/\D/g, '')}</CEP>
        <cPais>1058</cPais>
        <xPais>Brasil</xPais>
      </enderEmit>
      <IE>${String(padaria.nfce_inscricao_estadual || '').replace(/\D/g, '')}</IE>
      <CRT>1</CRT>
    </emit>
    ${detXml}
    <total>
      <ICMSTot>
        <vBC>0.00</vBC>
        <vICMS>0.00</vICMS>
        <vICMSDeson>0.00</vICMSDeson>
        <vFCP>0.00</vFCP>
        <vBCST>0.00</vBCST>
        <vST>0.00</vST>
        <vFCPST>0.00</vFCPST>
        <vFCPSTRet>0.00</vFCPSTRet>
        <vProd>${num2(vProdTotal)}</vProd>
        <vFrete>0.00</vFrete>
        <vSeg>0.00</vSeg>
        <vDesc>${num2(vDesconto)}</vDesc>
        <vII>0.00</vII>
        <vIPI>0.00</vIPI>
        <vIPIDevol>0.00</vIPIDevol>
        <vPIS>0.00</vPIS>
        <vCOFINS>0.00</vCOFINS>
        <vOutro>${num2(vAcrescimo)}</vOutro>
        <vNF>${num2(vNF)}</vNF>
      </ICMSTot>
      <IBSCBSTot>
        <vBCIBSCBS>${num2(vProdTotal)}</vBCIBSCBS>
        <gIBS>
          <gIBSUF><vDif>0.00</vDif><vDevTrib>0.00</vDevTrib><vIBSUF>${num2(somaVIBS)}</vIBSUF></gIBSUF>
          <gIBSMun><vDif>0.00</vDif><vDevTrib>0.00</vDevTrib><vIBSMun>0.00</vIBSMun></gIBSMun>
          <vIBS>${num2(somaVIBS)}</vIBS>
          <vCredPres>0.00</vCredPres>
          <vCredPresCondSus>0.00</vCredPresCondSus>
        </gIBS>
        <gCBS>
          <vDif>0.00</vDif>
          <vDevTrib>0.00</vDevTrib>
          <vCBS>${num2(somaVCBS)}</vCBS>
          <vCredPres>0.00</vCredPres>
          <vCredPresCondSus>0.00</vCredPresCondSus>
        </gCBS>
      </IBSCBSTot>
    </total>
    <transp><modFrete>9</modFrete></transp>
    <pag>${pagXml}
      <vTroco>${num2(pagamentos.reduce((s, p) => s + (parseFloat(p.troco) || 0), 0))}</vTroco>
    </pag>
    <infAdic>
      <infCpl>Comanda ${escaparXml(comanda.identificador)} - emitido via PanificaPro</infCpl>
    </infAdic>
  </infNFe>
</NFe>`;

  return { xml, chave, cNF, dhEmi: agora };
}

module.exports = { montarXmlNFCe };
