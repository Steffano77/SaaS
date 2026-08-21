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

  const detXml = itens.map((item, idx) => {
    const nItem = idx + 1;
    const qCom = num4(item.quantidade);
    const vUnCom = num4(item.preco_unitario);
    const vProd = num2(item.subtotal);
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
        <NCM>21069090</NCM>
        <CFOP>5102</CFOP>
        <uCom>${escaparXml((item.unidade || 'UN').toUpperCase().slice(0, 6))}</uCom>
        <qCom>${qCom}</qCom>
        <vUnCom>${vUnCom}</vUnCom>
        <vProd>${vProd}</vProd>
        <cEANTrib>SEM GTIN</cEANTrib>
        <uTrib>${escaparXml((item.unidade || 'UN').toUpperCase().slice(0, 6))}</uTrib>
        <qTrib>${qCom}</qTrib>
        <vUnTrib>${vUnCom}</vUnTrib>
        <indTot>1</indTot>
      </prod>
      <imposto>
        <ICMS><ICMSSN102><orig>0</orig><CSOSN>102</CSOSN></ICMSSN102></ICMS>
        <PIS><PISNT><CST>07</CST></PISNT></PIS>
        <COFINS><COFINSNT><CST>07</CST></COFINSNT></COFINS>
        <IBSCBS>
          <CST>000</CST>
          <cClassTrib>000001</cClassTrib>
          <gIBSCBS>
            <vBC>${vProd}</vBC>
            <gIBSUF>
              <pIBSUF>0.10</pIBSUF>
              <vIBSUF>${(parseFloat(vProd) * 0.001).toFixed(2)}</vIBSUF>
            </gIBSUF>
            <gIBSMun>
              <pIBSMun>0.00</pIBSMun>
              <vIBSMun>0.00</vIBSMun>
            </gIBSMun>
            <vIBS>${(parseFloat(vProd) * 0.001).toFixed(2)}</vIBS>
            <gCBS>
              <pCBS>0.90</pCBS>
              <vCBS>${(parseFloat(vProd) * 0.009).toFixed(2)}</vCBS>
            </gCBS>
          </gIBSCBS>
        </IBSCBS>
      </imposto>
    </det>`;
  }).join('');

  const vProdTotal = itens.reduce((s, i) => s + parseFloat(i.subtotal), 0);
  const vDesconto = parseFloat(comanda.desconto || 0);
  const vAcrescimo = parseFloat(comanda.acrescimo || 0);
  const vNF = Math.max(0, vProdTotal - vDesconto + vAcrescimo);

  const pagXml = pagamentos.map(p => {
    const tPag = FORMA_PAGAMENTO_TPAG[p.forma_pagamento] || '99';
    // Pagamento em cartão (crédito/débito) exige o bloco <card> — como a maquininha
    // não é integrada eletronicamente ao PanificaPro, usa tpIntegra=2 (não integrado).
    // Só tpIntegra é obrigatório de fato, o resto (bandeira, autorização) é opcional.
    const cardXml = (tPag === '03' || tPag === '04') ? '<card><tpIntegra>2</tpIntegra></card>' : '';
    return `
      <detPag>
        <tPag>${tPag}</tPag>
        <vPag>${num2(p.valor)}</vPag>${cardXml}
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
      <xNome>${escaparXml(padaria.nome)}</xNome>
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
          <gIBSUF><vDif>0.00</vDif><vDevTrib>0.00</vDevTrib><vIBSUF>${(vProdTotal * 0.001).toFixed(2)}</vIBSUF></gIBSUF>
          <gIBSMun><vDif>0.00</vDif><vDevTrib>0.00</vDevTrib><vIBSMun>0.00</vIBSMun></gIBSMun>
          <vIBS>${(vProdTotal * 0.001).toFixed(2)}</vIBS>
          <vCredPres>0.00</vCredPres>
          <vCredPresCondSus>0.00</vCredPresCondSus>
        </gIBS>
        <gCBS>
          <vDif>0.00</vDif>
          <vDevTrib>0.00</vDevTrib>
          <vCBS>${(vProdTotal * 0.009).toFixed(2)}</vCBS>
          <vCredPres>0.00</vCredPres>
          <vCredPresCondSus>0.00</vCredPresCondSus>
        </gCBS>
      </IBSCBSTot>
    </total>
    <transp><modFrete>9</modFrete></transp>
    <pag>${pagXml}
    </pag>
    <infAdic>
      <infCpl>Comanda ${escaparXml(comanda.identificador)} - emitido via PanificaPro</infCpl>
    </infAdic>
  </infNFe>
</NFe>`;

  return { xml, chave, cNF, dhEmi: agora };
}

module.exports = { montarXmlNFCe };
