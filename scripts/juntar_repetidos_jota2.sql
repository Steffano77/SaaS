-- Junta produtos repetidos da Padaria do Jota 2 (padaria_id = 2) que ficaram em dobro
-- depois de juntar nuvem + Saurus + Jota 3: mesmo nome, uma versao SEM codigo (em geral
-- a da nuvem, com historico de compras) e outra COM codigo (a que veio de importacao).
-- O que faz, so quando e exatamente 1 de cada e a versao com codigo NAO tem historico:
--   - passa codigo de barras, codigo de balanca, NCM, ST e preco (se estava zero) pra
--     versao sem codigo, que guarda o historico
--   - estoque: mantem o da versao sem codigo; se estiver zerado, usa o da outra
--   - desativa a versao com codigo (nao apaga nada)
-- Casos com codigos diferentes nos dois (ex: embalagens diferentes) ficam como estao.
SET NAMES utf8mb4;

DROP TEMPORARY TABLE IF EXISTS pares_repetidos;
CREATE TEMPORARY TABLE pares_repetidos AS
SELECT a.id AS a_id, b.id AS b_id
FROM produtos a
JOIN produtos b ON b.padaria_id = 2 AND b.ativo = 1 AND b.nome = a.nome AND b.id <> a.id
WHERE a.padaria_id = 2 AND a.ativo = 1
  AND (a.codigo_barras IS NULL OR a.codigo_barras = '')
  AND b.codigo_barras IS NOT NULL AND b.codigo_barras <> ''
  AND (SELECT COUNT(*) FROM produtos x WHERE x.padaria_id = 2 AND x.ativo = 1 AND x.nome = a.nome) = 2
  AND NOT EXISTS (SELECT 1 FROM movimentacoes m WHERE m.produto_id = b.id)
  AND NOT EXISTS (SELECT 1 FROM itens_pedido i WHERE i.produto_id = b.id)
  AND NOT EXISTS (SELECT 1 FROM itens_comanda c WHERE c.produto_id = b.id);

SELECT a.nome, b.codigo_barras AS codigo_que_vai_pra_versao_com_historico
FROM pares_repetidos p JOIN produtos a ON a.id = p.a_id JOIN produtos b ON b.id = p.b_id;

UPDATE produtos a
JOIN pares_repetidos p ON a.id = p.a_id
JOIN produtos b ON b.id = p.b_id
SET a.codigo_barras  = b.codigo_barras,
    a.codigo_balanca = COALESCE(NULLIF(a.codigo_balanca, ''), b.codigo_balanca),
    a.ncm            = COALESCE(NULLIF(a.ncm, ''), b.ncm),
    a.cest           = COALESCE(NULLIF(a.cest, ''), b.cest),
    a.situacao_icms  = IF(a.situacao_icms = 'normal', b.situacao_icms, a.situacao_icms),
    a.preco_venda    = IF(a.preco_venda = 0, b.preco_venda, a.preco_venda),
    a.estoque_atual  = IF(a.estoque_atual = 0, b.estoque_atual, a.estoque_atual);

UPDATE produtos b JOIN pares_repetidos p ON b.id = p.b_id SET b.ativo = 0;

SELECT COUNT(*) AS juntados FROM pares_repetidos;
DROP TEMPORARY TABLE pares_repetidos;
