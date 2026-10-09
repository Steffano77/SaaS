// Notas emitidas em contingência (Sefaz indisponível na hora da venda) ficam com
// status 'contingencia' e o XML já pronto/assinado, só esperando a Sefaz voltar.
// Esse job tenta transmitir de novo periodicamente — sem isso, a nota nunca "vira"
// de verdade (fica pra sempre só no papel entregue ao cliente, sem valer fiscalmente).
const db = require('../database/connection');
const { carregarCertificado } = require('../fiscal/certificado');
const { enviarNFCe, interpretarResposta } = require('../fiscal/sefazSP');

async function reenviarContingenciaPendentes() {
  const [pendentes] = await db.query(
    `SELECT id, padaria_id, numero, xml_assinado, ambiente FROM notas_fiscais WHERE status = 'contingencia'`
  );
  if (!pendentes.length) return;

  for (const nota of pendentes) {
    try {
      const cert = await carregarCertificado(nota.padaria_id);
      if (!cert.ok) continue; // tenta de novo no próximo ciclo

      const resposta = await enviarNFCe({
        xmlAssinado: nota.xml_assinado,
        ambiente: nota.ambiente === 1 ? 'producao' : 'homologacao',
        certPem: cert.certPem,
        keyPem: cert.keyPem,
      });
      const interpretado = interpretarResposta(resposta.corpo);
      if (interpretado.cStat === '100') {
        await db.query(
          `UPDATE notas_fiscais SET status = 'autorizada', protocolo_autorizacao = ?, motivo_rejeicao = NULL, autorizada_em = NOW() WHERE id = ?`,
          [interpretado.nProt || null, nota.id]
        );
        console.log(`[reenviar-contingencia] Nota ${nota.id} (número ${nota.numero}) transmitida com sucesso.`);
      }
      // cStat diferente de 100 (ainda rejeitando por outro motivo real, não rede):
      // deixa como está — aparece em "Notas pendentes" pra corrigir manualmente,
      // igual qualquer outra rejeição. Só erro de REDE a gente tenta de novo sozinho.
    } catch (erroRede) {
      // Sefaz ainda fora do ar — tenta de novo no próximo ciclo, sem alarde.
      console.log(`[reenviar-contingencia] Nota ${nota.id} ainda sem transmitir: ${erroRede.message}`);
    }
  }
}

function iniciarJobReenviarContingencia() {
  const cron = require('node-cron');
  // A cada 5 minutos — rápido o suficiente pra regularizar assim que a Sefaz volta
  // (tem prazo legal de até 24h), sem martelar o servidor da Sefaz toda hora.
  cron.schedule('*/5 * * * *', () => {
    reenviarContingenciaPendentes().catch(e => console.error('[reenviar-contingencia] Erro geral:', e.message));
  }, { timezone: 'America/Sao_Paulo' });
  console.log('[reenviar-contingencia] Job agendado a cada 5 minutos.');
}

module.exports = { iniciarJobReenviarContingencia, reenviarContingenciaPendentes };
