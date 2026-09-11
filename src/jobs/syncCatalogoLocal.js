// Projeto "servidor local" (resiliência offline) — SÓ roda quando o próprio servidor
// está configurado como o servidor local da padaria (mesmas variáveis de ambiente do
// job de resumo — nunca configuradas no servidor de produção, então lá esse job nem
// inicia — zero efeito lá).
//
// O que faz: de tempos em tempos, quando tiver internet, busca na nuvem o catálogo de
// produtos ATUAL dessa padaria (o que foi cadastrado/atualizado lá) e atualiza a cópia
// local — SEMPRE nuvem -> local, nunca o contrário. Isso deixa o dono livre pra
// cadastrar/mudar preço de onde estiver, sem precisar estar no PC físico da padaria.
//
// Cuidados importantes (evitam repetir os problemas já vistos nesse projeto):
//  - Nunca APAGA produto local (evita derrubar em cascata o histórico de vendas/estoque
//    que reference esse produto) — só atualiza campos de cadastro, ou marca como inativo
//    se a nuvem também marcou como inativo.
//  - NUNCA sobrescreve estoque_atual — estoque é sempre o número que está rolando de
//    verdade no PC que está vendendo (local), puxar da nuvem aqui traria um número velho.
//  - Upsert por id: like o catálogo veio originalmente da nuvem, os ids batem — então dá
//    pra usar o id como chave sem risco de duplicar (mesmo tipo de cuidado tomado na
//    limpeza de duplicados: nunca mesclar sem uma chave confiável).

const db = require('../database/connection');

let tokenCache = null;
let tokenObtidoEm = 0;

async function obterToken(cloudUrl, email, senha) {
  if (tokenCache && (Date.now() - tokenObtidoEm) < 50 * 60 * 1000) return tokenCache;
  const r = await fetch(`${cloudUrl}/api/auth/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email, senha }),
  });
  if (!r.ok) throw new Error(`Login na nuvem falhou (${r.status})`);
  const data = await r.json();
  tokenCache = data.token;
  tokenObtidoEm = Date.now();
  return tokenCache;
}

async function atualizarCatalogo() {
  const cloudUrl = process.env.SYNC_CLOUD_URL;
  const email = process.env.SYNC_CLOUD_EMAIL;
  const senha = process.env.SYNC_CLOUD_SENHA;
  if (!cloudUrl || !email || !senha) return; // não configurado como servidor local — não faz nada

  try {
    const token = await obterToken(cloudUrl, email, senha);
    const r = await fetch(`${cloudUrl}/api/sync/catalogo-produtos`, {
      headers: { Authorization: `Bearer ${token}` },
    });
    if (!r.ok) {
      tokenCache = null; // token pode ter expirado — força login de novo na próxima
      console.error('[sync-catalogo-local] Falha ao buscar catálogo:', r.status);
      return;
    }
    const { produtos } = await r.json();
    if (!Array.isArray(produtos)) return;

    // O servidor local atende UMA padaria só (o próprio banco local é dela) — pega o
    // padaria_id que já existe localmente em vez de supor um número fixo.
    const [[padariaLocal]] = await db.query('SELECT id FROM padarias LIMIT 1');
    if (!padariaLocal) {
      console.error('[sync-catalogo-local] Nenhuma padaria cadastrada localmente ainda — pulando.');
      return;
    }
    const padariaId = padariaLocal.id;

    for (const p of produtos) {
      await db.query(
        `INSERT INTO produtos
           (id, padaria_id, categoria_id, codigo_barras, codigo_balanca, nome, unidade,
            custo_unitario, preco_venda, estoque_minimo, validade, ativo, fornecedor_id,
            embalagem_preco, embalagem_qtd, venda_rapida, controla_estoque, ncm,
            origem_producao, situacao_icms, cest)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
         ON DUPLICATE KEY UPDATE
           categoria_id = VALUES(categoria_id), codigo_barras = VALUES(codigo_barras),
           codigo_balanca = VALUES(codigo_balanca), nome = VALUES(nome),
           unidade = VALUES(unidade), custo_unitario = VALUES(custo_unitario),
           preco_venda = VALUES(preco_venda), estoque_minimo = VALUES(estoque_minimo),
           validade = VALUES(validade), ativo = VALUES(ativo),
           fornecedor_id = VALUES(fornecedor_id), embalagem_preco = VALUES(embalagem_preco),
           embalagem_qtd = VALUES(embalagem_qtd), venda_rapida = VALUES(venda_rapida),
           controla_estoque = VALUES(controla_estoque), ncm = VALUES(ncm),
           origem_producao = VALUES(origem_producao), situacao_icms = VALUES(situacao_icms),
           cest = VALUES(cest)
           -- estoque_atual propositalmente de fora: nunca sobrescrever o estoque local`,
        [
          p.id, padariaId, p.categoria_id, p.codigo_barras, p.codigo_balanca, p.nome, p.unidade,
          p.custo_unitario, p.preco_venda, p.estoque_minimo, p.validade, p.ativo,
          p.fornecedor_id, p.embalagem_preco, p.embalagem_qtd, p.venda_rapida,
          p.controla_estoque, p.ncm, p.origem_producao, p.situacao_icms, p.cest,
        ]
      );
    }
    console.log(`[sync-catalogo-local] Catálogo atualizado: ${produtos.length} produtos.`);
  } catch (e) {
    // Sem internet, ou nuvem fora do ar — normal acontecer, não trava nada local.
    console.error('[sync-catalogo-local] Não deu pra atualizar (sem internet?):', e.message);
  }
}

function iniciarJobSyncCatalogoLocal() {
  const intervaloMin = parseInt(process.env.SYNC_CATALOGO_INTERVALO_MINUTOS, 10) || 15;
  if (!process.env.SYNC_CLOUD_URL) return; // servidor normal (produção) — não ativa esse job

  console.log(`[sync-catalogo-local] Ativado — buscando catálogo a cada ${intervaloMin} min de ${process.env.SYNC_CLOUD_URL}`);
  atualizarCatalogo(); // já busca assim que liga, sem esperar o primeiro intervalo
  setInterval(atualizarCatalogo, intervaloMin * 60 * 1000);
}

module.exports = { iniciarJobSyncCatalogoLocal, atualizarCatalogo };
