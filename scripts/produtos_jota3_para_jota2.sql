-- Produtos da Padaria do Jota 3 pra Padaria do Jota 2 (padaria_id = 2).
-- So entra o que a Jota 2 ainda nao tem (mesmo codigo, ou mesmo nome quando nao tem codigo).
-- Pode rodar mais de uma vez sem duplicar. Estoque entra zerado.
SET NAMES utf8mb4;
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Açucar Caravelas refinado 1kg', '7896894900013', NULL, 'PACOTE', 2.79, 4.99, 0, '17019900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896894900013');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Água Crystal  1,5 litros', '7894900530032', NULL, 'UNIDADE', 2.9, 8, 0, '22011000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900530032');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Água Crystal com Gás 1,5 litros', '7894900531015', NULL, 'UNIDADE', 3.02, 8, 3, '22011000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900531015');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Água Crystal com Gás 500ml', '7894900531008', NULL, 'UNIDADE', 1.71, 5, 0, '22011000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900531008');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Agua Mineral Clarissima 1,5l', '7898906467309', NULL, 'UNIDADE', 1.79, 6, 0, '22011000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898906467309');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Agua Mineral Cristal 510ml', '7898950286178', NULL, 'UNIDADE', 0.91, 3, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898950286178');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Agua Sanitaria Maximo 1l', '7898944352018', NULL, 'UNIDADE', 2.8, 4.2, 0, '28289011', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352018');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Álcool tauipe 1 litro', '7898969948036', NULL, 'UNIDADE', 10.62, 14, 0, '22071090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898969948036');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Amaciante Sense QBOA 500ml', '7896083800810', NULL, 'UNIDADE', 2.99, 4.5, 0, '38099190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896083800810');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Amoníaco (Fábio)', NULL, NULL, 'UNIDADE', 23.5, 0, 0, '28369919', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Amoníaco (Fábio)');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Amstel 600ml', '7896045504541', NULL, 'UNIDADE', 7.28, 12, 0, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045504541');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Amstel Lata 269ml', '7896045505319', NULL, 'UNIDADE', 3.63, 5.5, 0, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045505319');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Amstel Lata 350ml', '7896045506934', NULL, 'UNIDADE', 4.66, 7, 0, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045506934');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Assugrin Tradicional 100ml', '7896569405737', NULL, 'UNIDADE', 4.59, 6, 0, '21069090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896569405737');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Aveia em Flocos Nestlé 170g', '7891000102640', NULL, 'UNIDADE', 4.19, 6.5, 0, '11041200', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000102640');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Babbaloo', '7895800002957', NULL, 'UNIDADE', 0.28, 0.5, 0, '17041000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895800002957');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bacon em Cubos', NULL, NULL, 'KG', 21.38, 0, 0, '02101100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Bacon em Cubos');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baden Baden Ipa Maracujá 350ml', '7898230716654', NULL, 'UNIDADE', 4.86, 7, 0, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898230716654');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Barra chocolate laka Lacta 80g', '7622210674319', NULL, 'UNIDADE', 8.13, 12, 0, '17049010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210674319');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Batata Palha 100g', '7897844304653', NULL, 'UNIDADE', 7.99, 12, 0, '20052000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897844304653');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baton ao leite 16g', '78912359', NULL, 'UNIDADE', 1.4, 2, 0, '18063210', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78912359');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baton Chocolate Branco 16g', '78912366', NULL, 'UNIDADE', 1.4, 2, 0, '17049010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78912366');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bis Branco 100,8gr', '7622210575999', NULL, 'UNIDADE', 0, 9.99, 0, '19053200', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210575999');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bis Lacta Original 100,8gr', '7622210575975', NULL, 'UNIDADE', 6.19, 8.99, 0, '19053200', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210575975');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha de maizena coco 300g', '7896003740233', NULL, 'UNIDADE', 4.48, 8.5, 0, '19053100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896003740233');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha de Maizena Triunfo 345g', '7896058258530', NULL, 'PACOTE', 4.25, 8.5, 0, '19053100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896058258530');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha Maizena Marilan 300g', '7896003740226', NULL, 'UNIDADE', 4.29, 6.99, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896003740226');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bom ar Algodão 360ml ', '7891035534072', NULL, 'UNIDADE', 13.9, 21, 0, '33074900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891035534072');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bom Ar Limão Siciliano 360ml', '7891035536700', NULL, 'UNIDADE', 15, 21, 0, '08055000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891035536700');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bom Ar Talco 360ml', '7891035325625', NULL, 'UNIDADE', 17.9, 21, 0, '33074900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891035325625');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Brahma Chopp 350ml', '7891149010509', NULL, 'UNIDADE', 2.92, 5, 5, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891149010509');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Brahma Chopp 600ml', '7891149010400', NULL, 'UNIDADE', 3.99, 12, 0, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891149010400');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Brahma Zero 350ml', '7891149104932', NULL, 'UNIDADE', 2.83, 5, 0, '22029100', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891149104932');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café 3 Corações Tradicional 250g', '262', '026200', 'UNIDADE', 11.24, 17.75, 0, '09012100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '262');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cafe Soluvel 3 Corações 40g', '7896045103003', NULL, 'UNIDADE', 4.63, 7, 0, '21011110', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045103003');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Carvão 2kg', '7908119296822', NULL, 'UNIDADE', 10, 15, 0, '44029000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908119296822');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chá verde Leão 16g', '7891098000149', NULL, 'UNIDADE', 2.68, 5, 0, '09021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891098000149');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate Snickers 40g', '7896423438994', NULL, 'UNIDADE', 2.99, 4.5, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896423438994');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate Twix Caramelo 40g', '7896423470994', NULL, 'UNIDADE', 2.99, 5, 0, '18063110', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896423470994');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola 1 litro Pet', '7894900011715', NULL, 'UNIDADE', 7.41, 10, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900011715');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola Caçulinha Zero', '78933873', NULL, 'UNIDADE', 0, 3, 1, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78933873');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola Ks Zero 290ml', '410', '041000', 'UNIDADE', 2.35, 5, 20, '22021000', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '410');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola Lata Zero 350ml', '7894900700015', NULL, 'UNIDADE', 3.19, 6, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900700015');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola Zero 290ml', '7894900705034', NULL, 'UNIDADE', 0, 5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900705034');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola Zero 2l', '7894900701517', NULL, 'UNIDADE', 9.13, 15, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900701517');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola Zero 600ml', '7894900701609', NULL, 'UNIDADE', 4.42, 8, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900701609');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola Zero Retornável 2l', '7894900704211', NULL, 'UNIDADE', 6.15, 10, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900704211');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Zero Lata 220ml', '7894900700398', NULL, 'UNIDADE', 0, 3.5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900700398');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cookie Negresco Nestlé 60g', '7891000247624', NULL, 'UNIDADE', 1.98, 5, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000247624');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cookies Melfi', '6026', '602600', 'un', 8, 14, 0, '19053100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6026');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Copo de descartável 400ml', NULL, NULL, 'cx', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Copo de descartável 400ml');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Creme de Leite UNIFERM 1kg', NULL, NULL, 'pct', 14.4, 0, 1, '04022930', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Creme de Leite UNIFERM 1kg');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Laranja 1 Litro', '7898341430111', NULL, 'UNIDADE', 8.32, 12.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898341430111');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Lata Goiaba 290ml', '7894900660265', NULL, 'UNIDADE', 3.56, 5.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900660265');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Lata Manga 290ml', '7894900660401', NULL, 'UNIDADE', 3.56, 5.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900660401');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Lata Pessego 290ml', '7894900660319', NULL, 'UNIDADE', 3.29, 5.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900660319');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Uva Pet 1l', '7894900550030', NULL, 'UNIDADE', 4.22, 7, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900550030');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desinfetante Maximo Jasmin 2l', '7898944352186', NULL, 'UNIDADE', 4.19, 6, 0, '38089419', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352186');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desinfetante Maximo Talco Mandarim 2l', '7898944352391', NULL, 'UNIDADE', 4.19, 6, 0, '38089419', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352391');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Dunhil Insignia Red', '78947504', NULL, 'UNIDADE', 0, 15.5, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947504');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Eisenbahn 350ml', '7898367983790', NULL, 'UNIDADE', 0, 6, 0, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898367983790');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fanta Guarana Lata 350ml', '7894900093001', NULL, 'UNIDADE', 5, 6, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900093001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fanta Laranja 350ml', '7894900030013', NULL, 'UNIDADE', 2.48, 6, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900030013');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fanta Laranja Pet 2l', '7894900031515', NULL, 'UNIDADE', 8.28, 13, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900031515');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fanta Uva Lata 350ml', '7894900050011', NULL, 'UNIDADE', 2.48, 6, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900050011');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fanta Uva Pet 2l', '7894900051513', NULL, 'UNIDADE', 8.29, 13, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900051513');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Farinha de Mandioca KICALDO 1KG', '7896116900623', NULL, 'UNIDADE', 6.45, 10, 0, '11062000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896116900623');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Farofa Pronta da Terrinha 400g', '7898960982213', NULL, 'UNIDADE', 5.29, 6.8, 0, '19019090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898960982213');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Frui-tella Morango', '7895144028019', NULL, 'UNIDADE', 1.98, 4, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895144028019');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fruittela Mastigavel Morango 40g', '7896262301022', NULL, 'UNIDADE', 2.77, 4, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896262301022');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fruittella Bala Dura de Caramelo', '7895144025117', NULL, 'UNIDADE', 2.77, 4, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895144025117');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gatorade Sabor Limao 500ml', '7892840808037', NULL, 'UNIDADE', 4.49, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840808037');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gelatina abacaxi apit 20g', '7896327516132', NULL, 'UNIDADE', 1.48, 2.5, 0, '21069029', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896327516132');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Guaraná Antarctica 2l', '7891991001342', NULL, 'UNIDADE', 7.99, 12, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991001342');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Guaraná Antarctica 350ml', '7891991000826', NULL, 'UNIDADE', 2.73, 6, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991000826');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Guaraná Antarctica 600ml', '7891991002646', NULL, 'UNIDADE', 3.6, 8, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991002646');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Guaraná Antarctica Zero 350ml', '7891991000727', NULL, 'UNIDADE', 2.73, 5, 0, '02071419', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991000727');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Guarana Antartica Zero 600ml', '7891991002684', NULL, 'UNIDADE', 3.6, 8, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991002684');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Guaraviton Sabor Açai 500ml', '7896326100219', NULL, 'UNIDADE', 2.29, 5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896326100219');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'H2O Limoneto', '7892840812850', NULL, 'UNIDADE', 3.61, 6, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840812850');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Heineken 269ml', '7896045506590', NULL, 'UNIDADE', 5.37, 8, 0, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045506590');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Heineken 330ml', '78936683', NULL, 'UNIDADE', 0, 12.5, 0, '22030000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78936683');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Heineken 350ml', '7896045506873', NULL, 'UNIDADE', 3.85, 10, 0, '22030000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045506873');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Heineken 600ml', '78905498', NULL, 'UNIDADE', 0, 17, 0, '22030000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78905498');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Heineken Long Neck 250ml', '78935495', NULL, 'UNIDADE', 0, 12.5, 0, '22030000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78935495');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ice Tea Leão Sabor Limão 450ml', '7891098040848', NULL, 'UNIDADE', 3.35, 5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891098040848');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ice Tea Leão Sabor Pêssego 450ml', '7891098040893', NULL, 'UNIDADE', 3.36, 5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891098040893');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Iogurte Frutap 450gr', '7896862000011', NULL, 'UNIDADE', 5.8, 8, 0, '04032000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896862000011');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Iogurte Frutap Morango 160g', '7896862000806', NULL, 'UNIDADE', 2.7, 3.75, 0, '04032000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896862000806');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Iogurte Natural Frutap 150g', '7896862000431', NULL, 'UNIDADE', 2.7, 4, 1, '04032000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896862000431');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'It Guarana 2l', '7898377662425', NULL, 'UNIDADE', 4.78, 7.5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898377662425');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'It Laranja 2l', '7898377662487', NULL, 'UNIDADE', 4.75, 7.5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898377662487');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'It Limão 2l', '7898377662449', NULL, 'UNIDADE', 4.78, 7.5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898377662449');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Itaipava 350ml', '7897395020101', NULL, 'UNIDADE', 2.32, 5, 0, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897395020101');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Itaipava 600ml', '78906709', NULL, 'UNIDADE', 5.07, 10, 0, '22030000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78906709');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Itubaina Garrafa de Vidro 355ml', '7896052603497', NULL, 'UNIDADE', 4.48, 6, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896052603497');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Itubaina Lata 350ml', '7896052604975', NULL, 'UNIDADE', 3.52, 5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896052604975');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Itubaína Original 600ml', '7896052606191', NULL, 'UNIDADE', 4.45, 6, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896052606191');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Kent blue series', '78943148', NULL, 'UNIDADE', 15.32, 16.5, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78943148');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'KENT SILVER SERIES prata', '78942936', NULL, 'UNIDADE', 15.32, 16.5, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78942936');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Lacta ao Leite 80g', '7622210673831', NULL, 'UNIDADE', 8.13, 12, 0, '18063210', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210673831');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite em Pó Italac 400g', '7898080641694', NULL, 'UNIDADE', 15.69, 20, 0, '04022110', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898080641694');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite Fermentantado Frutap 800g', '7896862002060', NULL, 'UNIDADE', 9.85, 14, 1, '04039000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896862002060');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite Integral Italac 1 Litro', '7898080640611', NULL, 'UNIDADE', 4.79, 7, 0, '04012010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898080640611');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite Jussara Integral 1 Litro', '7896283800801', NULL, 'UNIDADE', 5.1, 7, 0, '04012010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896283800801');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Limpador Multiuso Veja Lavanda 500ml', '7891035210334', NULL, 'UNIDADE', 5.15, 7.75, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891035210334');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mentos freshmint ', '7895144899947', NULL, 'UNIDADE', 1.16, 2, 0, '21069050', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895144899947');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mentos frutas fruit 37,5g', '7896262304351', NULL, 'UNIDADE', 2.25, 3.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896262304351');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Milho de Pipoca KiSabor 400g', '7898416520563', NULL, 'UNIDADE', 3.99, 5.5, 0, '10059010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898416520563');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Milho Stella Sachê', '7898902299843', NULL, 'UNIDADE', 2.13, 4.5, 0, '20058000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898902299843');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Miojo Cup Noodles Galinha Caipira 69g', '7891079013038', NULL, 'UNIDADE', 5.29, 8, 0, '19023000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891079013038');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mistura para Bolo Chocolate Apti 400g', '7896327511984', NULL, 'UNIDADE', 3.29, 6, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896327511984');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molho de Alho GOTA 150ML', '7898286190361', NULL, 'UNIDADE', 3.49, 5, 0, '21039021', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898286190361');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Monster Energy Zero Acucar 473ml', '7898938890076', NULL, 'UNIDADE', 8.5, 12.75, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898938890076');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Monster Mango Loco 473ml', '070847033301', NULL, 'UNIDADE', 8.5, 12.75, 0, '22029900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '070847033301');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mortadela defumada', NULL, '915', 'cx', 19.9, 0, 0, '16010000', 'normal', 'revenda', NULL, 1, 0, 0, 162.8, 8.18, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Mortadela defumada');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mostarda Predilecta 180g', '7896292300477', NULL, 'UNIDADE', 3.65, 5.5, 0, '21032090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896292300477');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Nescafé Cappuccino 270ml', '7891000110829', NULL, 'UNIDADE', 7.89, 11, 0, '21011200', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000110829');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Oleo de Soja Soya 1l', '7891107101621', NULL, 'UNIDADE', 7.19, 10, 0, '15079011', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891107101621');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Oreo Morango 90g', '7622300989408', NULL, 'UNIDADE', 3.33, 5, 0, '19053100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622300989408');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Original 350ml', '7891991015493', NULL, 'UNIDADE', 3.41, 6, 0, '22030000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991015493');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Original 600ml', '78905351', NULL, 'UNIDADE', 5.8, 12, 0, '22030000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78905351');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ouro Branco Bombom', '78939318', NULL, 'UNIDADE', 1.08, 2, 0, '19053200', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78939318');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Higiênico c/4 Folha Dupla NEVE', '7891172421174', NULL, 'UNIDADE', 12, 14, 0, '48181000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891172421174');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Higiênico ECONOBOM 4 Rolos', '7897844300723', NULL, 'UNIDADE', 6.1, 9, 0, '48181000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897844300723');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Toalha Soul', NULL, NULL, 'fardo', 33.6, 0, 0, '48182000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Papel Toalha Soul');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Toalha Yuri  3 Rolos', '7896075301257', NULL, 'UNIDADE', 12.9, 17, 0, '48189090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896075301257');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Passatempo sabor chocolate 130g', '7891000457368', NULL, 'UNIDADE', 2.3, 4, 0, '19053100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000457368');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'pente fino de ferro', '7898504933596', NULL, 'UNIDADE', 4, 8, 0, '96151100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898504933596');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pepsi Black 350ml', '7892840813505', NULL, 'UNIDADE', 2.33, 6, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840813505');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picole chocolate blanco 60gr', '7896513912199', NULL, 'UNIDADE', 6.41, 9, 0, '21050010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912199');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Powerade Frutas Tropicais 500ml', '7894900508017', NULL, 'UNIDADE', 3.57, 6, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900508017');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pudim pequeno', '979', '097900', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '979');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Red Bull 473 ml', '9002490214166', NULL, 'UNIDADE', 10.78, 15, 0, '22029900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9002490214166');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Requeijão 480g', NULL, NULL, 'un', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Requeijão 480g');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Requeijão Frutap 175gr', '7896862000486', NULL, 'UNIDADE', 7.1, 10, 2, '04061090', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896862000486');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rothmans Blue Max', '78947603', NULL, 'UNIDADE', 12.92, 14, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947603');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rothmans click sense Max', '78947597', NULL, 'UNIDADE', 6.92, 13, 0, '02012020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947597');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rothmans global blue/azul', '78944237', NULL, 'UNIDADE', 10.15, 11, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78944237');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rothmans global blue/azul novo', '78947610', NULL, 'UNIDADE', 0, 11, 0, '02012020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947610');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rothmans hand Red Box', '78944497', NULL, 'UNIDADE', 8.31, 12, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78944497');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rothmans hand selec silver', '78944503', NULL, 'UNIDADE', 8.33, 12, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78944503');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabão em pasta 500g', '7893595869014', NULL, 'UNIDADE', 4.47, 7.5, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7893595869014');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabão Liquido Maximo 2 Litros', '7898944352445', NULL, 'UNIDADE', 8.89, 13.35, 0, '34012090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352445');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Saco de Lixo grande Transparente', NULL, NULL, 'fardo', 65, 0, 0, '39232190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Saco de Lixo grande Transparente');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Salame Sadia', NULL, NULL, 'cx', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Salame Sadia');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Salsicha Perdigão', NULL, NULL, 'cx', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Salsicha Perdigão');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Skol 350ml', '7891149200504', NULL, 'UNIDADE', 2.92, 6, 0, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891149200504');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Skol 600ml', '7891149200405', NULL, 'UNIDADE', 4.43, 12, 0, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891149200405');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Soda Limonada Antarctica 350ml', '7891991000833', NULL, 'UNIDADE', 2.35, 5, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991000833');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sofiteli', NULL, NULL, 'bd', 7.9, 0, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Sofiteli');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sonho de Valsa Bombom', '78939301', NULL, 'UNIDADE', 1.08, 2, 0, '19053200', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78939301');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sprite 600ml', '7894900681246', NULL, 'UNIDADE', 7.6, 8, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900681246');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sprite Zero 600ml', '7894900061604', NULL, 'UNIDADE', 4.1, 8, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900061604');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sprite Zero Açucar 350ml', '7894900060010', NULL, 'UNIDADE', 2.48, 6, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900060010');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Caju 300ml VivaMais', NULL, NULL, 'fardo', 42.48, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Suco de Caju 300ml VivaMais');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Goiaba Viva Mais 300 ml', '7898344179123', NULL, 'UNIDADE', 3.54, 5.5, 0, '22029900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898344179123');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Laranja 300ml VivaMais', NULL, NULL, 'fardo', 45.36, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Suco de Laranja 300ml VivaMais');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de laranja Viva Mais 300 ml', '7898344178874', NULL, 'UNIDADE', 3.78, 5.5, 0, '20091200', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898344178874');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Uva 300ml Viva Mais', NULL, NULL, 'fardo', 45.36, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Suco de Uva 300ml Viva Mais');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Uva Viva Mais 300ml', '7898344179079', NULL, 'UNIDADE', 3.78, 5.5, 0, '22029900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898344179079');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tempero Maggi Carnes 50g', '7891000037300', NULL, 'UNIDADE', 2.47, 3.5, 0, '21039021', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000037300');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tnt Original 269ml', '7897395031602', NULL, 'UNIDADE', 5.34, 7.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897395031602');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Toscana', '217', '021700', 'cx', 0, 0, 0, '16010000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '217');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trakinas meio chocolate branco 126g', NULL, NULL, 'UNIDADE', 2.66, 3.5, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Trakinas meio chocolate branco 126g');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Veja 500ml', '7891035210006', NULL, 'UNIDADE', 3.65, 6, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891035210006');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Veja Multi-Uso Campestre 500ml', '7891035209000', NULL, 'UNIDADE', 5.49, 8.5, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891035209000');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Wafer Prestígio 110g', '7891000077924', NULL, 'UNIDADE', 3.43, 5, 0, '19053200', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000077924');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola 600 ml Zero', '7894900701609', NULL, 'UNIDADE', 0, 8, 1, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900701609');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Manteiga Pareia', '24', '002400', 'cx', 31.2, 50, 1, '04051000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '24');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, '5star Lacta 40gr', '7622210411501', NULL, 'UNIDADE', 0, 3.8, 0, '18069000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210411501');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Absorvente Always Fluxo Intenso Seca G', '7506339394535', NULL, 'UNIDADE', 7.9, 11.85, 0, '96190000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7506339394535');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Absorvente Always Fluxo Intenso Suave G', '7506339394603', NULL, 'UNIDADE', 7.9, 11.85, 0, '96190000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7506339394603');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Absorvente intimus GEL SECA C/ABAS', '7896007540631', NULL, 'UNIDADE', 3.5, 7, 0, '96190000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896007540631');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Absorvente Intimus Noturno C/8', '7896007540662', NULL, 'UNIDADE', 4.99, 11.5, 0, '96190000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896007540662');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Acém', NULL, NULL, 'UNIDADE', 30.99, 34.9, 0, NULL, 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Acém');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Achocolatado em Pó Nescau 200g', '7891000379585', NULL, 'UNIDADE', 6.96, 9, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000379585');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Achocolatado Nescau 350g', '7891000412855', NULL, 'UNIDADE', 8.9, 12, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000412855');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Achocolatado Toddy 200g', '7894321711171', NULL, 'UNIDADE', 7.49, 10, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894321711171');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Achocolatado Toddy 370g', '7892840819507', NULL, 'UNIDADE', 9.96, 12, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840819507');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Açucar Alto Alegre 1kg', '7896508200034', NULL, 'PACOTE', 0, 5.5, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896508200034');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Açucar de Confeiteiro', NULL, NULL, 'UNIDADE', 4.98, 0, 2, '17019900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Açucar de Confeiteiro');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Acucar Refinado Caravelas 1kg', '7896894900013', NULL, 'UNIDADE', 2.59, 4.99, 0, '17019900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896894900013');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Açucar Sachê', NULL, NULL, 'cx', 39.25, 0, 2, '17019900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Açucar Sachê');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ades de Uva 200ml', '7894900087130', NULL, 'UNIDADE', 2.1, 3.5, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900087130');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ades Laranja 1l', '7894900087048', NULL, 'UNIDADE', 6, 10, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900087048');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ades Laranja 200ml', '7894900087055', NULL, 'UNIDADE', 0, 3.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900087055');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ades Maça 1 litro', '7894900087062', NULL, 'UNIDADE', 6.09, 10, 1, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900087062');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ades Maça 200ml', '7894900087079', NULL, 'UNIDADE', 2.33, 3.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900087079');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ades Morango 200ml', '7894900087093', NULL, 'UNIDADE', 1.97, 3.75, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900087093');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ades Pêssego 200 ml', '7894900087116', NULL, 'UNIDADE', 1.89, 3.5, 0, '22029900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900087116');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ades Uva 1 Litro', '7894900087123', NULL, 'UNIDADE', 6, 10, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900087123');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional da Garrafa', '3074', '307400', 'UNIDADE', 0, 3, 0, '20091900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3074');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional de Arroz', '7070', '707000', 'UNIDADE', 0, 5, 0, '10063021', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7070');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional de Bacon', '8095', '809500', 'KG', 0, 5, 0, '16024900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8095');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional de Café', '777', '077700', 'UNIDADE', 0, 2, 0, '21011110', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '777');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional de calabresa', '8096', '809600', 'UNIDADE', 0, 5, 0, '21069090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8096');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional de Cigarro', '4023', '402300', 'UNIDADE', 0, 1, 0, NULL, 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4023');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional de Feijão', '7071', '707100', 'UNIDADE', 0, 5, 0, '07133399', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7071');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional de Frango', '262', '026200', 'UNIDADE', 0, 1, 0, '16023220', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '262');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional de Frios', '311', '031100', 'UNIDADE', 0, 1.5, 0, '19059090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '311');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional de Laranja', '3063', '306300', 'UNIDADE', 0, 5, 0, '20091900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3063');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional de Salada', '8094', '809400', 'UNIDADE', 0, 1.5, 0, '07069000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8094');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional de Salame', '504', '050400', 'KG', 0, 5, 0, '16010000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '504');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional de Salsicha', '307', '030700', 'UNIDADE', 0, 1.5, 0, '16010000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '307');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional Ovo', '483', '048300', 'UNIDADE', 0, 2.5, 0, '21069090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '483');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adicional Requeijão', '505', '050500', 'UNIDADE', 0, 2.5, 0, '04061090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '505');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adoçante Adocyl Sacarina 100ml', '7891104393104', NULL, 'UNIDADE', 4.49, 6, 0, '29054300', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891104393104');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Adocante zero cal 100ml', '7896094910904', NULL, 'UNIDADE', 6.69, 10.5, 0, '21069090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896094910904');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Água Cristal  510ml', '7898217480011', NULL, 'UNIDADE', 0.89, 3, 0, '22011000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898217480011');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Água Mineral S/ Gas Frescca 500ml', '7898386200083', NULL, 'UNIDADE', 0.99, 3, 0, '22011000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898386200083');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Agua Sanitaria Maximo 2l', '7898944352025', NULL, 'UNIDADE', 4.9, 7.35, 0, '28289011', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352025');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Água Serra Negra 1,5l', '7898368290132', NULL, 'UNIDADE', 1.8, 5, 0, '22011000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898368290132');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Agua Tonica Schweppes 350ml', '7894900300017', NULL, 'UNIDADE', 2.7, 6, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900300017');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'álcol 1 Litro', '602883061613', NULL, 'UNIDADE', 0, 10, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '602883061613');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Álcool + Bicarbonato', '7898917671498', NULL, 'UNIDADE', 0, 9, 0, '28363000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898917671498');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Alcool Coperalcool', '7896090703616', NULL, 'UNIDADE', 5.99, 9, 0, '38089419', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896090703616');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Álcool galão 5 litros', NULL, NULL, 'un', 6.07, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Álcool galão 5 litros');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Álcool Liquido 70% ECOFLAME 1 lItro', '0602883061613', NULL, 'UNIDADE', 6.48, 10, 0, '38089419', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '0602883061613');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Álcool Luar', '7898951180055', NULL, 'UNIDADE', 7.5, 10, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898951180055');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Alcool Tauipe 92º 500ml', '7898969948067', NULL, 'UNIDADE', 6.07, 9, 0, '22071090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898969948067');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Alcool Zumbi 1litro', '7896090704804', NULL, 'UNIDADE', 0, 14.4, 0, '22072019', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896090704804');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Alho Descascado', NULL, NULL, 'cx', 18.99, 0, 0, '07032090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Alho Descascado');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Almoço Bisteca', '218', '021800', 'UNIDADE', 0, 25, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '218');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Almoço Calabresa', '217', '021700', 'UNIDADE', 0, 25, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '217');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Almoço com Omelete', '7000', '700000', 'UNIDADE', 0, 25, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7000');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Almoço Contra File', '214', '021400', 'UNIDADE', 0, 25, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '214');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Almoço Costela com Batata', '4090', '409000', 'UNIDADE', 0, 28, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4090');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Almoço Feijoada', '250', '025000', 'UNIDADE', 0, 30, 0, '22029900', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '250');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Almoço File de Frango', '215', '021500', 'UNIDADE', 0, 25, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '215');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Almoço File de Peixe', '216', '021600', 'UNIDADE', 0, 28, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '216');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Almoço Frango Assado', '5090', '509000', 'UNIDADE', 0, 28, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '5090');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Almoço Toscana', '219', '021900', 'UNIDADE', 0, 25, 0, '21069090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '219');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Alpino Nestlé 280ml', '7891000067048', NULL, 'UNIDADE', 7.34, 11, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000067048');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Alpino Nestlé 80g', '7891000410707', NULL, 'UNIDADE', 7.27, 9.9, 0, '18063210', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000410707');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Amaciante Brisa de Verão Downy 350ml', '7500435252942', NULL, 'UNIDADE', 7.59, 11.4, 0, '38091010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7500435252942');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Amaciante URCA 2 Litros', '7896056404700', NULL, 'UNIDADE', 5.83, 10, 0, '38099190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896056404700');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Amendoins Torrado e Salgado Pettiz', '7896058599060', NULL, 'UNIDADE', 0, 3.5, 0, '20081100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896058599060');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Americano', '163', '016300', 'UNIDADE', 0, 15, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '163');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Amido de Milho Apti 200g', '7896327512615', NULL, 'UNIDADE', 2.58, 4, 0, '11081200', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896327512615');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ana Maria Baunilha 70g', '7896002362412', NULL, 'UNIDADE', 2.99, 4.25, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002362412');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ana Maria Chocolate 45g', '7896002301510', NULL, 'UNIDADE', 1.99, 3.75, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002301510');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ana Maria Duplo Chocolate 35g', '7896002302661', NULL, 'UNIDADE', 2.09, 3.75, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002302661');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ana Maria Gotas de Chocolate 35g', '7896002301497', NULL, 'UNIDADE', 1.99, 3.2, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002301497');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ana Maria Gotas de Chocolate 70gr', '7896002363259', NULL, 'UNIDADE', 2.99, 4.5, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002363259');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ana Maria Morango 70g', '7896002311823', NULL, 'UNIDADE', 2.99, 4.25, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002311823');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ana Maria Napolitano 42g', '7896002368230', NULL, 'UNIDADE', 1.99, 3.75, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002368230');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ana Maria Sabor Baunilha 35g', '7896002303781', NULL, 'UNIDADE', 1.99, 3.75, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002303781');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ana Maria Sabor Chocolate 42g', '7896002362054', NULL, 'UNIDADE', 1.95, 3.75, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002362054');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ana Maria Sabor Chocolate 70g', '7896002362436', NULL, 'UNIDADE', 2.99, 4.25, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002362436');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ana Maria Triplo Chocolate 70g', '7896002311830', NULL, 'UNIDADE', 2.99, 4.25, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002311830');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Arroz Biju T.1 1kg', '7893500020301', NULL, 'UNIDADE', 3.59, 8.5, 0, '10063021', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7893500020301');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Arroz Camil T1 1kilo', '7896006711117', NULL, 'UNIDADE', 3.85, 6.5, 0, '10063021', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896006711117');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Assolan 45g', '7896090100101', NULL, 'UNIDADE', 1.45, 3, 0, '73231000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896090100101');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Aveia em Flocos Apti 150g', '7896327501855', NULL, 'UNIDADE', 2.28, 4.99, 0, '11041200', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896327501855');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Aveia Flocos Finos Integral 165g', '7892840815769', NULL, 'UNIDADE', 4.99, 7.99, 0, '11041200', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840815769');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Avental Emborrachado', NULL, NULL, 'un', 12.47, 0, 1, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Avental Emborrachado');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'B 102', NULL, NULL, 'fardo', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'B 102');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'B1', NULL, NULL, 'FARDO', 46.8, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'B1');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Babbaloo Uva Unidade', '7895800002933', NULL, 'UNIDADE', 0.26, 0.5, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895800002933');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baboo Tubi 40gr', '7896513912120', NULL, 'UNIDADE', 0, 3, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912120');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bacon Bistecone 60g', '7898171341366', NULL, 'PACOTE', 0, 3.5, 0, '19059090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898171341366');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baguete de Calabresa', '1999', '199900', 'UNIDADE', 0, 15, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1999');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baguete de calabresa c/ catypiry', '9086', '908600', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9086');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baguete de Coco', '537', '053700', 'UNIDADE', 0, 10, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '537');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baguete de Frango', '5335', '533500', 'UNIDADE', 10, 15, 0, '16023220', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '5335');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baguete de Metro Frango', '4018', '401800', 'QUILOGRAMA', 0, 55, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4018');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baguete de metro peito de peru c/ queijo', '4019', '401900', 'UNIDADE', 0, 60, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4019');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baguete de metro queijo e presunto', '4022', '402200', 'UNIDADE', 0, 50, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4022');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baguete de Metro Salame', '905', '090500', 'UNIDADE', 0, 60, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '905');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baguete de Parmesão', '377', '037700', 'QUILOGRAMA', 0, 20, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '377');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baguete de Queijo e Presunto', '271', '027100', 'UNIDADE', 0, 15, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '271');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baguete Folhada', '396', '039600', 'UNIDADE', 0, 15, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '396');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baguete na Chapa', '454', '045400', 'UNIDADE', 0, 4.5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '454');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bala de Café', '7891151035293', NULL, 'UNIDADE', 0.1, 0.25, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891151035293');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Balas Diversas ', '102', '010200', 'UNIDADE', 0, 0.25, 0, '17049020', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '102');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Band-Aid', '75', '007500', 'UNIDADE', 0, 1, 0, '30051090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '75');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bandeija B1', NULL, NULL, 'fardo', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Bandeija B1');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Banoffe', '326', '032600', 'UNIDADE', 0, 12, 0, '19019090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '326');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BANOFFE TAMANHO G', '3014', '301400', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3014');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Batata Palha Amacroc 200g', '7898766840083', NULL, 'UNIDADE', 6.29, 9.5, 0, '20052000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898766840083');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Batata Palha Amavita 140gr', '7898931140543', NULL, 'UNIDADE', 12.38, 8.5, 0, '20052000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898931140543');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Batata Palha Amavita 80g', '7898931140512', NULL, 'UNIDADE', 4.49, 6, 0, '20052000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898931140512');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Batata Palha Extra Fina Raiz Bem 90g', '7898925211945', NULL, 'UNIDADE', 4.49, 6.99, 0, '20052000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898925211945');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Batata Palha Kisabor', '7898937864955', NULL, 'UNIDADE', 2.79, 4.5, 0, '20052000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898937864955');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Baton infantil', '6068', '606800', 'UNIDADE', 0, 0, 0, '18069000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6068');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bauru', '146', '014600', 'UNIDADE', 0, 14, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '146');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bauru Frio', '165', '016500', 'UNIDADE', 0, 14, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '165');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bebida Lactea 3 Corações Cappucino Classic 260ml', '7896005809518', NULL, 'UNIDADE', 6.45, 10, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005809518');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BEIJINHO', '374', '037400', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '374');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Beirute', '627', '062700', 'UNIDADE', 0, 13, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '627');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bic Grande', '070330909229', NULL, 'UNIDADE', 5.5, 8.5, 0, '96131000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '070330909229');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bic pequeno', '070330913431', NULL, 'UNIDADE', 3.94, 5.5, 0, '96131000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '070330913431');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BICHO DE PÉ', '451', '045100', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '451');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BIOCHEMICAL DESINFETANTE 5L CLEAN 40 HIBISCO', '7908185600424', NULL, 'UNIDADE', 122.69, 184.35, 0, '38089419', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908185600424');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BIOCHEMICAL DETERGENTE CLORADO 5L BIOCLOREGEL', '7908185601575', NULL, 'UNIDADE', 110.56, 165.84, 0, '34022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908185601575');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biomalte', NULL, NULL, 'KG', 9.5, 0, 1, '19019090', 'normal', 'revenda', NULL, 1, 0, 0, 190, 20, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Biomalte');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bis Extra Branco', '7622210534576', NULL, 'UNIDADE', 2.99, 4, 0, '19053200', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210534576');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bis Laka', NULL, NULL, 'UNIDADE', 6.62, 0, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Bis Laka');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biscoitinho de goiaba', '7898070347889', NULL, 'UNIDADE', 0, 7.5, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898070347889');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biscoito 7 Capas Sao Benedito 300g', '7897053100077', NULL, 'UNIDADE', 8.5, 11.5, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897053100077');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biscoito Amanteigado Jota', '1132', '113200', 'QUILOGRAMA', 8, 30, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1132');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biscoito Bolinha com Goiabada 160g', '7898070347865', NULL, 'UNIDADE', 5.75, 7.5, 0, '19023000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898070347865');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biscoito Casadinho de Goiabada 160g', '7898070347872', NULL, 'UNIDADE', 5.75, 7.5, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898070347872');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biscoito Coquinho Prodasa 400g', '7896486202884', NULL, 'UNIDADE', 3.89, 7, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896486202884');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biscoito Juju 170g', '7898070347841', NULL, 'UNIDADE', 5.98, 8.5, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898070347841');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biscoito Maizena Leite Vitarella 350g', '7896213006426', NULL, 'UNIDADE', 6.3, 8.5, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896213006426');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biscoito Palito de Chocolate 170g', '7898070347858', NULL, 'UNIDADE', 5.75, 7.8, 0, '20052000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898070347858');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biscoito Pao de Mel 130g', '7898070347834', NULL, 'UNIDADE', 5.98, 7, 0, '20052000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898070347834');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biscoito Rosca de Coco 130g', '7898070347896', NULL, 'UNIDADE', 4.89, 7.5, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898070347896');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biscoito rosca de nata 130g', '7898070347827', NULL, 'UNIDADE', 4.89, 7.5, 0, '19053100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898070347827');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biscoito Uga Uga 130g', '789807347797', NULL, 'UNIDADE', 4.85, 7.5, 0, '19053100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '789807347797');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Biscoitone ', '7898171341090', NULL, 'PACOTE', 0, 3.5, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898171341090');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bisnaguito Pulmann 300g', '7896002360234', NULL, 'UNIDADE', 7.02, 10.5, 0, '19059090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002360234');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bisteca', NULL, NULL, 'kg', 15.99, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Bisteca');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Black cigarro solto', '5333', '533300', 'UNIDADE', 0, 0, 0, '24022000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '5333');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Black Kretek Menthol SOLTO', '06', '000600', 'UNIDADE', 0, 0, 0, '24022000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '06');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha Agua e Sal Vitarella 350g', '7896213006242', NULL, 'UNIDADE', 5.39, 7.99, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896213006242');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha Bono Chocolate 90gr', '7891000376843', NULL, 'UNIDADE', 2.23, 3.5, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000376843');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha Bono Doce de Leite 90gr', '7891000376928', NULL, 'UNIDADE', 1.74, 3.5, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000376928');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha Bono Mini 24g', '7891000452165', NULL, 'UNIDADE', 0.9, 1.99, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000452165');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha Bono Morango 90gr', '7891000376959', NULL, 'UNIDADE', 2.46, 3.5, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000376959');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha Cream Cracker Marilan 300g', '7896003738612', NULL, 'UNIDADE', 4.39, 7.5, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896003738612');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha de Água e Sal Mabel 300g', '7896071030069', NULL, 'UNIDADE', 4.39, 6.75, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896071030069');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha de Agua e Sal Marilan 300g', '7896003740189', NULL, 'UNIDADE', 5.98, 8.99, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896003740189');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha de Leite Marilan 300g', '7896003740240', NULL, 'UNIDADE', 4.39, 8.5, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896003740240');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha Negresco 90gr', '7891000376768', NULL, 'UNIDADE', 2.24, 3, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000376768');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha Passatempo Leite 150g', '7891000051436', NULL, 'UNIDADE', 2.88, 1.99, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000051436');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha Plugados Leite C/ Chocolate 130gr', '7896085076183', NULL, 'UNIDADE', 2.29, 2.5, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896085076183');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha Plugados Rodonda Sabor Chocolate 120g', '7896085087417', NULL, 'UNIDADE', 2.29, 4, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896085087417');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolacha Plugados Rodonda Sabor Morango 120g', '7896085087424', NULL, 'UNIDADE', 2.15, 4, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896085087424');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'bolachao amanteigado', '3900', '390000', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3900');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolachão Doce', '431', '043100', 'QUILOGRAMA', 0, 20, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '431');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolachao Salgado', '42', '004200', 'UNIDADE', 0, 20, 0, '19021900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '42');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolinha de Queijo', '1900', '190000', 'UNIDADE', 0, 8, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1900');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'bolo banofe', '441', '044100', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '441');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo C/ Pudim', '4009', '400900', 'UNIDADE', 0, 16, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4009');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'bolo confeitado', '274', '027400', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '274');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Abacaxi', '484', '048400', 'QUILOGRAMA', 20, 27.99, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '484');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Aipim', '336', '033600', 'QUILOGRAMA', 0, 25, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '336');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Banana C/canela', '527', '052700', 'QUILOGRAMA', 0, 32, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '527');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Baunilha', '394', '039400', 'QUILOGRAMA', 0, 27.99, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '394');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Cenoura', '390', '039000', 'QUILOGRAMA', 0, 27.99, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '390');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Cenoura C/ Goiabada', '601', '060100', 'QUILOGRAMA', 0, 32, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '601');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Cenoura com Cobertura', '442', '044200', 'QUILOGRAMA', 0, 32, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '442');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Chocolate', '1010', '101000', 'QUILOGRAMA', 0, 32, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1010');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Chocolate C/ Cobertura', '391', '039100', 'QUILOGRAMA', 0, 32, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '391');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Chocolate Fatia', '338', '033800', 'UNIDADE', 0, 10, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '338');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Chocolate Pullman 250g', '7896002361019', NULL, 'UNIDADE', 7.49, 12, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002361019');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de churros c/ cobertura', '9096', '909600', 'QUILOGRAMA', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9096');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Coco', '8001', '800100', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BOLO DE COCO C/ COBERTURA', '8070', '807000', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 4, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8070');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de frutas vermelhas c/ cobertura', '8901', '890100', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8901');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Fubá', '389', '038900', 'kg', 3.49, 27.99, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '389');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Fuba C Goiabada', '1911', '191100', 'UNIDADE', 0, 32, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1911');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de fuba c/ coco', '1118', '111800', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1118');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Gotas de Chocolate Pullman 250g', '7896002362146', NULL, 'UNIDADE', 8.46, 12, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002362146');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Laranja', '393', '039300', 'UNIDADE', 0, 27.99, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '393');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Laranja Pullman 250g', '7896002361033', NULL, 'UNIDADE', 8.46, 12, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002361033');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Limao', '534', '053400', 'QUILOGRAMA', 0, 25, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '534');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Limao C/ Cobertura', '3030', '303000', 'QUILOGRAMA', 0, 30, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3030');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Milho', '567', '056700', 'QUILOGRAMA', 0, 27.99, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '567');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de milho c/ cobertura', '8900', '890000', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8900');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Pamonha C/ Cobertura de Milho', '9055', '905500', 'QUILOGRAMA', 0, 27.99, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9055');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Pote Choconinho', '2008', '200800', 'UNIDADE', 0, 10, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '2008');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Pote de Brigadeiro', '3047', '304700', 'UNIDADE', 0, 10, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3047');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Pote Doce de Leite', '1533', '153300', 'UNIDADE', 0, 10, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1533');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BOLO DE POTE DOCE DE LEITE C/COCO', '3046', '304600', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3046');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Pote Ninho', '2007', '200700', 'UNIDADE', 0, 10, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '2007');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BOLO DE POTE PRESTIGIO', '3045', '304500', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3045');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Pote Sensaçao', '430', '043000', 'UNIDADE', 0, 10, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '430');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo de Queijadinha', '110', '011000', 'KG', 0, 27.99, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '110');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BOLO DECORADO MASSA BRANCA', '603', '060300', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '603');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BOLO DECORADO MASSA DE CHOCOLATE', '604', '060400', 'QUILOGRAMA', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '604');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BOLO DECORADO TRUFADO', '605', '060500', 'QUILOGRAMA', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '605');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo Frapê Pullman 250gr', '7896002360982', NULL, 'UNIDADE', 7.49, 9.99, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002360982');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BOLO INTEGRAL', '480', '048000', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '480');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo Neutro Grano Nicoletti', NULL, NULL, 'pct', 49.86, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Bolo Neutro Grano Nicoletti');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo Pedaço Cenoura C/chocolate', '1002', '100200', 'UNIDADE', 0, 8, 0, '02071419', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1002');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo Pudim', '530', '053000', 'QUILOGRAMA', 0, 27.99, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '530');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo Quebra Queixo', '1004', '100400', 'CAIXA', 4, 6, 0, '02071419', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1004');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolo Romeu e Julieta', '349', '034900', 'QUILOGRAMA', 0, 35, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '349');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bolsa com elástico', '7089', '708900', 'UNIDADE', 0, 0, 0, '42022210', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7089');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bomba de Chocolate', '610', '061000', 'UNIDADE', 0, 6, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '610');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BOMBOM NA TRAVESSA TAMANHO G', '3013', '301300', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3013');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Bombril 6 Unid 45g', '7891022868036', NULL, 'UNIDADE', 1.75, 4, 0, '73231000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891022868036');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BR 02', NULL, NULL, 'fardo', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'BR 02');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BRIGADEIRAO', '8010', '801000', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8010');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Brigadeiro', '17', '001700', 'UNIDADE', 0, 3, 0, '19019090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '17');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'BRIGADEIRO DE LEITE NINHO C/CHOCOLATE', '3080', '308000', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3080');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Broa de chocolate', '447', '044700', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '447');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Broa de Fubá', '387', '038700', 'UNIDADE', 0, 3, 0, '19021900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '387');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'broa de fubá com goiabada', '474', '047400', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '474');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Brócolis Florete 1 KG APETITO', NULL, NULL, 'UNIDADE', 0, 9.19, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Brócolis Florete 1 KG APETITO');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Brownie', '330', '033000', 'UNIDADE', 0, 6, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '330');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Budweiser 269ml', '7891991011877', NULL, 'UNIDADE', 2.55, 5, 0, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991011877');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café', '998', '099800', 'KG', 0, 95, 0, '09012100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '998');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café Brasileiro Extraforte 250g', '7891018427599', NULL, 'UNIDADE', 9.95, 20.5, 0, '09012100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891018427599');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café Brasileiro Tradicional 250g', '7891018427582', NULL, 'UNIDADE', 11.03, 19.5, 0, '09012100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891018427582');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café Brasileiro Tradicional 500g', '7891018001386', NULL, 'UNIDADE', 18.5, 30, 0, '09012100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891018001386');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café Caboclo Tradicional 250g', '7896089011203', NULL, 'UNIDADE', 13.45, 20, 0, '09012100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896089011203');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café Caboclo Tradicional 500g', '7896089010916', NULL, 'UNIDADE', 19.9, 35, 0, '09012100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896089010916');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café Cappuccino 3 Corações Clássico 200g', '7896005800157', NULL, 'UNIDADE', 14, 20, 0, '21011200', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005800157');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café Cappuccino 3 Corações Sachê 20gr', '7896005802373', NULL, 'UNIDADE', 1.77, 3, 0, '21011200', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005802373');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cafe Coado Grande', '189', '018900', 'UNIDADE', 0, 6, 0, '21011200', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '189');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café Coado Pequeno', '187', '018700', 'UNIDADE', 0, 4, 0, '09012100', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '187');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café com Leite G', '194', '019400', 'UNIDADE', 0, 6, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '194');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café Expresso G', '191', '019100', 'UNIDADE', 0, 8, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '191');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café Expresso P', '190', '019000', 'UNIDADE', 0, 6, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '190');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café Extra Forte 3 Corações 250g', '7896005801512', NULL, 'UNIDADE', 11.95, 20, 0, '09012100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005801512');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café Pilão Tradicional 250g', '7896089011982', NULL, 'UNIDADE', 15.45, 21.9, 0, '09012100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896089011982');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café Pilão Tradicional 500g', '7896089012019', NULL, 'UNIDADE', 29.89, 37, 0, '09012100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896089012019');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café Solúvel Brasileiro', '7891018427766', NULL, 'UNIDADE', 4.28, 7, 0, '21011110', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891018427766');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Café UNIÃO tradicional 500g', '7891910030347', NULL, 'UNIDADE', 18.9, 29.5, 0, '09012100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891910030347');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Caixa de Bombom Nestle 220g', '7891000457467', NULL, 'UNIDADE', 9.79, 14.99, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000457467');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'caixa de fosforo pequeno', '475', '047500', 'UNIDADE', 0, 0, 0, '09096110', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '475');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Calabresa Reta', NULL, NULL, 'cx', 0, 0, 0, '16010000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Calabresa Reta');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Calda Caramelizada', NULL, NULL, 'kg', 109.85, 0, 1, '17029000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Calda Caramelizada');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Caldo de Galinha', NULL, NULL, 'KG', 11.7, 0, 0, '21041011', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Caldo de Galinha');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Caldo de Galinha Maggi 57g', '7891000250174', NULL, 'UNIDADE', 1.95, 3.5, 0, '21041011', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000250174');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Caldo de galinha Qualimax 1,01kg', '7891122123486', NULL, 'PEÇA', 12.9, 0, 0, '21041019', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891122123486');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Canela em Pó', NULL, NULL, 'pct', 16.8, 0, 1, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Canela em Pó');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Canoa de Frango', '997', '099700', 'UNIDADE', 0, 12, 0, '44219900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '997');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Capuccino', '203', '020300', 'UNIDADE', 0, 8, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '203');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Capuccino Chocolate 260ml 3 Corações', '7896005809501', NULL, 'UNIDADE', 6.45, 10, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005809501');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cara', '381', '038100', 'UNIDADE', 0, 1, 0, '07149000', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '381');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cara C/ Manteiga', '248', '024800', 'UNIDADE', 0, 3, 0, '19023000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '248');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cara C/ Manteiga na Chapa', '249', '024900', 'UNIDADE', 0, 3, 0, '19023000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '249');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cara na Chapa', '457', '045700', 'UNIDADE', 0, 3, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '457');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'cara navemestra', '423', '042300', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '423');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Caribe 28g', '7891008121193', NULL, 'UNIDADE', 0, 3.7, 0, '18063210', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891008121193');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Carolina', '461', '046100', 'QUILOGRAMA', 0, 50, 0, '19019090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '461');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'CATARINA', '448', '044800', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '448');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'catarina de banana', '494', '049400', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '494');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Catchup D´lanche 200g', '7898946867077', NULL, 'UNIDADE', 2.29, 3.5, 0, '02012020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898946867077');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'CENTO DE DOCINHO', '4446', '444600', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4446');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cento de Salgado Crú', '900', '090000', 'UNIDADE', 0, 74.99, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '900');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cento de Salgado Frito', '901', '090100', 'UNIDADE', 0, 80, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '901');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cerpa 350ml', '7896388010556', NULL, 'UNIDADE', 0, 4, 0, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896388010556');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cerveja Eisenbahn Pilsen 269ml', '7898367984285', NULL, 'UNIDADE', 2.25, 4.5, 0, '22030000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898367984285');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chá', '195', '019500', 'UNIDADE', 0, 4, 0, '09021000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '195');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chá Camomila Leão 10g', '7891098000163', NULL, 'UNIDADE', 6.98, 6, 0, '12119090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891098000163');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chá de Hortelã', '7891048038055', NULL, 'UNIDADE', 2.71, 5.8, 0, '09022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891048038055');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chá de Hortelã Leão', '7891098000170', NULL, 'UNIDADE', 3.65, 5, 0, '09021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891098000170');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chá Leão Camomila C/ 15 Sachê 15g', '7891098010575', NULL, 'UNIDADE', 7.98, 11.5, 0, '21012010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891098010575');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cha Matte Leao C/ 25 Sachê Original 40g', '7891098000040', NULL, 'UNIDADE', 4.89, 9.5, 0, '09030090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891098000040');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chá Matte Leão Caixa 250g', '7891098038456', NULL, 'UNIDADE', 9.48, 12.99, 0, '09030090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891098038456');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chá Matte Leão Limão 30g', '7891098000057', NULL, 'PEÇA', 6.99, 10.5, 0, '09030090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891098000057');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chá Médio', '195', '019500', 'UNIDADE', 0, 6, 0, '09021000', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '195');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chapinha', '6070', '607000', 'UNIDADE', 0, 0, 0, '85163200', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6070');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chaveiro de urso un', '7083', '708300', 'UNIDADE', 0, 0, 0, '73269090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7083');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chaveiro divertidamente', '6062', '606200', 'UNIDADE', 0, 0, 0, '73269090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6062');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cheddar 1,2 kg Top Cheddar', NULL, NULL, 'kg', 14.65, 0, 1, '04061090', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Cheddar 1,2 kg Top Cheddar');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chesterfield original blue', '78937680', NULL, 'UNIDADE', 11.7, 12.25, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78937680');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chesterfield original label', '78939424', NULL, 'UNIDADE', 11.73, 15, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78939424');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chesterfield remix beats', '78942660', NULL, 'UNIDADE', 12.46, 13.5, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78942660');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chesterfield Remix Fresh e Mint', '78946675', NULL, 'UNIDADE', 0, 10, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78946675');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chesterfield remix wild roxo', '78938380', NULL, 'UNIDADE', 0, 13.5, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78938380');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Choco Tubi Kascão', '7896513912113', NULL, 'UNIDADE', 0, 2.25, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912113');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocobiscuit Cocolate Nestle 78g', '7891000402979', NULL, 'UNIDADE', 4.42, 8.5, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000402979');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate ao Leite 80g', '7891000369098', NULL, 'UNIDADE', 5.5, 10.5, 0, '18063210', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000369098');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate Ao Leite Lacta 28g', '7622202258459', NULL, 'UNIDADE', 3.35, 4.75, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622202258459');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate Branco Lacta 28g', '7622202256721', NULL, 'CAIXA', 3.35, 4.75, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622202256721');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate Branco Laka Lacta 50,1g', '7622202274619', NULL, 'UNIDADE', 4.75, 7, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622202274619');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate Charge 40g', '7891000464908', NULL, 'UNIDADE', 2.5, 3.6, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000464908');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate Chokito 32g', '7891000462300', NULL, 'UNIDADE', 2.5, 3.5, 0, '18063120', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000462300');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate Granulado Mavalerio 150gr', '7896072646733', NULL, 'UNIDADE', 2.59, 5.3, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896072646733');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate Kit Kat Ao Leite', '7891000248768', NULL, 'UNIDADE', 3.6, 5, 0, '19053200', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000248768');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate Kit Kat Branco', '7891000249239', NULL, 'UNIDADE', 3.58, 5, 0, '19053200', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000249239');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate M&ms 40g', '7896423438727', NULL, 'UNIDADE', 2.99, 4.8, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896423438727');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate Milkas Kascão 55gr', '7896513912151', NULL, 'UNIDADE', 3.83, 6, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912151');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate Snickers Branco 42g', '7896423488883', NULL, 'UNIDADE', 2.99, 4.5, 0, '17049010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896423488883');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate Snickers Dark 42g', '7896423439014', NULL, 'UNIDADE', 2.99, 4.5, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896423439014');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolate Suflair Nestlé 50g', '7891000107836', NULL, 'UNIDADE', 5.7, 7, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000107836');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocolater Snickers Pé de Moleque 42g', '7896423497984', NULL, 'UNIDADE', 2.99, 4.5, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896423497984');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocostick Avelã Nestlé 26g', '7891000477410', NULL, 'UNIDADE', 2.3, 3.45, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000477410');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocostick Baton e Caribe 24g', '7891000476475', NULL, 'UNIDADE', 2.3, 3.45, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000476475');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocotone', '520', '052000', 'UNIDADE', 0, 16, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '520');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'CHOCOTONE C/ COBERTURA', '8091', '809100', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8091');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocotrio Barra Sabor Avelã Nestle 90g', '7891000422083', NULL, 'UNIDADE', 7.68, 11.5, 0, '18063210', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000422083');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Chocotrio Nestle Ao Leite 90g', '7891000377543', NULL, 'UNIDADE', 7.68, 10.5, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000377543');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cigarro Solto 0,50', '120', '012000', 'CAIXA', 0, 0.5, 0, '24022000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '120');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cigarro Solto de 0,30', '119', '011900', 'CAIXA', 0, 0.3, 0, '24022000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '119');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cigarro Solto de 1,00', '121', '012100', 'CAIXA', 0, 1, 0, '24022000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '121');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cloro Hipoclorito 1l', '7898944352100', NULL, 'un', 4.24, 6.3, 0, '28289011', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352100');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cloro hipoclorito 2L', '7898944352117', NULL, 'UNIDADE', 7.95, 11.9, 0, '28289011', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352117');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cloro Máximo 1 litro', '7898944352100', NULL, 'UNIDADE', 4.24, 6.3, 0, '28289011', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352100');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cloro Máximo 5 Litros', '7898944352124', NULL, 'UNIDADE', 18.5, 20, 0, '28289011', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352124');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Club Social Original 144g', '7622300990701', NULL, 'UNIDADE', 5.02, 7.5, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622300990701');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Club Social Presunto 141g', '7622210641632', NULL, 'UNIDADE', 0, 8.5, 0, '19059020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210641632');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Club Social Recheada Queijo, Tomate e Manjeiricão 106g', '7622210661609', NULL, 'UNIDADE', 5, 8, 0, '19059020', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210661609');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coador 102 BRIGITTA', '7891021002103', NULL, 'UNIDADE', 0, 5, 0, '63079090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891021002103');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca 1 Litro', '7894900015119', NULL, 'UNIDADE', 0, 8, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900015119');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola 2 Litros', '7894900027013', NULL, 'UNIDADE', 10.59, 16, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900027013');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca cola 2 litros Zero', '7894900701517', NULL, 'UNIDADE', 0, 15, 1, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900701517');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola 350 ml', '7894900010015', NULL, 'UNIDADE', 2.88, 6, 1, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900010015');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola 600ml', '7894900011609', NULL, 'UNIDADE', 4.42, 8, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900011609');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola Caçulinha 200ml', '78908901', NULL, 'UNIDADE', 1.49, 3, 1, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78908901');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola Café 220ml', '7894900025019', NULL, 'UNIDADE', 1.72, 3.5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900025019');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola Ks', '138', '013800', 'UNIDADE', 2.25, 5, 0, '22021000', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '138');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola Lata 220ml', '7894900010398', NULL, 'UNIDADE', 1.75, 3.5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900010398');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola Lata 350ml', '7894900010015', NULL, 'UNIDADE', 3, 6, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900010015');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coca Cola Ret 2 Litros', '7894900014211', NULL, 'UNIDADE', 6.1, 10, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900014211');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cocada ', '23', '002300', 'UNIDADE', 0, 10, 0, '19021900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '23');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coco ralado DuCoco 100g', '7896016601217', NULL, 'UNIDADE', 3.99, 5, 0, '08011100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896016601217');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coco Ralado Fino 5 quilos', NULL, NULL, 'KG', 109.78, 0, 0, '08011100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Coco Ralado Fino 5 quilos');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coco Ralado Flocos 5 quilos', NULL, NULL, 'KG', 160, 0, 0, '08011100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Coco Ralado Flocos 5 quilos');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coco Ralado Mais Coco 50g', '7896004401058', NULL, 'UNIDADE', 3.44, 5.99, 0, '08011100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896004401058');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coco Ralado Menina 50gr', '7896028030661', NULL, 'UNIDADE', 2.99, 3.8, 0, '08011100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896028030661');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Colher de Sobremesa', NULL, NULL, 'cx', 45.9, 0, 0, '39241000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Colher de Sobremesa');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Colher descartável', NULL, NULL, 'cx', 0, 0, 0, '39241000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Colher descartável');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'COLOMBA PASCOAL', '521', '052100', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '521');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Colorau', NULL, NULL, 'KG', 9.9, 0, 0, '09109900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Colorau');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Composto Todo Dia Itambé 400g', '7896051168720', NULL, 'UNIDADE', 9.9, 14.85, 0, '19011010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896051168720');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'CONTRA FILE C/SALADA', '1800', '180000', 'UNIDADE', 0, 0, 0, '02013000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1800');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Contra Filet', NULL, NULL, 'cx', 0, 0, 0, '02013000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Contra Filet');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cookie Gotas de Chocolate 60g', '7891000247648', NULL, 'UNIDADE', 1.94, 3.8, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000247648');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cookies Alpino Nestlé 60g', '7891000350119', NULL, 'UNIDADE', 2.09, 3.6, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000350119');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cookies Prestigio Nestle 60g', '7891000339237', NULL, 'UNIDADE', 1.98, 3.8, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000339237');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Copão Alegria Kascao Morango C/ Leite Condensado 150g', '7896513940048', NULL, 'UNIDADE', 6.95, 10.5, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513940048');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Copão Alegria Milho Verde 150gr', '7896513940239', NULL, 'UNIDADE', 0, 10.5, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513940239');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Copo 180 ml', NULL, NULL, 'CAIXA', 96, 0, 0, '39241000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Copo 180 ml');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Copo da Felicidade', '625', '062500', 'UNIDADE', 0, 12, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '625');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Copo de Isopor  180ml', NULL, NULL, 'fardo', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Copo de Isopor  180ml');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Copo de Isopor  240ml', NULL, NULL, 'cx', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Copo de Isopor  240ml');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Copo de Isopor 120ml', NULL, NULL, 'fardo', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Copo de Isopor 120ml');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Copo Descartável 400ml', NULL, NULL, 'fardo', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Copo Descartável 400ml');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coraçãzinho 45g Cascão', '7896513912588', NULL, 'UNIDADE', 0, 7, 0, '21050010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912588');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Costela de Adão', '8100', '810000', 'UNIDADE', 0, 12, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8100');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cotonela', '7898916237015', NULL, 'CAIXA', 1.39, 3.8, 0, '56012190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898916237015');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cotonetes', '7896227621059', NULL, 'UNIDADE', 5.25, 10.5, 0, '56012190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896227621059');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coxinha', '40', '004000', 'UNIDADE', 0, 8, 0, '02071300', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '40');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Coxinha com Catupiry', '9090', '909000', 'UNIDADE', 0, 10, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9090');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'COXINHA DE BRIGADEIRO', '2009', '200900', 'UNIDADE', 0, 0, 0, '18069000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '2009');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'COXINHA DE CHARGE', '1988', '198800', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1988');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'COXINHA DE COSTELA', '3068', '306800', 'UNIDADE', 0, 0, 0, '19022000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3068');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'COXINHA DE NINHO', '1987', '198700', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1987');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Creme de leite 200g', '7891000126905', NULL, 'UNIDADE', 3.29, 5, 0, '04015021', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000126905');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Creme de Leite Piracanjuba 200g', '7898215151784', NULL, 'UNIDADE', 2.49, 4, 0, '04015021', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898215151784');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Creme Dental Colgate 50g', '7891024132906', NULL, 'UNIDADE', 3.05, 4.5, 0, '33061000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891024132906');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Creme Dental Colgate 90g', '7891024132128', NULL, 'UNIDADE', 4.79, 7.5, 0, '33061000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891024132128');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Creme Dental Colgate Calci-Protect 90g', '7891024134702', NULL, 'UNIDADE', 4.79, 6, 0, '33061000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891024134702');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Creme Dental Even 70g', '7896013106951', NULL, 'UNIDADE', 1.49, 3, 0, '33061000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896013106951');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Creme Dental Sorriso Tripla Ação 70g', '7891528029498', NULL, 'UNIDADE', 1.99, 3.5, 0, '33061000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891528029498');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Crepioca de Frango', '8011', '801100', 'UNIDADE', 0, 18, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8011');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Crepioca de Peito de Peru', '8009', '800900', 'UNIDADE', 0, 15, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8009');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Crepioca simples', '8007', '800700', 'UNIDADE', 0, 0, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8007');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Crocante Chocolate 25g', '7891008124583', NULL, 'UNIDADE', 4.69, 3.5, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891008124583');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Croissant de Goiabada', '398', '039800', 'QUILOGRAMA', 0, 30, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '398');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Croissant Empresa', '223', '022300', 'QUILOGRAMA', 0, 31, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '223');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Croissant Goiabada', '270', '027000', 'QUILOGRAMA', 0, 30, 0, '21069050', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '270');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Croissant Variado', '27', '002700', 'KG', 0, 29.99, 0, '12019000', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '27');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cuca de Banana', '332', '033200', 'UNIDADE', 0, 27, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '332');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Cup Noodles Costela C/ Churrasco 68g', '7891079013083', NULL, 'UNIDADE', 5.29, 8, 0, '19023000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891079013083');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'CUPCAKE DE  BRIGADEIRO', '4011', '401100', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4011');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'CUPCAKE DE DOCE DE LEITE', '4010', '401000', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4010');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'CUPCAKE DE LEITE NINHO', '4014', '401400', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4014');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'CURAL', '540', '054000', 'UNIDADE', 0, 0, 0, '19019090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '540');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle 1 Litro Abacaxi', '7894900660364', NULL, 'UNIDADE', 7.92, 12.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900660364');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Frutas Citricas 450ml', '7894900666502', NULL, 'UNIDADE', 2.81, 5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900666502');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del valle kapo laranja 200ml', '7894900563702', NULL, 'UNIDADE', 2.17, 3.75, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900563702');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Kapo Maracujá 200ml', '7894900573701', NULL, 'UNIDADE', 2.38, 3.75, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900573701');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Kapo Morango 200ml', '7894900583700', NULL, 'UNIDADE', 2.12, 3.75, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900583700');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Kapo Uva 200ml', '7894900593709', NULL, 'UNIDADE', 2.38, 3.75, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900593709');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Laranja 450ml', '7894900556056', NULL, 'UNIDADE', 2.81, 5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900556056');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Laranja Pet 1l', '7894900556032', NULL, 'UNIDADE', 3.91, 7, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900556032');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Lata Maracuja 290ml', '7894900660302', NULL, 'UNIDADE', 3.56, 5.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900660302');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Lata Uva 290ml', '7894900660333', NULL, 'UNIDADE', 3.56, 5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900660333');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Manga 1 Litro', '7894900660357', NULL, 'UNIDADE', 7.62, 12.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900660357');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Maracuja 1 Litro', '7898341430074', NULL, 'UNIDADE', 7.92, 12.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898341430074');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Pessego 1 Litro', '7898341430036', NULL, 'UNIDADE', 7.92, 12.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898341430036');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del valle sabor laranja 200ml', '7894900660418', NULL, 'UNIDADE', 1.82, 3.5, 0, '22029900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900660418');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Uva 1 Litro', '7898341430098', NULL, 'UNIDADE', 7.92, 12.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898341430098');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle uva 200ml', '7894900660432', NULL, 'UNIDADE', 2.47, 3.7, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900660432');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Del Valle Uva 450ml', '7894900550054', NULL, 'UNIDADE', 2.81, 5.5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900550054');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desinfetante Maximo Baby Clean 2l', '7898944352193', NULL, 'UNIDADE', 4.19, 6, 0, '38089419', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352193');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desinfetante Maximo Citrus 2l', '7898944352179', NULL, 'UNIDADE', 4.19, 6, 0, '38089419', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352179');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desinfetante Maximo Eucalipito 2l', '7898944352315', NULL, 'UNIDADE', 4.19, 6, 0, '38089419', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352315');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desinfetante Maximo Floral 2l', '7898944352292', NULL, 'UNIDADE', 4.19, 6, 0, '38089419', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352292');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desinfetante Maximo Max Clean 2l', '7898944352209', NULL, 'UNIDADE', 4.19, 6, 0, '38089419', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352209');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desinfetante Maximo Primavera 2l', '7898944352384', NULL, 'UNIDADE', 4.19, 6, 0, '38089419', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352384');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desodorante Aerosol Giovanna baby 150ml', '7896044936923', NULL, 'UNIDADE', 10.9, 15.5, 0, '33072010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896044936923');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desodorante Aerosol Monange Flor de Lavanda 150ml', '7891350034622', NULL, 'UNIDADE', 9.89, 14.5, 0, '33072010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891350034622');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desodorante Aerosol Monange Invisível 150ml', '7898919411900', NULL, 'UNIDADE', 9.89, 14.5, 0, '33072010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898919411900');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desodorante Aerosol Monnge Frutas Vermelhas 150ml', '7891350034639', NULL, 'UNIDADE', 9.89, 14.5, 0, '33072010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891350034639');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desodorante em Creme Herbissimo Hibisco 55g', '7896049525726', NULL, 'UNIDADE', 5.29, 10, 0, '33072090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896049525726');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desodorante em creme Tabu 55g', '7896049508514', NULL, 'UNIDADE', 4.99, 7.5, 0, '33072090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896049508514');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desodorante Herbissimo Fresh 55g', '7896049528604', NULL, 'UNIDADE', 5.29, 10, 0, '33072090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896049528604');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desodorante Herbissimo Sensitive 55g', '7896049528567', NULL, 'UNIDADE', 5.29, 10, 0, '33072090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896049528567');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desodorante herbissimo talco 55g', '7896049528536', NULL, 'UNIDADE', 6.99, 10, 0, '33072090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896049528536');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desodorante Roll-On Love Intense Skala 60ml', '7897042010455', NULL, 'UNIDADE', 4.59, 6.9, 0, '33072010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897042010455');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Desodorante Skala Invisible 60ml', '7897042012039', NULL, 'UNIDADE', 4.25, 8.5, 0, '33072010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897042012039');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Detergente Limão Limpol 500ml', '7891022637007', NULL, 'UNIDADE', 2.35, 3.5, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891022637007');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Detergente Liquido Maça Limpol', '7891022639001', NULL, 'UNIDADE', 0, 3.15, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891022639001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Detergente Minuano Clean 500ml', '7897664130043', NULL, 'UNIDADE', 1.95, 3, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897664130043');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Detergente Minuano Neutro 500ml', '7897664130036', NULL, 'UNIDADE', 1.95, 3, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897664130036');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Detergente Neutro Ype 500ml', '7896098900208', NULL, 'UNIDADE', 2.09, 2.99, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896098900208');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Diamante Negro Lact 34gr', '7622210573322', NULL, 'UNIDADE', 0, 4, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210573322');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Dipirona', '114', '011400', 'UNIDADE', 0, 1, 0, '30049069', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '114');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Diploko Dipper Oceano 30g', '7898754690751', NULL, 'UNIDADE', 4.99, 7.5, 0, '17041000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898754690751');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Dobradinha', '468', '046800', 'UNIDADE', 0, 30, 0, '02061000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '468');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Doce de abobora unidade', '144', '014400', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '144');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Dolly Guaraná 2l', '7896462300115', NULL, 'UNIDADE', 4.25, 4.99, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896462300115');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Dolly Limão 2l', '7896462300139', NULL, 'UNIDADE', 4.25, 7, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896462300139');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Dorflex Unidade', '113', '011300', 'UNIDADE', 0.52, 1, 0, '30049069', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '113');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'DORITOS SWEET CHILLI 120G', '7892840822729', NULL, 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840822729');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'dose de 51', '419', '041900', 'UNIDADE', 0, 0, 0, '22084000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '419');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Dose de Conhaque/pinga', '264', '026400', 'UNIDADE', 0, 5, 0, '30049029', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '264');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Dose de Whisky', '265', '026500', 'UNIDADE', 0, 8, 0, '30049029', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '265');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'DOSE DE WHISKY OLD EIGHT', '437', '043700', 'UNIDADE', 0, 0, 0, '30049029', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '437');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'dose são joão da barra', '415', '041500', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '415');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Dreher Dose', '416', '041600', 'UNIDADE', 0, 5, 0, '22082000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '416');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Dunhill Carlton blend', '78947467', NULL, 'UNIDADE', 13.62, 17.25, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947467');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Dunhill Carlton blue', '78947474', NULL, 'UNIDADE', 13.62, 17.25, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947474');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Dunhill Insignia Blue', '78947542', NULL, 'UNIDADE', 11.31, 15.5, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947542');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Dunuts', '620', '062000', 'UNIDADE', 0, 3, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '620');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Duo Alegria Morango com Leite Condensado 100gr', '7896513916081', NULL, 'UNIDADE', 0, 5.5, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513916081');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Eight', '78400924', NULL, 'UNIDADE', 4, 5, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78400924');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Eisenbahn 600ml', '7898367983615', NULL, 'UNIDADE', 6.2, 10, 0, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898367983615');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Elástico para cabelo', '6074', '607400', 'UNIDADE', 0, 0, 0, '96151100', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6074');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Embalagem de Marmitex  BM 102', NULL, NULL, 'fardo', 0, 0, 0, '39241000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Embalagem de Marmitex  BM 102');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Embalagem de Panetone', NULL, NULL, 'cx', 43.9, 0, 0, '48192000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Embalagem de Panetone');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Embalagem Pnetone 500g', NULL, NULL, 'UNIDADE', 23, 0, 0, '39232910', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Embalagem Pnetone 500g');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Emilia Flokimel 65g', '7898667960668', NULL, 'PACOTE', 0, 3.5, 0, '19041000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898667960668');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Enroladinho de Salsicha', '235', '023500', 'UNIDADE', 0, 8, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '235');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ervilha Bonaro 280g', '7899659900785', NULL, 'UNIDADE', 2.69, 4.5, 0, '20054000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899659900785');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ervilha Lata', '7899659900792', NULL, 'UNIDADE', 2.69, 4.65, 0, '20059900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899659900792');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ervilha Predilecta 280gr', '7896292340541', NULL, 'UNIDADE', 2.69, 4.5, 0, '20054000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896292340541');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ervilha SoFruta 280g', '7896292343719', NULL, 'UNIDADE', 2.69, 4.5, 0, '20054000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896292343719');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Escova de Dente Colgate', '7891024024386', NULL, 'UNIDADE', 4.15, 6.5, 0, '96032100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891024024386');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Escova Dental Dentrat Equilibrio Media', '7898395840362', NULL, 'UNIDADE', 2.49, 4.5, 0, '96032100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898395840362');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Esfiha Aberta', '1012', '101200', 'UNIDADE', 0, 6, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1012');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Esfiha de Brócolis', '244', '024400', 'UNIDADE', 0, 8, 0, NULL, 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '244');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Esfiha de Calabresa', '243', '024300', 'UNIDADE', 0, 8, 0, NULL, 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '243');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Esfiha de Carne', '242', '024200', 'UNIDADE', 0, 8, 0, NULL, 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '242');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Esfiha de Carne Seca', '246', '024600', 'UNIDADE', 0, 8, 0, NULL, 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '246');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Esfiha de Frango', '245', '024500', 'UNIDADE', 0, 8, 0, NULL, 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '245');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Esfirra de Calabresa', '343', '034300', 'UNIDADE', 0, 8, 0, '17049090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '343');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Espelho de urso', '7088', '708800', 'UNIDADE', 0, 0, 0, '70099200', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7088');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Espelho dourado', '7087', '708700', 'UNIDADE', 0, 0, 0, '70099200', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7087');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Espelho prata', '7082', '708200', 'UNIDADE', 0, 0, 0, '70099200', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7082');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Espeto de Morango com chocolate', '3115', '311500', 'UNIDADE', 0, 0, 0, '18069000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3115');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'esponja de maquiagem', '6069', '606900', 'UNIDADE', 0, 0, 0, '96162000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6069');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Esponja multi uso', '7897750788684', NULL, 'UNIDADE', 0, 1.5, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897750788684');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Estrogonoffe', '252', '025200', 'UNIDADE', 0, 28, 0, '22029900', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '252');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fanta caçulinha 200ml', '78936478', NULL, 'UNIDADE', 0, 3, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78936478');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fanta Laranja 600ml', '7894900031607', NULL, 'UNIDADE', 4.1, 8, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900031607');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fanta Laranja Retornavel 1 Litro', '7894900035117', NULL, 'UNIDADE', 0, 5.5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900035117');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fanta Uva 600ml', '7894900053630', NULL, 'UNIDADE', 3.5, 8, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900053630');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Farinha de Rosca', '339', '033900', 'QUILOGRAMA', 0, 15, 0, '19019090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '339');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Farinha de Trigo 1kg Farina', '7891080007682', NULL, 'UNIDADE', 3, 3.8, 0, '11010010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891080007682');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Farinha de Trigo Anaconda 1kg', '7896419431015', NULL, 'UNIDADE', 3.79, 5.5, 0, '11010010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896419431015');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Farinha de Trigo Dona Benta 1kg', '7896005202074', NULL, 'UNIDADE', 5.29, 6.8, 0, '11010010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005202074');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Farinha de Trigo Nita 1kg', '7898234850576', NULL, 'UNIDADE', 4.29, 6.75, 0, '11010010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898234850576');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Farinha de Trigo Rosa Branca 1kg', '7892020200194', NULL, 'UNIDADE', 4.39, 7, 0, '11010010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892020200194');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Farinha de Trigo Tipo 1  PADEIRO ', NULL, NULL, 'KG', 2.76, 0, 0, '11010010', 'normal', 'revenda', NULL, 1, 0, 0, 69, 25, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Farinha de Trigo Tipo 1  PADEIRO ');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Farinha Láctea Nestlé 160g', '7891000369340', NULL, 'UNIDADE', 5.78, 8.5, 0, '19011020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000369340');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Farofa de Mandioca Yoki Temperada 200gr', '7891095911639', NULL, 'UNIDADE', 0, 4.25, 0, '19019090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891095911639');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Farofa Tradicional Yoki 400g', '7891095911486', NULL, 'UNIDADE', 3.79, 6, 0, '19019090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891095911486');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Farofa YOKI 800g', '7891095911394', NULL, 'UNIDADE', 12.9, 16, 0, '19019090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891095911394');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fatia  torta de maracuja', '312', '031200', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '312');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fatia Bolo Branco', '337', '033700', 'UNIDADE', 0, 10, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '337');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fatia Bolo de Banana', '53', '005300', 'UNIDADE', 0, 7, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '53');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fatia Bolo de Cenoura', '331', '033100', 'UNIDADE', 0, 8, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '331');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'FATIA DE CAKE RED VALVET', '4016', '401600', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4016');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'FATIA DE MORANGOFFE', '907', '090700', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '907');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'FATIA DE TORTA NINHO C/ NUTELLA', '6061', '606100', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6061');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'FATIA DE TORTA OREO', '1997', '199700', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1997');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'FATIA TORTA DE CHOCOLATE', '2010', '201000', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '2010');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'fatia torta holandesa', '321', '032100', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '321');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'fatia torta kinder bueno', '322', '032200', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '322');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fecho Plástico 500g', NULL, NULL, 'UNIDADE', 15.5, 0, 0, '39201099', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Fecho Plástico 500g');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Feijão Camil 1kilo', '7896006744115', NULL, 'UNIDADE', 9.25, 10.5, 0, '07133399', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896006744115');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fermento Químico 1kg', NULL, NULL, 'kg', 22.9, 0, 1, '21023000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Fermento Químico 1kg');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fermento Quimico em Po Apti 100g', '7896327512967', NULL, 'UNIDADE', 2.79, 4, 0, '21023000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896327512967');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'File de Carne a Parmegiana', '514', '051400', 'UNIDADE', 0, 28, 0, '02013000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '514');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'File de Frango a Parmegiana', '513', '051300', 'UNIDADE', 0, 28, 0, '02071422', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '513');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Filtro de Café 102', '7891021001885', NULL, 'UNIDADE', 4.78, 6, 0, '48232099', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891021001885');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Filtro de Cafe Brigitta 103', '7891021002127', NULL, 'UNIDADE', 3.19, 5, 0, '48232099', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891021002127');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Filtro de Cafe Melitta 103', '7891021001946', NULL, 'UNIDADE', 3.69, 6, 0, '48232099', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891021001946');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Filtro de Papel Café 102 3 Corações', '7896005803714', NULL, 'UNIDADE', 3.39, 5, 0, '48232099', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005803714');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Filtro de Papel Café103 3 Corações', '7896005803721', NULL, 'UNIDADE', 2.99, 5.99, 0, '48232099', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005803721');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Finesse', NULL, NULL, 'pct', 81.66, 0, 1, '15171000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Finesse');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fini Amoras 15gr', '7898591450648', NULL, 'UNIDADE', 0.95, 1.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898591450648');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fini Tubes Morango e Nata 15gr', '7898591459511', NULL, 'UNIDADE', 0.98, 1.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898591459511');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fini Tubes Morango e Nata Citrus 15gr', '7898279799823', NULL, 'UNIDADE', 0.98, 1.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898279799823');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Flocão de Milho Bonomilho 500g', '7896333200117', NULL, 'UNIDADE', 2.89, 4, 0, '11022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896333200117');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Flocão Maratá 500g', '7898932426042', NULL, 'UNIDADE', 1.99, 2.99, 0, '11041900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898932426042');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fofura Assado Queijo 60g', '7892840823214', NULL, 'PACOTE', 0, 2, 0, '19041000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840823214');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fofura cebola 60g', '7892840823177', NULL, 'PACOTE', 0, 2, 0, '19041000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840823177');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fofura Churrasco 60g', '7892840823191', NULL, 'PACOTE', 1.55, 2, 0, '19041000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840823191');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fofura Presunto 60g', '7892840823207', NULL, 'UNIDADE', 0, 2, 0, '19041000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840823207');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fofura Requeijão 60gr', '7892840823221', NULL, 'PACOTE', 1.55, 2, 0, '19041000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840823221');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Forma Pnetone 500g', NULL, NULL, 'UNIDADE', 44, 0, 0, '48043190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Forma Pnetone 500g');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fósforo Gaboardi un', '9039', '903900', 'UNIDADE', 0, 0, 0, '36050000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9039');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fósforo Paraná Unidade', '1022', '102200', 'CAIXA', 0.37, 0.6, 0, '36050000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1022');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fosfuro Paraná Unidade', '1022', '102200', 'CAIXA', 0.37, 0.6, 0, '36050000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1022');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fosfuro Que luz c/40 un', '4047', '404700', 'UNIDADE', 0, 0, 0, '36050000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4047');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'FRANGO A MILANESA', '254', '025400', 'UNIDADE', 0, 0, 0, '16023220', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '254');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Frango À Milanesa com Creme de Milho', '516', '051600', 'UNIDADE', 0, 28, 0, '16023220', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '516');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Frango a Passrinho', '471', '047100', 'UNIDADE', 0, 28, 0, '16023220', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '471');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'FRANGO ASSADO', '452', '045200', 'UNIDADE', 0, 0, 0, '16023290', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '452');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Frango Cozido', '469', '046900', 'UNIDADE', 0, 28, 0, '16023220', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '469');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Frango ou Carne a Milanesa', '255', '025500', 'UNIDADE', 0, 25, 0, '22029900', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '255');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fruta Cristalizada ', NULL, NULL, 'KG', 1180, 0, 0, '20060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Fruta Cristalizada ');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Fubá Mimoso', NULL, NULL, 'un', 3.5, 0, 0, '11022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Fubá Mimoso');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'G677', NULL, NULL, 'cx', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'G677');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'G677 Tampa', NULL, NULL, 'cx', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'G677 Tampa');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Galak Wafer 110g', '7891000372548', NULL, 'UNIDADE', 3.43, 5, 0, '19053200', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000372548');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gatorade Blue Berry 500 ml', '7892840822019', NULL, 'UNIDADE', 4.12, 8, 0, '22029900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840822019');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gatorade Sabor Laranja 500ml', '7892840808020', NULL, 'UNIDADE', 4.49, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840808020');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gatorade Sabor Morango e Maracuja 500ml', '7892840808174', NULL, 'UNIDADE', 4.49, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840808174');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gatorade Sabor Uva 500ml', '7892840808051', NULL, 'UNIDADE', 4.45, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840808051');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'GELADO DE ABACAXI TAMANHO G', '3007', '300700', 'UNIDADE', 0, 0, 0, '21050010', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3007');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gelatina Colorida 200g', '5039', '503900', 'UNIDADE', 0, 10, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '5039');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gelatina Incolor Apti', '7896327511472', NULL, 'UNIDADE', 0, 8.25, 0, '21069029', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896327511472');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gelatina limão zero açucar Aptiva 12g', '7896327513957', NULL, 'UNIDADE', 1.88, 2.8, 0, '21069029', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896327513957');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gelatina Morango Apit 20g', '7896327516118', NULL, 'UNIDADE', 1.48, 2.5, 0, '21069029', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896327516118');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'GELATINA TAMANHO G', '9999', '999900', 'UNIDADE', 0, 0, 0, '19019090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9999');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'GELATINA TAMANHO P', '9998', '999800', 'UNIDADE', 0, 0, 0, '19019090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9998');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gergelim', NULL, NULL, 'kg', 23.59, 0, 1, '09109900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Gergelim');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gift', '78410282', NULL, 'UNIDADE', 3.2, 6, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78410282');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gilete Wilkinson C/3 Unidade', '83', '008300', 'UNIDADE', 1.14, 3.5, 0, '21011110', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '83');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'GILLETE PRESTOBARBA CHAMPIONS 3', '7500435154772', NULL, 'UNIDADE', 5.87, 7, 0, '82121020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7500435154772');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Goiabada Bloco', NULL, NULL, 'cx', 89.91, 0, 0, '20079910', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Goiabada Bloco');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Goiabada Serralegre 200g', '7898045702583', NULL, 'UNIDADE', 2.69, 0, 0, '20079910', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898045702583');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Goma de Mascar Tutti-Frutti Danclets 13,5g', '7898934596064', NULL, 'UNIDADE', 3.33, 4.99, 0, '17041000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898934596064');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Goma Eucalypto 18g', '7897064812853', NULL, 'UNIDADE', 0.63, 1, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897064812853');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Goma Frutas Jelly Rolls 31g', '7897064811399', NULL, 'UNIDADE', 0, 1.5, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897064811399');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Granulado dori 120g', '7896058599473', NULL, 'UNIDADE', 3.99, 6.5, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896058599473');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Guarana Antartica 1,5', '7891991008761', NULL, 'UNIDADE', 4.49, 7.99, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991008761');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Guaraná Antartica 600ml', '7891991002646', NULL, 'UNIDADE', 0, 8, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991002646');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Guardanapo Minifior C/50un', '7897532800030', NULL, 'UNIDADE', 1.15, 1.99, 0, '48182000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897532800030');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gudan Maço', '8998989121200', NULL, 'UNIDADE', 22.5, 42, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8998989121200');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Gudang unidade', '118', '011800', 'UNIDADE', 0, 2.5, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '118');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'H2O Limão', '7892840812423', NULL, 'UNIDADE', 0, 6.5, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840812423');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Halls Blueberry', '78949416', NULL, 'UNIDADE', 1.14, 2.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78949416');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Halls Cereja', '78938793', NULL, 'UNIDADE', 1.78, 2.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78938793');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Halls Melancia', '78938854', NULL, 'UNIDADE', 1.78, 2.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78938854');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Halls Menta', '78938830', NULL, 'UNIDADE', 1.76, 2.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78938830');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Halls Mentol', '78938823', NULL, 'UNIDADE', 1.14, 2.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78938823');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Halls Morango', '78938847', NULL, 'UNIDADE', 1.78, 2.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78938847');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Halls Preto', '78938816', NULL, 'UNIDADE', 1.14, 2.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78938816');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Halls Uva verde', '78938861', NULL, 'UNIDADE', 1.14, 2.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78938861');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Hambúrgão', '241', '024100', 'UNIDADE', 0, 8, 0, NULL, 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '241');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Hamburguer', '7894904500383', NULL, 'UNIDADE', 0.95, 2.5, 0, '16025000', 'normal', 'revenda', NULL, 1, 0, 0, 34.25, 36, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894904500383');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Hamburguer Texas', NULL, NULL, 'UNIDADE', 34.25, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Hamburguer Texas');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'hamburguinhos', '269', '026900', 'UNIDADE', 0, 0, 0, '21069050', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '269');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaiana Azul Naval 41/42', '7890557722257', NULL, 'UNIDADE', 21.76, 30, 0, '64022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557722257');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaiana Azul Naval 43/44', '7890557722264', NULL, 'UNIDADE', 21.76, 30, 0, '64022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557722264');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaiana Branca Lisa 37/38', '7891109714485', NULL, 'UNIDADE', 21.76, 30, 0, '64022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109714485');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaiana Branca Lisa 43/44', '7891109714515', NULL, 'UNIDADE', 21.76, 30, 0, '64022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109714515');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaiana Preto 39/40', '7891109486221', NULL, 'UNIDADE', 21.76, 30, 0, '64022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109486221');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaiana Slim 35/36 Areia/dourado', '7890557502477', NULL, 'UNIDADE', 27.12, 39.99, 0, '64029990', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557502477');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaiana Slim 35/36 Rose Gold', '7891266542051', NULL, 'UNIDADE', 27.12, 39.99, 0, '64029990', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891266542051');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaiana Slim 37/38 Areia/dourado', '7890557502484', NULL, 'UNIDADE', 27.12, 39.99, 0, '64029990', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557502484');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaiana Slim 37/38 Rose Gold', '7891266542068', NULL, 'UNIDADE', 27.12, 39.99, 0, '64029990', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891266542068');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaiana Slim 39/40 Areia/dourado', '7890557502491', NULL, 'UNIDADE', 27.12, 39.99, 0, '64029990', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557502491');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaiana Slim 39/40 Rose Gold', '7891266542075', NULL, 'UNIDADE', 27.12, 39.99, 0, '64029990', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891266542075');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaianas 37/38 Azul', '7890541601889', NULL, 'UNIDADE', 0, 30, 0, '64022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890541601889');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaianas 43/44', '7890557722264', NULL, 'UNIDADE', 21.76, 30, 0, '64022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557722264');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaianas Azul Naval 35/36', '7890557722226', NULL, 'UNIDADE', 21.76, 30, 0, '64022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557722226');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaianas Branco 31/32', '7891109714454', NULL, 'UNIDADE', 0, 30, 0, '64022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109714454');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaianas Preto 31/32', '7891109635216', NULL, 'UNIDADE', 18.3, 30, 0, '64022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109635216');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaianas Preto 33/34', '7891109486191', NULL, 'UNIDADE', 21.76, 30, 0, '64022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109486191');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Havaianas Preto 35/36', '7891109486207', NULL, 'UNIDADE', 21.76, 30, 0, '64022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109486207');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Heineken Long Neck 330ml Zero 0,0%', '7896045506040', NULL, 'UNIDADE', 8.52, 12.75, 0, '22029100', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045506040');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'IMPERIO 269ML', '8000', '800000', 'UNIDADE', 2.3, 0, 0, '22030000', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8000');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Iogurte Batido', '200', '020000', 'UNIDADE', 0, 8, 0, '04032000', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '200');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Iogurte Frutap 850ml', '7896862000875', NULL, 'UNIDADE', 8.75, 13.2, 0, '04032000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896862000875');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Iogurte Frutap Desnatado 150g', '7896862002763', NULL, 'UNIDADE', 2.55, 4, 0, '04032000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896862002763');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Iogurte Integral Frutap 150g', '7896862000431', NULL, 'UNIDADE', 2.4, 4, 0, '04032000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896862000431');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Isqueiro', '131', '013100', 'UNIDADE', 0, 2, 0, '96138000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '131');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Isqueiro Clipper Mini Gás', '8412765505447', NULL, 'UNIDADE', 3.1, 4, 0, '96131000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8412765505447');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'It Cola 2l', '7898377662401', NULL, 'UNIDADE', 6.74, 3.99, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898377662401');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'It Soda 2 Litros', NULL, NULL, 'fardo', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'It Soda 2 Litros');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Italakinho 200ml', '7898080640239', NULL, 'UNIDADE', 0.97, 3, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898080640239');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Kapo laranja 200ml', '7 894900 563702', NULL, 'UNIDADE', 1.87, 3.75, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7 894900 563702');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Katchup Tradicional 200g', '7896102502763', NULL, 'UNIDADE', 4.19, 6, 0, '21032010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896102502763');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Katchup Val 200g', '7898045701760', NULL, 'UNIDADE', 2.99, 4.5, 0, '21032010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898045701760');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'KetChup ARISCO 370g', '7891150079212', NULL, 'UNIDADE', 7.68, 10, 0, '21032010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891150079212');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ketchup Picante Predilecta 400g', '7896292360464', NULL, 'UNIDADE', 5.85, 8.75, 0, '21032010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896292360464');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'KetChup QUERO 300G', '7896102502909', NULL, 'UNIDADE', 5.79, 8.5, 0, '21032010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896102502909');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Kibe', '263', '026300', 'UNIDADE', 0, 8, 0, '16025000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '263');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Kit bolsa de xuxa infantil', '6067', '606700', 'UNIDADE', 0, 0, 0, '96151100', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6067');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Kit festa massa branca', '4444', '444400', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4444');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Kit festa massa de chocolate', '4445', '444500', 'UNIDADE', 0, 0, 0, '18069000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4445');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Kit monte acessórios', '6260', '626000', 'UNIDADE', 0, 0, 0, '96151100', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6260');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Kraft 1 kg', NULL, NULL, 'PACOTE', 0, 0, 0, '04061090', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Kraft 1 kg');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Kraft 2 kg', NULL, NULL, 'PACOTE', 0, 0, 0, '04061090', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Kraft 2 kg');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Kraft 3 kg', NULL, NULL, 'PACOTE', 0, 0, 0, '04061090', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Kraft 3 kg');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Kraft de 5 kg', NULL, NULL, 'PACOTE', 0, 0, 0, '04061090', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Kraft de 5 kg');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Kraft de 7,5 kg', NULL, NULL, 'PACOTE', 0, 0, 0, '04061090', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Kraft de 7,5 kg');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'L&M azul First cut', '78942646', NULL, 'UNIDADE', 10.1, 11, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78942646');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'L&M First Cut silver prata', '78948228', NULL, 'UNIDADE', 10.1, 11, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78948228');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'L&M vermelho', '78942653', NULL, 'UNIDADE', 10.1, 11, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78942653');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Laço infantil un', '7085', '708500', 'UNIDADE', 0, 0, 0, '96159000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7085');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Laka Lacta 34gr', '7622210573353', NULL, 'UNIDADE', 0, 4, 0, '17049010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210573353');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Lampada 15w Kian', '7899710006579', NULL, 'UNIDADE', 4.59, 8, 0, '85395200', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899710006579');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'LANCHE NATURAL DE FRANGO', '524', '052400', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '524');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'LANCHE NATURAL DE PEITO DE PERU', '525', '052500', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '525');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'LANCHE NATURAL DE QUEIJO E PRESUNTO', '526', '052600', 'UNIDADE', 0, 0, 0, '16022000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '526');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Lanchinho Natural', '333', '033300', 'UNIDADE', 0, 3, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '333');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Lanchinho natural P', '1120', '112000', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1120');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Lanchinho Unidade', '320', '032000', 'UNIDADE', 0, 2.5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '320');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Lata de Milho Salsaretti 170g', '7898930142784', NULL, 'UNIDADE', 2.59, 4.5, 0, '20058000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898930142784');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite com Toddy G', '199', '019900', 'UNIDADE', 0, 10, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '199');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite com Toddy M', '198', '019800', 'UNIDADE', 0, 7, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '198');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite Condensado 5kg', NULL, NULL, 'cx', 74.94, 0, 0, '04021010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Leite Condensado 5kg');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite Condensado Moça 340g', '7891000305553', NULL, 'UNIDADE', 5.85, 9, 0, '04029900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000305553');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite Condensado Piracanjuba 395g', '7898215152002', NULL, 'UNIDADE', 6.29, 9.5, 0, '04029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898215152002');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite de Coco Bom Coco 200ml', '7898406780755', NULL, 'UNIDADE', 1.85, 2.75, 0, '20098990', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898406780755');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite em Pó Integral 200g', '7898080640376', NULL, 'PEÇA', 6.99, 11.5, 0, '04022110', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898080640376');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite em Po Integral Instantaneo Itambe 400g', '7896051130123', NULL, 'UNIDADE', 15.9, 23.85, 0, '04021010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896051130123');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite em Pó Integral Piracanjuba 400g', '7898215152347', NULL, 'UNIDADE', 15.9, 21.5, 0, '04022110', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898215152347');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite Fermentado Frutap 170ml', '7896862002107', NULL, 'UNIDADE', 2.55, 3.8, 0, '04039000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896862002107');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite Integral Tirol 1l', '7896256601848', NULL, 'UNIDADE', 5.9, 7.5, 0, '04021010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896256601848');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite Lider', NULL, NULL, 'LITRO', 5.19, 0, 0, '04021010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Leite Lider');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite Lider 1l', '7896569405003', NULL, 'UNIDADE', 5.19, 7.5, 0, '04012010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896569405003');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite Quente G', '197', '019700', 'UNIDADE', 0, 6, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '197');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Leite Quente P', '196', '019600', 'UNIDADE', 0, 4, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '196');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Lenço Suave Pop', '7896076001149', NULL, 'UNIDADE', 0.66, 1.99, 0, '48183000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896076001149');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Limpa Aluminio Maximo 500ml', '7898944352285', NULL, 'UNIDADE', 3.47, 4, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898944352285');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'LIMPADOR MULTIUSO luar c/ bicarbonato 500ml', '7898650860418', NULL, 'UNIDADE', 2.29, 0, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898650860418');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Limpador Multiuso Veja Floral', '7891035209901', NULL, 'UNIDADE', 5.15, 7.75, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891035209901');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Linguiça Toscana ', '436', '043600', 'UNIDADE', 0, 3, 0, '16010000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '436');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'LIXA DE UNHA', '0001', '000100', 'UNIDADE', 0.05, 0, 0, '68052000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '0001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Lollo  Chocolate 28g', '7891000092606', NULL, 'UNIDADE', 2.5, 3.75, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000092606');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Lua de Mel', '319', '031900', 'QUILOGRAMA', 0, 2.5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '319');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'LUA DE MEL DE CREME', '1091', '109100', 'CAIXA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1091');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'LUA DE MEL DE DOCE DE LEITE', '1092', '109200', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1092');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'LUA DE MEL DE NUTELLA', '1094', '109400', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1094');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Lucky strike double frost', '78946293', NULL, 'UNIDADE', 12.46, 16, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78946293');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'lucky strike fresh mint x', '78944305', NULL, 'UNIDADE', 11.54, 12.75, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78944305');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Lucky strike maço', '78923782', NULL, 'UNIDADE', 0, 11.75, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78923782');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Lucky Strike original Maço', '78946460', NULL, 'UNIDADE', 13.38, 14.5, 0, '02071412', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78946460');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Luva descartável', NULL, NULL, 'cx', 0, 0, 0, '40151900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Luva descartável');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'M & Ms 40g', '7896423419276', NULL, 'UNIDADE', 3.29, 5, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896423419276');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'MAÇA DO AMOR', '582', '058200', 'UNIDADE', 0, 0, 0, '17049090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '582');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Macarrão Dona Benta Penne 500gr', '7896005281710', NULL, 'UNIDADE', 0, 3.99, 0, '19021100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005281710');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Macarrão Espaguete Dona Benta 500g', '7896005286579', NULL, 'UNIDADE', 3.22, 5.5, 0, '19021100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005286579');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Macarrão Parafuso Dona Benta 500g', '7896005286593', NULL, 'UNIDADE', 3.09, 5.6, 0, '19021100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005286593');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Macarrão Penne Adria 500g', '7896205788217', NULL, 'UNIDADE', 3.29, 5, 0, '19021100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896205788217');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Macarrão Renata 500gr', '7896022200213', NULL, 'UNIDADE', 6, 8.99, 0, '19021100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896022200213');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maione Quero 495g', '7896102584998', NULL, 'UNIDADE', 6.65, 10.5, 0, '21039021', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896102584998');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maionese Hellman''s 250g', '7894000050027', NULL, 'UNIDADE', 7.98, 10.5, 0, '21039021', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894000050027');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maionese Hellmanns 657gr', '7891150072046', NULL, 'UNIDADE', 9.9, 15, 0, '21039011', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891150072046');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maionese Hellmanns Sache 200g', '7894000030470', NULL, 'UNIDADE', 6.18, 7.5, 0, '21039021', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894000030470');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maionese Original Fugini 180ml', '7897517205638', NULL, 'UNIDADE', 2.69, 4, 0, '21039011', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897517205638');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maionese Quero 200g', '7896102509434', NULL, 'UNIDADE', 3.79, 5.7, 0, '21039011', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896102509434');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maionese Vigor 200g', '7891999948908', NULL, 'UNIDADE', 3.29, 4.99, 0, '21039021', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891999948908');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maizena Amido de milho 500g', '7894000010021', NULL, 'UNIDADE', 12, 20, 0, '11081200', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894000010021');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Malzbier 350ml', '7897395020194', NULL, 'UNIDADE', 0, 4.5, 0, '22030000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897395020194');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'manjar de coco', '8888', '888800', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8888');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Manteiga', '151', '015100', 'QUILOGRAMA', 0, 50, 0, '04051000', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '151');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Manteiga de Cacau Protetor Labial', '7896154101280', NULL, 'UNIDADE', 1.66, 2.5, 0, '33049100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896154101280');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Manteiga Gradina', NULL, NULL, 'KG', 32.78, 0, 2, '04051000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Manteiga Gradina');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Manteiga Qualy 250g com sal', NULL, NULL, 'cx', 0, 0, 0, '04051000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Manteiga Qualy 250g com sal');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Manteiga Qualy com Sal 500g', NULL, NULL, 'cx', 0, 0, 0, '04051000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Manteiga Qualy com Sal 500g');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata 1 Litro Abacaxi', '7898378180768', NULL, 'UNIDADE', 3.99, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180768');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata 1 Litro Goiaba', '7898378180041', NULL, 'UNIDADE', 4.66, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180041');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata 1 Litro Laranja', '7898378180010', NULL, 'UNIDADE', 4.65, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180010');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata 1 Litro Manga', '7898378180034', NULL, 'UNIDADE', 4.99, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180034');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata 1 Litro Maracuja', '7898378180072', NULL, 'UNIDADE', 4.65, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180072');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata 1 Litro Pessego', '7898378180065', NULL, 'UNIDADE', 4.4, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180065');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata 1 Litro Tangerina', '7898378180096', NULL, 'UNIDADE', 4.65, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180096');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata 1 Litro Uva', '7898378180027', NULL, 'UNIDADE', 4.4, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180027');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata 200 ml Caju', '7898378180171', NULL, 'UNIDADE', 1.48, 2.75, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180171');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata 200ml  Goiaba', '7898378180164', NULL, 'UNIDADE', 1.51, 2.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180164');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata 200ml Laranja', '7898378180133', NULL, 'UNIDADE', 1.51, 2.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180133');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata 200ml Manga', '7898378180157', NULL, 'UNIDADE', 1.51, 2.75, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180157');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata 200ml Pessego', '7898378180188', NULL, 'UNIDADE', 1.51, 2.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180188');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata Caja 1 litro', '7898378180829', NULL, 'UNIDADE', 5.1, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180829');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maratá Goiaba Pequeno', NULL, NULL, 'UNIDADE', 1.51, 2.5, 1, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Maratá Goiaba Pequeno');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maratá Laranja grande', NULL, NULL, 'UNIDADE', 4.65, 8, 1, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Maratá Laranja grande');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maratá Manga pequeno', NULL, NULL, 'UNIDADE', 1.51, 2.5, 1, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Maratá Manga pequeno');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maratá Maracujá 200ml', '7898378180447', NULL, 'UNIDADE', 1.51, 2.5, 1, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180447');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maratá Maracujá grande', NULL, NULL, 'UNIDADE', 4.65, 8, 1, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Maratá Maracujá grande');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maratá Pessego pequeno', NULL, NULL, 'UNIDADE', 1.51, 2.5, 1, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Maratá Pessego pequeno');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marata Uva 200ml', '7898378180140', NULL, 'UNIDADE', 1.51, 2.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180140');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maratá Uva grande', NULL, NULL, 'cx', 0, 0, 1, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Maratá Uva grande');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maratá Uva pequeno', NULL, NULL, 'UNIDADE', 1.51, 2.5, 1, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Maratá Uva pequeno');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Margarina com Sal Qualy 250g', '7891515537531', NULL, 'cx', 4.51, 6.5, 0, '15171000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891515537531');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Margarina com Sal Qualy 500g', '7893000394209', NULL, 'un', 6.78, 11.5, 0, '15171000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7893000394209');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Margarina Gourmet C/sal Becel 250g', '7891515644499', NULL, 'UNIDADE', 4.87, 7.6, 0, '15171000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891515644499');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Maria Mole', '329', '032900', 'UNIDADE', 0, 3, 0, '17049090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '329');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marlboro azul selection', '78947986', NULL, 'UNIDADE', 8.81, 14, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947986');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marlboro crafted red selection', '78940871', NULL, 'UNIDADE', 8.81, 11, 0, '02012020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78940871');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marlboro foresr fusion', '78937352', NULL, 'UNIDADE', 12.15, 17.75, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78937352');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marlboro gold/ouro', '78900134', NULL, 'UNIDADE', 13.62, 17.25, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78900134');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marlboro ice burst', '78900066', NULL, 'UNIDADE', 11.75, 17.25, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78900066');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marlboro Red Selection', '78946781', NULL, 'UNIDADE', 0, 14.25, 0, '02012020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78946781');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marlboro red/vermelho', '78903418', NULL, 'UNIDADE', 0, 17.25, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78903418');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marlboro tropical fusion melância', '78939837', NULL, 'UNIDADE', 12.25, 17.75, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78939837');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marmita Pequena', '231', '023100', 'UNIDADE', 0, 5, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '231');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marmitex', '1008', '100800', 'UNIDADE', 0, 30, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1008');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marmitex Embalagem', '261', '026100', 'fardo', 0, 2, 0, '39241000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '261');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marmitex Pequena', '8710', '871000', 'UNIDADE', 0, 18.99, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8710');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marroquino de Frango', '482', '048200', 'UNIDADE', 0, 20, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '482');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marroquino de Peito de Peru', '529', '052900', 'KG', 0, 20, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '529');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marroquino de Salame', '479', '047900', 'KG', 0, 20, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '479');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marroquino Integral C/peito de Peru', '2002', '200200', 'UNIDADE', 0, 20, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '2002');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Marroquino Queijo e Presunto', '395', '039500', 'UNIDADE', 0, 16, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '395');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Massa de Lasanha Tradicional Petybon 200g', '7896005271377', NULL, 'UNIDADE', 2.89, 4.5, 0, '19021900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005271377');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Matte Leao 450ml', '7891098040688', NULL, 'UNIDADE', 0, 5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891098040688');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'media', '300', '030000', 'UNIDADE', 0, 0, 0, '19023000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '300');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Media Café', '228', '022800', 'KG', 0, 12.99, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '228');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Media Empresa', '993', '099300', 'QUILOGRAMA', 17, 17, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '993');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'MEDIA ITAU', '508', '050800', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '508');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Meia Porção Contra File', '296', '029600', 'CAIXA', 0, 25, 0, '02013000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '296');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Meia Porção de Batata Frita 200gr', '299', '029900', 'CAIXA', 0, 15, 0, '20041000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '299');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Meia Porção de Calabresa', '294', '029400', 'CAIXA', 0, 15, 0, '16010000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '294');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Meia Porção Queijo/presunto', '297', '029700', 'CAIXA', 0, 15, 0, '16022000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '297');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Meia Porção Salame', '295', '029500', 'CAIXA', 0, 15, 0, '16010000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '295');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mentos', '7896262304306', NULL, 'UNIDADE', 0, 3.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896262304306');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mentos Azul Unidade', '78947283', NULL, 'UNIDADE', 0, 0.5, 0, '21069050', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947283');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mentos Chiclete', '78947276', NULL, 'UNIDADE', 0, 0.5, 0, '21069050', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947276');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mentos frutas vermelhas 37,5g', '7895144603063', NULL, 'UNIDADE', 2.25, 3.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895144603063');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mentos tutti fruit 37,5', '7895144603223', NULL, 'UNIDADE', 2.25, 3.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895144603223');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mentos Yogurt e Morango', '7895144603087', NULL, 'UNIDADE', 0, 3.5, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895144603087');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Milho de Pipoca para Microondas Natural com Salnatural com Sal Yoki 100g', '7891095002207', NULL, 'UNIDADE', 0, 4.2, 0, '20081900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891095002207');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Milho de Pipoca Sinha 400g', '7892300030107', NULL, 'UNIDADE', 3.79, 5.7, 0, '10059010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892300030107');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Milho lata', '789', '078900', 'UNIDADE', 0, 4.5, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '789');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Milho Predilecta Lata 280g', '7896292340503', NULL, 'UNIDADE', 3.09, 3.99, 0, '20058000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896292340503');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Milho Stella Lata', '7898902299058', NULL, 'UNIDADE', 2.9, 4.3, 0, '20058000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898902299058');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Broa', '399', '039900', 'QUILOGRAMA', 0, 25, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '399');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Broa de fubá com Goiabada', '9666', '966600', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9666');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Cara Empresa', '220', '022000', 'UNIDADE', 17, 17, 0, '19023000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '220');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Cara recheada com chocolate ou doce de leite', '6043', '604300', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6043');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'MINI CHOCOTONE', '8090', '809000', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8090');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Coco', '406', '040600', 'UNIDADE', 0, 1, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '406');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Coquinho Empresa', '225', '022500', 'QUILOGRAMA', 0, 21, 0, '19023000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '225');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Croissant', '27', '002700', 'KG', 0, 29.99, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '27');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Esfirra', '316', '031600', 'QUILOGRAMA', 0, 29.99, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '316');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Medias Empresa', '221', '022100', 'QUILOGRAMA', 0, 17, 0, '19023000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '221');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Nutella 140g', '7898024395232', NULL, 'UNIDADE', 9.99, 15.99, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898024395232');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Pão de Creme', '346', '034600', 'UNIDADE', 0, 2, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '346');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Pão de Creme Empresa', '227', '022700', 'QUILOGRAMA', 0, 21, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '227');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Pão de Frios', '318', '031800', 'QUILOGRAMA', 0, 29.99, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '318');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Pudim de Chocolate', '577', '057700', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '577');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Salgado', '350', '035000', 'KG', 0, 29.99, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '350');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'MINI SALGADOS DE  FRIOS', '433', '043300', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '433');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Salgados Frito', '901', '090100', 'QUILOGRAMA', 0, 80, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '901');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Sonho de Chocolate', '5099', '509900', 'UNIDADE', 0, 3, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '5099');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Sonho de Doce de Leite', '4089', '408900', 'UNIDADE', 0, 3, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4089');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini Sonho Empresa', '226', '022600', 'QUILOGRAMA', 0, 31, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '226');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mini X- Salada', '315', '031500', 'UNIDADE', 0, 3, 0, '16025000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '315');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Miojo Cup Noodles Bolonhesa Nissin 72g', '7891079013120', NULL, 'UNIDADE', 5.29, 8, 0, '19023000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891079013120');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Miojo Cup Noodles Galinha Picante Nissin 68g', '7891079013069', NULL, 'UNIDADE', 5.29, 8, 0, '19023000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891079013069');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Miojo Nissin Galinha Caipira 85g', '7891079000229', NULL, 'UNIDADE', 2.79, 3.85, 0, '19023000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891079000229');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Miojo Nissin Sabor Carne 85g', '7891079000205', NULL, 'UNIDADE', 1.99, 3.85, 0, '19023000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891079000205');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mistinho', '257', '025700', 'UNIDADE', 0, 8, 0, '02109100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '257');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Misto com Peito de Peru e Queijo', '149', '014900', 'UNIDADE', 0, 15, 0, '22029900', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '149');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Misto Frio', '162', '016200', 'CAIXA', 0, 12, 0, '02109100', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '162');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Misto no Pão de Forma', '506', '050600', 'UNIDADE', 0, 10, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '506');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Misto Quente', '161', '016100', 'UNIDADE', 0, 12, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '161');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Misto Quente no Cara', '458', '045800', 'UNIDADE', 0, 12, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '458');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mistura Contra File', '3091', '309100', 'UNIDADE', 0, 15, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3091');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mistura File de Frango', '3092', '309200', 'UNIDADE', 0, 12, 0, '16023220', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3092');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mistura Mista', '3093', '309300', 'UNIDADE', 0, 12, 0, '16010000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3093');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mistura Pánetone GOLD GRANO', NULL, NULL, 'KG', 250, 0, 0, '09012090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Mistura Pánetone GOLD GRANO');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mistura para Bolo Coco Dona Benta 450g', '7896005272046', NULL, 'UNIDADE', 7.29, 12, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005272046');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mistura para Bolo Milho Apti 400g', '7896327511991', NULL, 'UNIDADE', 3.29, 6, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896327511991');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mistura Parmegiana', '3090', '309000', 'UNIDADE', 0, 18, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3090');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Moda Re', '375', '037500', 'UNIDADE', 0, 5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '375');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Moda Re 2', '376', '037600', 'UNIDADE', 0, 9, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '376');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Moda Re na Baguete 1', '455', '045500', 'UNIDADE', 0, 7, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '455');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Moda Re na Baguete 2', '456', '045600', 'UNIDADE', 0, 9, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '456');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molecão Iranel Doces 70g', '7891098370198', NULL, 'UNIDADE', 1.1, 2, 0, '17049090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891098370198');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molho Aji No Shoyu 150ml', '7896007811021', NULL, 'UNIDADE', 3.7, 5, 0, '21031010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896007811021');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molho de Alho Campo Belo 150ml', '7898075643917', NULL, 'UNIDADE', 2.39, 5, 0, '21039091', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898075643917');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molho de Alho Cepêra 150ml', '7896025801196', NULL, 'UNIDADE', 4.35, 5, 0, '21039021', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896025801196');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molho de pimenta kenko 150ml', '7896007811304', NULL, 'UNIDADE', 3.49, 4.9, 0, '21039021', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896007811304');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molho de Tomate Bonare 300g', '7899659901096', NULL, 'UNIDADE', 0, 2.3, 0, '21032010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899659901096');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molho de Tomate Fugini 300g', '7897517206086', NULL, 'UNIDADE', 2.19, 3, 0, '21032010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897517206086');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molho de Tomate Predilecta 300g', '7896292333000', NULL, 'UNIDADE', 1.49, 2.6, 0, '21032010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896292333000');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molho de tomate tomadoro 300g', '7899659901331', NULL, 'UNIDADE', 1.25, 3.5, 0, '21032010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899659901331');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molho inglês Arrifarma 150ml', '7896056100176', NULL, 'UNIDADE', 0, 5, 0, '21039021', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896056100176');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molho Inglês Campo Belo 150ml', '7898075643948', NULL, 'UNIDADE', 2.39, 5, 0, '21039091', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898075643948');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molho Pimenta Gota 150ml', '7898286190316', NULL, 'UNIDADE', 2.99, 4.5, 0, '21039021', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898286190316');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molho Shoyu Sakura 150ml', '7896007811007', NULL, 'UNIDADE', 3.7, 5, 0, '21031010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896007811007');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Molho Shoyu Tradicional Arrifana 150ml', '7896056101234', NULL, 'UNIDADE', 3.39, 5, 0, '21031010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896056101234');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Monster ', '070847022015', NULL, 'UNIDADE', 8.5, 12.75, 0, '22029900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '070847022015');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'morango cravejado  c/ pistache', '9008', '900800', 'UNIDADE', 0, 15, 0, '20079990', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9008');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Morango cravejado c/ brigadeiro', '9011', '901100', 'UNIDADE', 0, 15, 0, '20079990', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9011');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Morango cravejado c/ maracúja', '9007', '900700', 'UNIDADE', 0, 15, 0, '20079990', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9007');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'morango cravejado c/ ninho', '9010', '901000', 'UNIDADE', 0, 15, 0, '20079990', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9010');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Morango do Amor', '909', '090900', 'UNIDADE', 0, 14.99, 0, '08101000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '909');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Morango do Nordeste', '624', '062400', 'UNIDADE', 0, 10, 0, '08101000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '624');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'morango no espeto c/ brigadeiro', '9012', '901200', 'UNIDADE', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9012');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Morango no espeto c/ leite ninho', '9015', '901500', 'UNIDADE', 0, 0, 0, NULL, 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9015');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Morangoffe', '616', '061600', 'UNIDADE', 0, 0, 0, '08101000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '616');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mortadela Defumada Sadia', '915', '091500', 'QUILOGRAMA', 14.3, 32, 0, '16010000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '915');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mortadela Tradicional', '946', '094600', 'cx', 14.47, 25, 0, '16010000', 'normal', 'revenda', NULL, 0, 0, 0, 151.93, 10.5, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '946');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mostarda 200g', '789846867084', NULL, 'UNIDADE', 0, 4, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '789846867084');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mostarda Quero 190g', '7896102509144', NULL, 'UNIDADE', 5.79, 8.7, 0, '21032090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896102509144');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mousse', '108', '010800', 'UNIDADE', 0, 6, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '108');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mousse de Chocolate', '310', '031000', 'UNIDADE', 0, 6, 0, '19019090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '310');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mousse de Limão', '309', '030900', 'UNIDADE', 6, 6, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '309');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mousse de Maracuja', '308', '030800', 'UNIDADE', 6, 6, 0, '19019090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '308');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mousse de Morango', '325', '032500', 'UNIDADE', 0, 6, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '325');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Muçarela', '977', '097700', 'KG', 41.8, 59, 0, '04061010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '977');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Mucilon Multicereais Sachê 180g', '7891000319505', NULL, 'UNIDADE', 5.85, 8.5, 0, '19011030', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000319505');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Nescafé chocolate nestlé 270ml', '7891000389300', NULL, 'UNIDADE', 7.34, 10, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000389300');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Nescafe Latte 270ml', '7891000389171', NULL, 'UNIDADE', 6.34, 0, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000389171');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Nescafé Solúvel Tradição 40g789', '7891000307083', NULL, 'UNIDADE', 6.5, 8, 0, '21011110', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000307083');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Nescal 730gr', '7891000338162', NULL, 'UNIDADE', 0, 18, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000338162');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Nescau Bebida Pronta 180ml', '7891000359822', NULL, 'UNIDADE', 2.16, 3.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000359822');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Nescau Cereal', '7891000070673', NULL, 'UNIDADE', 5.2, 7.5, 0, '19041000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000070673');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Nescau Nestlé 270ml', '7891000101926', NULL, 'UNIDADE', 6.97, 10, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000101926');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Nestle Classic Ao Leite 25gr', '7891000312919', NULL, 'UNIDADE', 0, 3, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000312919');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Neston Nestlé 270ml', '7891000090732', NULL, 'UNIDADE', 7.37, 10, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000090732');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Odorizador de Ambiente Chá Branco 360ml', '7896013405238', NULL, 'UNIDADE', 15.9, 23.85, 0, '33074900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896013405238');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Óleo Composto Cebola e Alho Maria 500ml', '7896036096451', NULL, 'UNIDADE', 12.96, 19.99, 0, '07032090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896036096451');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Oleo Composto Faisão 500ml', '7908435501068', NULL, 'UNIDADE', 7.99, 12.99, 0, '15179010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908435501068');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Oleo Composto Olivia 500ml', '7896036098325', NULL, 'UNIDADE', 10.98, 16.5, 0, '15179010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896036098325');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Óleo de soja Vitaliv 900ml', '7898247780297', NULL, 'UNIDADE', 6.19, 10, 0, '15079011', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898247780297');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Omelete C/ Bacon', '206', '020600', 'UNIDADE', 0, 20, 0, '21069090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '206');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Omelete C/ Calabresa', '204', '020400', 'UNIDADE', 0, 20, 0, '21069090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '204');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Omelete C/ Frango', '205', '020500', 'UNIDADE', 0, 20, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '205');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Omelete Calabresa', '204', '020400', 'UNIDADE', 0, 20, 0, NULL, 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '204');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Omelete de Bacon', '206', '020600', 'UNIDADE', 0, 20, 0, NULL, 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '206');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Omelete de Frango', '205', '020500', 'UNIDADE', 0, 20, 0, NULL, 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '205');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Omelete de Peito de Peru e Queijo', '208', '020800', 'UNIDADE', 0, 22, 0, '85061019', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '208');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Omelete Presunto e Queijo', '207', '020700', 'UNIDADE', 0, 16, 0, '21069090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '207');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Omelete Simples', '8019', '801900', 'UNIDADE', 0, 10, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8019');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Óregano Peruano 500g', NULL, NULL, 'pct', 16.9, 0, 1, '09109900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Óregano Peruano 500g');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Óreo Original', '7622300830151', NULL, 'UNIDADE', 3.36, 5, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622300830151');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Oreo sabor chocolate 90g', '7622300873554', NULL, 'UNIDADE', 3.33, 5, 0, '19053100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622300873554');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Original 269ml', '7891991295086', NULL, 'UNIDADE', 0, 4, 0, '22030000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991295086');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ovo', '106', '010600', 'UNIDADE', 0, 1, 0, '04072900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '106');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ovo Mexido', '164', '016400', 'UNIDADE', 0, 5, 0, '21069090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '164');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pá Cabo Longo', '7898311540536', NULL, 'UNIDADE', 3.25, 6.5, 0, '39249000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898311540536');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Paçoca', '7896336005917', NULL, 'UNIDADE', 0, 1, 0, '17049090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896336005917');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Paçocão Irinel Doces 70g', '7891098310019', NULL, 'UNIDADE', 1.1, 2, 0, '17049090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891098310019');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Paçoquinha Dadinho 18g', '7898530843142', NULL, 'UNIDADE', 0, 2.5, 0, '17049090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898530843142');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Paçoquinha Dadinho 20g', '7898530842381', NULL, 'UNIDADE', 0.92, 2.5, 0, '17049010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898530842381');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Palito de Dente C/100 Unid Fiat Lux', '7896007952144', NULL, 'UNIDADE', 0.99, 1.75, 0, '44219900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896007952144');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Palitos de madeira Paraná 100un', '7896080900001', NULL, 'UNIDADE', 0.69, 1.3, 0, '44219900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896080900001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Panetone de Frutas', '51', '005100', 'KG', 0, 14, 0, '19052010', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '51');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'PANETONE PROMOÇAO', '8092', '809200', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8092');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pano de chão Branco', '7898124850020', NULL, 'UNIDADE', 3.9, 6, 0, '63071000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898124850020');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pano de chão Xadrez', '042882906735', NULL, 'UNIDADE', 3.9, 5, 0, '63071000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '042882906735');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'PAO BRIOCHE', '2001', '200100', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '2001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão brioche recheado c/ queijo e', '9085', '908500', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9085');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão C/ 1 Salsicha', '178', '017800', 'UNIDADE', 0, 4.5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '178');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão C/ Mortadela', '156', '015600', 'UNIDADE', 0, 6, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '156');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão Carteira', '388', '038800', 'UNIDADE', 0, 1.5, 0, '19021900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '388');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com 2 Salsichas', '179', '017900', 'UNIDADE', 0, 6, 0, '19023000', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '179');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Contra Filé', '169', '016900', 'UNIDADE', 0, 20, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '169');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Contra Filé e Queijo', '169', '016900', 'UNIDADE', 0, 20, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '169');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com File de Frango', '1992', '199200', 'UNIDADE', 0, 15, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1992');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Filé Mignon, Queijo e Cebola', '168', '016800', 'UNIDADE', 0, 20, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '168');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pao com Linguiça', '154', '015400', 'UNIDADE', 0, 8, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '154');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Linguiça, Queijo e Vinagrete', '170', '017000', 'UNIDADE', 0, 16, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '170');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Manteiga', '148', '014800', 'UNIDADE', 0, 2.5, 0, '22029900', 'st', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '148');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Mortadela', '156', '015600', 'UNIDADE', 0, 6, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '156');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Mortadela e Queijo', '150', '015000', 'UNIDADE', 0, 8.5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '150');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Ovo', '159', '015900', 'UNIDADE', 0, 5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '159');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Ovo e Queijo', '160', '016000', 'UNIDADE', 0, 10, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '160');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'PAO COM OVO E SALADA', '8093', '809300', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8093');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Ovo no Cara', '459', '045900', 'UNIDADE', 0, 5.5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '459');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Polenguinho', '158', '015800', 'UNIDADE', 0, 5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '158');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'PAO COM PRESUNTO', '8099', '809900', 'UNIDADE', 0, 0, 0, '19059020', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8099');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Requeijão', '2108', '210800', 'UNIDADE', 0, 5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '2108');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Requeijão na Entrada', '167', '016700', 'UNIDADE', 0, 8, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '167');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Requeijão na Saida', '166', '016600', 'UNIDADE', 0, 8, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '166');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Salame', '157', '015700', 'UNIDADE', 0, 15, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '157');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão com Salsicha', '178', '017800', 'UNIDADE', 0, 4.5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '178');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Açucar', '222', '022200', 'UNIDADE', 0, 0.8, 0, '19023000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '222');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pao de Acuquinha Empresa', '992', '099200', 'QUILOGRAMA', 21, 21, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '992');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Batata', '3099', '309900', 'UNIDADE', 0, 8, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3099');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de brioche', '5555', '555500', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '5555');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de churros', '9087', '908700', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9087');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de churros c/ recheio', '9084', '908400', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9084');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Coco', '348', '034800', 'UNIDADE', 0, 5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '348');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Coco com Leite Condensado', '464', '046400', 'UNIDADE', 0, 3, 0, '19059010', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '464');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Coco Grande', '386', '038600', 'UNIDADE', 0, 10, 0, '19021900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '386');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Coco Medio', '384', '038400', 'UNIDADE', 0, 5, 0, '19059010', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '384');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Coco Pequeno', '344', '034400', 'UNIDADE', 0.9, 2.5, 0, '19059010', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '344');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pao de Coco Redondo', '536', '053600', 'UNIDADE', 0, 7, 0, '19059010', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '536');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'pão de creme com goiabada', '466', '046600', 'UNIDADE', 0, 0, 0, '19059010', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '466');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Creme Redondo', '347', '034700', 'UNIDADE', 0, 1.5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '347');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Forma', '345', '034500', 'UNIDADE', 0, 6, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '345');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pao de Forma Kim Integral 400g', '7897972001165', NULL, 'UNIDADE', 6.99, 10.5, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897972001165');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'PAO DE FORMA LEITE NINHO', '481', '048100', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '481');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pao de Forma Panco Premium 500g', '7891203010056', NULL, 'UNIDADE', 7.99, 9.9, 0, '19059010', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891203010056');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Forma Pullman 480g', '7896002360326', NULL, 'UNIDADE', 7.02, 10, 0, '19059010', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896002360326');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Forma Seven Boys 450g', '7891193010074', NULL, 'UNIDADE', 4.89, 8.5, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891193010074');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pao de Frango', '253', '025300', 'UNIDADE', 0, 8, 0, '16023220', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '253');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Frios', '258', '025800', 'UNIDADE', 0, 8, 0, '19023000', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '258');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Goiaba', '342', '034200', 'UNIDADE', 0, 1.5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '342');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Hamburguer', '403', '040300', 'QUILOGRAMA', 0, 19, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '403');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'pão de leite', '465', '046500', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '465');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Leite Grande', '385', '038500', 'UNIDADE', 0, 1, 0, '19021900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '385');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pao de Leite Ninho', '341', '034100', 'UNIDADE', 0, 2, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '341');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de leite ninho c/ doce de leite', '9082', '908200', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9082');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'pão de leite ninho recheado', '472', '047200', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '472');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'PAO DE LEITINHO RECHEADO', '1112', '111200', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1112');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Mandioquinha', '405', '040500', 'QUILOGRAMA', 0, 23, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '405');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'PAO DE MEL', '621', '062100', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '621');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Mel Display 44g', '7898910016012', NULL, 'UNIDADE', 2.43, 3.6, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898910016012');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Milho', '13', '001300', 'UNIDADE', 0, 1.5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '13');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Milho C/ Manteiga', '247', '024700', 'UNIDADE', 0, 3, 0, '19023000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '247');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pao de Milho C/ovo', '3041', '304100', 'UNIDADE', 0, 6, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3041');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Milho com Queijo', '362', '036200', 'UNIDADE', 3.5, 12, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '362');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Milho Grande', '340', '034000', 'UNIDADE', 0, 6, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '340');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Milho na Chapa', '460', '046000', 'UNIDADE', 0, 3.5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '460');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'pão de milho navemestra', '424', '042400', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '424');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Queijo', '155', '015500', 'UNIDADE', 0, 4.5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '155');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Queijo de Frango', NULL, NULL, 'kg', 14, 0, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Pão de Queijo de Frango');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Queijo Goiabada', NULL, NULL, 'kg', 34.46, 0, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Pão de Queijo Goiabada');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Queijo Recheado', '39', '003900', 'QUILOGRAMA', 0, 55, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '39');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Queijo Tradicional', '38', '003800', 'kg', 14, 35, 0, '19021900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '38');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão de Salsicha Assado', '1440', '144000', 'UNIDADE', 0, 8, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1440');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão Francês', '224', '022400', 'UNIDADE', 0, 15.99, 0, '19059090', 'isento', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '224');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão Hot Dog', '402', '040200', 'QUILOGRAMA', 0, 19, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '402');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão Integral', '486', '048600', 'QUILOGRAMA', 0, 20, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '486');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão Integral com Manteiga', '151', '015100', 'UNIDADE', 0, 3, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '151');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão Integral na Chapa', '152', '015200', 'UNIDADE', 0, 3.5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '152');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão Mandioquinha Grande', '407', '040700', 'UNIDADE', 0, 5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '407');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão na Chapa', '147', '014700', 'UNIDADE', 0, 3, 0, '19059010', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '147');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão na Chapa com Requeijão', '153', '015300', 'UNIDADE', 0, 8, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '153');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão Petrópolis', '380', '038000', 'UNIDADE', 0, 1.5, 0, '19021900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '380');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão Semi Italiano', '1013', '101300', 'UNIDADE', 0, 10, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1013');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pão Sovado', '401', '040100', 'UNIDADE', 0, 8, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '401');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'pao sovado pequeno', '1034', '103400', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1034');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Aluminio Wyda 4 Metros', '7898930672465', NULL, 'UNIDADE', 3.49, 5.85, 0, '76071110', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898930672465');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Higienico Fofinho 4 Rolos', '7896053410025', NULL, 'UNIDADE', 3.39, 5.5, 0, '48181000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896053410025');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Higiênico Folha Dupla', NULL, NULL, 'fardo', 0, 0, 0, '48181000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Papel Higiênico Folha Dupla');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Higienico Folha Dupla 4 Rolos Dama', '7896076000388', NULL, 'UNIDADE', 6.03, 7.5, 0, '48181000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896076000388');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'PAPEL HIGIENICO FOLHA SIMPLES fofinho c/16', '7896053411626', NULL, 'UNIDADE', 0, 0, 0, '48181000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896053411626');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Higienico Personal Folha Dupla 4 Rolos', '7896110000176', NULL, 'UNIDADE', 7.23, 10, 0, '48181000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896110000176');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Higiênico QUALITÉ 4 Rolos', '7899853800249', NULL, 'UNIDADE', 3.98, 7.5, 0, '48181000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899853800249');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel higienico tropicos 4 rolos', '7898910365028', NULL, 'UNIDADE', 3.93, 5.5, 0, '48181000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898910365028');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Interfolhas', NULL, NULL, 'fardo', 0, 0, 0, '48182000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Papel Interfolhas');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Toalha Econobom', '7897844300730', NULL, 'UNIDADE', 0, 6, 0, '48189090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897844300730');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Toalha Santepel', '7896110012728', NULL, 'UNIDADE', 3.99, 6.5, 0, '48189090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896110012728');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Toalha Soft 2 rolos', '7898329809991', NULL, 'UNIDADE', 2.7, 4.2, 0, '48182000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898329809991');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel Toalha Yuri 2 Rolo', '7896075301080', NULL, 'UNIDADE', 0, 6, 0, '48182000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896075301080');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Papel TV', NULL, NULL, 'FARDO', 82.08, 0, 0, '48182000', 'normal', 'revenda', NULL, 1, 0, 0, 328.32, 4, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Papel TV');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pasta para brilho', NULL, NULL, 'un', 0, 0, 0, '21069090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Pasta para brilho');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pastel de Frango', '1014', '101400', 'UNIDADE', 0, 8, 0, '19022000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1014');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pastel de palmito c/ queijo', '8082', '808200', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8082');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'pastelao', NULL, NULL, 'UNIDADE', 0, 10, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'pastelao');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pastelão', '626', '062600', 'UNIDADE', 0, 10, 0, '19059090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '626');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pastilha Garoto Hortelâ 17g', '78910041', NULL, 'UNIDADE', 1.44, 2, 0, '17049020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78910041');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pate Sabor Peito de Peru Sadia 100g', '7893000025653', NULL, 'UNIDADE', 3.04, 3.7, 0, '16022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7893000025653');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pave C/ Creme de Avela', '3042', '304200', 'UNIDADE', 0, 10, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3042');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pave de Maracuja', '328', '032800', 'UNIDADE', 0, 10, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '328');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pedaço de Bolo', '334', '033400', 'UNIDADE', 0, 2.5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '334');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pedaço de Pudim', '292', '029200', 'UNIDADE', 0, 7, 0, '22029900', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '292');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Peito de Frango', NULL, NULL, 'cx', 15.43, 0, 0, '16023220', 'normal', 'revenda', NULL, 1, 0, 0, 202.5, 15, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Peito de Frango');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Peito de Frango Defumado', '606', '060600', 'QUILOGRAMA', 0, 2.9, 0, '16023290', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '606');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Peito de Peru', '991', '099100', 'KG', 48.18, 72, 0, '16023100', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '991');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Perfex', NULL, NULL, 'PACOTE', 95, 0, 0, '56031290', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Perfex');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picadinho de Carne', '251', '025100', 'UNIDADE', 0, 28, 0, '22029900', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '251');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picole Chocolate Show da Luna', '7896513912731', NULL, 'UNIDADE', 0, 5, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912731');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picole Coco Branco Milkas Kascão', '7896513912069', NULL, 'UNIDADE', 4.47, 6, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912069');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picole Crosh 70gr', '7896513912977', NULL, 'UNIDADE', 6.14, 9, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912977');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picole Frutty Milk 56gr', '7896513912410', NULL, 'UNIDADE', 0, 5.5, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912410');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picole Kascão Brigadeiro de Colher 65gr', '7896513912038', NULL, 'UNIDADE', 6.41, 9, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912038');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picole Kascao Skimo', '7896513912007', NULL, 'UNIDADE', 6.41, 9, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912007');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picole Limão Kascão 58gr', '7896513912205', NULL, 'UNIDADE', 3.15, 6, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912205');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picole Mask Cookies 65gr', '7896513912397', NULL, 'UNIDADE', 11.66, 16, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912397');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picole Mask Trufaz 65gr', '7896513912557', NULL, 'UNIDADE', 0, 15, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912557');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picole Milk Algodão Doce 40gr', '7896513912540', NULL, 'UNIDADE', 0, 3, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912540');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picole Milk Kascão 40gr', '7896513912984', NULL, 'UNIDADE', 0, 3, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912984');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picolé Natural Açai 58gr', '7896513909168', NULL, 'UNIDADE', 0, 5.5, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513909168');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picolé Pinta Língua Azul Kascao 58g', '7896513912779', NULL, 'UNIDADE', 3.36, 5.5, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912779');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picole Trek 60gr', '7896513912755', NULL, 'UNIDADE', 6.14, 9, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912755');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Picole Uva Kascão 58gr', '7896513912359', NULL, 'UNIDADE', 3.15, 6, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912359');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pilha AA PANASONIC', '8002', '800200', 'UNIDADE', 1.25, 1.8, 0, '85061020', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8002');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pilha AAA 2 duracell c/ 2', '041333050812', NULL, 'UNIDADE', 0, 8, 0, '85061020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '041333050812');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pilha Alcalina AA8X', NULL, NULL, 'pct', 9.57, 0, 0, '85061020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Pilha Alcalina AA8X');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pilha Alcalina AAA', '7896067203040', NULL, 'UNIDADE', 9.57, 15, 0, '85061020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896067203040');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pilha Duracell', '041333050850', NULL, 'UNIDADE', 0, 16, 0, '85061020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '041333050850');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pilha Palito Unidade', '142', '014200', 'UNIDADE', 2.24, 2, 0, '85061019', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '142');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pilha Panasonic Aaa C/4', '7896067203033', NULL, 'UNIDADE', 10.49, 15, 0, '85061020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896067203033');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pinça', '9009', '900900', 'UNIDADE', 0.99, 2, 0, '82141000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9009');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pingo de Leite', '10001', NULL, 'UNIDADE', 0, 1, 0, '19019020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '10001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pipoca de Microondas Sabor Natural Kisabor 100g', '7898416527104', NULL, 'UNIDADE', 2.79, 4.5, 0, '20081900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898416527104');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pipoca Emilia', '7898667960125', NULL, 'PACOTE', 0, 3.5, 0, '19041000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898667960125');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'PIRULITO DE CORACAO', '260', '026000', 'UNIDADE', 0, 0.5, 0, '17049090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '260');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pirulito Diploko Mola', '7898964630929', NULL, 'UNIDADE', 0, 2.75, 0, '17049090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898964630929');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pizza', '37', '003700', 'UNIDADE', 0, 10, 0, '19023000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '37');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pizza Folheada', '467', '046700', 'UNIDADE', 0, 8, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '467');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pó Royal 100g', '7622300119621', NULL, 'UNIDADE', 4.99, 7.5, 0, '21023000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622300119621');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Polenguinho Tradicional', '7891143017887', NULL, 'UNIDADE', 75.5, 2.5, 0, '04061090', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891143017887');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Porção de Batata Frita 300gr', '298', '029800', 'QUILOGRAMA', 0, 20, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '298');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Porção de Calabresa 200gr', '212', '021200', 'UNIDADE', 0, 20, 0, '16010000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '212');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Porção de Contra File 200gr', '213', '021300', 'UNIDADE', 0, 30, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '213');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Porção de Presunto (150gr em Cubos)', '210', '021000', 'UNIDADE', 0, 15, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '210');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Porção de Queijo (150gr em Cubos)', '209', '020900', 'UNIDADE', 0, 15, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '209');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Porção de Salame 150gr', '211', '021100', 'UNIDADE', 0, 20, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '211');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Powerade Azul Mix de Frutas 500ml', '7894900504002', NULL, 'UNIDADE', 3.57, 5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900504002');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Powerade Limão 500ml', '7894900500035', NULL, 'UNIDADE', 3.57, 6, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900500035');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Powerade Sabor Laranja 500ml', '7894900503029', NULL, 'UNIDADE', 3.57, 6, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900503029');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Powerade Uva 500ml', '7894900501001', NULL, 'UNIDADE', 3.57, 6, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900501001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pré Mistura Montagner', NULL, NULL, 'KG', 92, 0, 0, '19012090', 'normal', 'revenda', NULL, 1, 0, 0, 88, 25, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Pré Mistura Montagner');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Presilha brilhosa un', '7081', '708100', 'UNIDADE', 0, 0, 0, '96151900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7081');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Prestigio 33g', '7891000460207', NULL, 'UNIDADE', 2.51, 3.5, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000460207');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Prestigio Frutas Vermelhas 33g', '7891000454589', NULL, 'UNIDADE', 2.29, 3.5, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000454589');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Prestobarba Gilette Ultra Azul Un', '7500435154420', NULL, 'UNIDADE', 2.28, 5, 0, '82121020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7500435154420');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Presunto', '976', '097600', 'KG', 18.8, 39, 10, '16024100', 'normal', 'revenda', NULL, 1, 1, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '976');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pringles Cheddar e Bacon', '7896004008998', NULL, 'UNIDADE', 0, 14.99, 0, '20052000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896004008998');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pringles Original', '7896004006277', NULL, 'UNIDADE', 0, 16, 0, '20052000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896004006277');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Promoção', NULL, '302600', 'KG', 0, 0.5, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Promoção');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Protetor Diário Intimus 40un', '7896007550548', NULL, 'PACOTE', 14.9, 17.5, 0, '96190000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896007550548');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pudim de Leite Condensad', '20', '002000', 'UNIDADE', 0, 6, 0, '19021900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '20');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'pudim pedaço', '324', '032400', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '324');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'PUDIM TAMANHO G', '3004', '300400', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3004');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'PUDIM TAMANHO M', '3005', '300500', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3005');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'pulseira infantil', '6071', '607100', 'UNIDADE', 0, 0, 0, '71179000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6071');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Pururuca Sabor Bacon 60g', '7898021631319', NULL, 'UNIDADE', 1.98, 3.5, 0, '16024900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898021631319');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Queijadinha', '523', '052300', 'UNIDADE', 0, 5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '523');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'queijo', '160', '016000', 'QUILOGRAMA', 0, 0, 0, '04061090', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '160');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Queijo Frio', '485', '048500', 'UNIDADE', 0, 12, 0, '16022000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '485');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Queijo Litoral', NULL, NULL, 'UNIDADE', 33.2, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Queijo Litoral');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Queijo Prato', '960', '096000', 'KG', 43.5, 59, 0, '04069020', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '960');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Queijo prato DiMinas', '960', '096000', 'KG', 43.5, 59, 0, '04061090', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '960');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Queijo Quente', '145', '014500', 'UNIDADE', 0, 12, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '145');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Queijo Ralado Parmesão Itambé 50g', '7896051165491', NULL, 'UNIDADE', 4.59, 6.99, 0, '04062000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896051165491');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ração BONZO para cães 1 kg', '1133', '113300', 'UNIDADE', 7.99, 0, 0, '23091000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1133');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Ração BONZO para cães 500g', '1134', '113400', 'UNIDADE', 3.99, 0, 0, '23091000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1134');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Raçao para cachorro adulto CHAMP 500g', '1137', '113700', 'UNIDADE', 2.72, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1137');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Raçao para cachorro CHAMP 1k', '1136', '113600', 'UNIDADE', 5.44, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1136');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Red Bull 250ml', '611269991000', NULL, 'UNIDADE', 6.19, 12, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '611269991000');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Refrigerante Guaraná Antarctica 2,5l', '7891991008655', NULL, 'UNIDADE', 6.94, 9.99, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991008655');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Requeijão Cremoso Cremilli', NULL, NULL, 'cx', 11.86, 0, 0, '04061010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Requeijão Cremoso Cremilli');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Requeijão Frutap 380g', '7896862003098', NULL, 'UNIDADE', 14.29, 20, 2, '04061090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896862003098');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Requeijão Supremo 400g', '7898217001872', NULL, 'UNIDADE', 11.9, 16, 0, '04061090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898217001872');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Requeijão Tirolez 200g', '7896030518027', NULL, 'UNIDADE', 9.9, 14, 0, '04061090', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896030518027');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Requeijão Tirolez 400g', '7896030521690', NULL, 'UNIDADE', 8.1, 13, 0, '04061010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896030521690');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Risole de Carne', '238', '023800', 'UNIDADE', 0, 8, 0, '19023000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '238');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Risole de Carne Seca', '239', '023900', 'UNIDADE', 0, 9, 0, '19023000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '239');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rocambole de Chocolate', '531', '053100', 'QUILOGRAMA', 0, 30, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '531');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'ROCAMBOLE DE DOCE DE LEITE', '478', '047800', 'KG', 0, 30, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 7, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '478');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rocambole de Goiabada', '400', '040000', 'QUILOGRAMA', 0, 30, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '400');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rodo Pequeno', '7897788822022', NULL, 'UNIDADE', 6.3, 9.99, 0, '96039000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897788822022');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rosquinha de Chocolate', '784', '078400', 'UNIDADE', 0, 1.5, 0, '19021900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '784');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rosquinha de Chocolate Mabel 300g', '7896071030014', NULL, 'UNIDADE', 4.39, 6.75, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896071030014');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rosquinha de Chocolate Rancheiro 300g', '7896253401472', NULL, 'UNIDADE', 4.27, 6.75, 0, '19053100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896253401472');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rosquinha de Coco Mabel 300g', '7896071030007', NULL, 'UNIDADE', 4.39, 6.75, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896071030007');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rosquinha de coco Mabel 500g', '7896071021548', NULL, 'UNIDADE', 4.96, 7.99, 0, '19053100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896071021548');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rosquinha Doce', '382', '038200', 'UNIDADE', 0, 2, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '382');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rothmans double click Max melancia', '78947580', NULL, 'UNIDADE', 8.4, 13, 0, '02012020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947580');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rothmans global red/vermelho', '78944220', NULL, 'UNIDADE', 6.92, 13, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78944220');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rothmans global red/vermelho novo', '78947627', NULL, 'UNIDADE', 0, 11, 0, '02012020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947627');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rothmans inter double click melancia', '78943087', NULL, 'UNIDADE', 9.23, 15, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78943087');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rothmans internacional blue', '78942806', NULL, 'UNIDADE', 9.92, 14, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78942806');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rothmans Red of London maço', '78944527', NULL, 'UNIDADE', 0, 12, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78944527');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Rothmans selec core blue', '78944541', NULL, 'UNIDADE', 8.43, 12, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78944541');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabão em Barra Minuano', '7908324402865', NULL, 'UNIDADE', 9.9, 16.2, 0, '34011900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908324402865');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabão em Barra Neutro', '58', '005800', 'UNIDADE', 0, 3.5, 0, '34011900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '58');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabão em Pó Omo 800g', '7891150064317', NULL, 'UNIDADE', 9.98, 16.99, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891150064317');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabão em Pó Tixan 400g', '7896098909737', NULL, 'UNIDADE', 5.28, 8.5, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896098909737');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabão em pó Tixan ypê 400g  XMax', '7896098909720', NULL, 'UNIDADE', 5.28, 8.5, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896098909720');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabão em pó Tixan ypê 800g', '7896098909751', NULL, 'UNIDADE', 8.95, 13.5, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896098909751');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabão Liquido 2 litros', '2000000003122', NULL, 'UNIDADE', 8.89, 13, 0, '34013000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '2000000003122');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabonete em Barra Argila Preta Palmolive 85g', '7509546695389', NULL, 'UNIDADE', 2.09, 3.25, 0, '34011190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7509546695389');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabonete flor maça e framboesa 85gr', '7896098902233', NULL, 'UNIDADE', 1.02, 2.6, 0, '34011190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896098902233');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabonete Gardenia e Oleo de Amendoas Lux 85g', '7891150095304', NULL, 'UNIDADE', 2.39, 3.5, 0, '34011190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891150095304');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabonete Manteiga de Cacau Palmolive 85g', '7891024034880', NULL, 'UNIDADE', 2.09, 3.25, 0, '34011190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891024034880');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabonete Maracujá Albany 80g', '7908324410167', NULL, 'UNIDADE', 1.89, 3, 0, '34011190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908324410167');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sabonete Melancia Albany 80g', '7908324410174', NULL, 'UNIDADE', 1.89, 3, 0, '34011190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908324410174');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Saco de Farinha', '3039', '303900', 'UNIDADE', 0, 1, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3039');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Saco de Lixo médio', NULL, NULL, 'fardo', 20.8, 0, 0, '39232190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Saco de Lixo médio');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Saco Picotado', NULL, NULL, 'cx', 0, 0, 0, '39232190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Saco Picotado');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sacola Dia dos Pais', NULL, NULL, 'FARDO', 0, 0, 0, '39232190', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Sacola Dia dos Pais');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sal Cisne', '7896035210001', NULL, 'PACOTE', 0, 3.5, 0, '25010020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896035210001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sal Grosso Cisne', '7896035210018', NULL, 'PACOTE', 0, 6.3, 0, '25010020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896035210018');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sal Grosso Cisne 1kg', '7896035210018', NULL, 'UNIDADE', 4.19, 6.3, 0, '25010020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896035210018');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sal Grosso Lebre', '7896110100814', NULL, 'UNIDADE', 2.59, 4.6, 0, '25010020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896110100814');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sal Lebre', NULL, NULL, 'KG', 2.99, 3.99, 0, '25010020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Sal Lebre');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sal Lebre 1kg', '7896110100043', NULL, 'UNIDADE', 2.99, 3.99, 0, '25010020', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896110100043');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Salame', '984', '098400', 'UNIDADE', 59.73, 99, 0, '16010000', 'normal', 'revenda', NULL, 0, 0, 0, 371.11, 5.6, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '984');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Salgadinho Assado Cebolitos 45g', '7892840822811', NULL, 'UNIDADE', 0, 5, 0, '19041000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840822811');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Salgadinho Fandangos Queijo Elma Chips 35g', '7892840822866', NULL, 'UNIDADE', 3.79, 5, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840822866');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'SALGADINHO FRITO', '9056', '905600', 'QUILOGRAMA', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9056');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Salgado de Brocolis', '2020', '202000', 'UNIDADE', 0, 8, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '2020');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Salgado de Calabresa', '240', '024000', 'UNIDADE', 0, 8, 0, '19023000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '240');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Salgado Maravilha', '236', '023600', 'UNIDADE', 0, 8, 0, '19023000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '236');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Salsicha', NULL, '307', 'cx', 19.9, 0, 0, '16010000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Salsicha');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Salsicha (Mercado do Jota)', NULL, '25', 'cx', 19.9, 0, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Salsicha (Mercado do Jota)');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Saquinho de Talheres', NULL, NULL, 'cx', 22.36, 0, 0, '39241000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Saquinho de Talheres');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sardinha c/ oleo Robinson crusoe 75g', '7898943163011', NULL, 'UNIDADE', 5.29, 8, 0, '16041310', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898943163011');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sardinha com Oleo Comestivel Sulpesca 125g', '7896117101036', NULL, 'UNIDADE', 4.99, 7.5, 0, '16041310', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896117101036');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sardinha Enlatada em Oleo Coqueiro 175g', '7896009301049', NULL, 'UNIDADE', 5.99, 7.5, 0, '16041310', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896009301049');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sardinha enlatada Robinson Crusué', '789943163011', NULL, 'UNIDADE', 5.79, 8.5, 0, '16041310', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '789943163011');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sardinha Molho de Tomate Sulpesca 125g', '7896117101043', NULL, 'UNIDADE', 4.99, 7.5, 0, '16041310', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896117101043');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sardinha Pescador 125gr', '7896114901738', NULL, 'UNIDADE', 5.39, 7.5, 0, '16041310', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896114901738');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sbp Multinseticida 380ml', '7891035618567', NULL, 'UNIDADE', 12.39, 18.75, 0, '38089119', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891035618567');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Schweppes 1,5L', '7894900180541', NULL, 'UNIDADE', 7.3, 10.99, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900180541');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Schweppes Citrus 350ml', '7894900180503', NULL, 'UNIDADE', 2.91, 6, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900180503');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Secar Lavanda de Paris', '7896013404682', NULL, 'UNIDADE', 0, 17.85, 0, '33074900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896013404682');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Seda solta', '420', '042000', 'UNIDADE', 0.2, 0.5, 0, '33059000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '420');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'sequilho', '473', '047300', 'QUILOGRAMA', 0, 0, 0, '19053100', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '473');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'SINAL DE MERCADORIA', '3040', '304000', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3040');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Snow Flakes 120g', '7891000050880', NULL, 'PACOTE', 5.77, 8.5, 0, '19041000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000050880');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sonho de Chocolate', '507', '050700', 'UNIDADE', 0, 4, 0, '19023000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '507');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sonho de Creme', '378', '037800', 'UNIDADE', 0.98, 4, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '378');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sonho de Doce de Leite', '435', '043500', 'UNIDADE', 0, 4, 0, '21050010', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '435');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sonrisal ', '7896090611607', NULL, 'UNIDADE', 0, 5, 0, '30049029', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896090611607');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sorvete Alegria Copo Brigadeiro 100gr', '7896513916104', NULL, 'UNIDADE', 0, 5.5, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513916104');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sorvete Bombom de Doce de Leite Antonelli 105g', '7896513910065', NULL, 'UNIDADE', 13.25, 19.9, 0, '19059090', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513910065');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sorvete Bombom de Pistache Antonelli 105g', '7896513910058', NULL, 'UNIDADE', 13.25, 19.9, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513910058');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sorvete Chocotella Kascão 715g', '7896513915336', NULL, 'UNIDADE', 0, 36.9, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513915336');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sorvete Copão Alegria Napolitano 150gr', '7896513940093', NULL, 'UNIDADE', 7.35, 10.5, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513940093');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sorvete de 1,5 Coco Kascão', '7896513915107', NULL, 'UNIDADE', 0, 29.9, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513915107');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sorvete de Flocos Alegria 150g', '7896513940017', NULL, 'UNIDADE', 7.89, 10.5, 0, '21050010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513940017');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sorvete Flocos 100gr', '7896513916012', NULL, 'UNIDADE', 0, 5.5, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513916012');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sorvete Kascão Flocos 1,5l', '7896513915237', NULL, 'UNIDADE', 25.06, 32.9, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513915237');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sorvete Kascão Napolitano 1,5l', '7896513915220', NULL, 'UNIDADE', 25.06, 32.9, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513915220');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sorvete Picolé Mask 65gr', '7896513912717', NULL, 'UNIDADE', 11.66, 16, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912717');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sorvete Potão Brigadeiro 150gr Brigadeiro', '7896513940178', NULL, 'UNIDADE', 0, 10.5, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513940178');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sorvete Pote 1,5 Passas Ao Rum', '7896513915251', NULL, 'UNIDADE', 0, 30.9, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513915251');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sprite 2 Litros', '7894900681000', NULL, 'UNIDADE', 8.29, 13, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900681000');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sprite 200ml', '78939745', NULL, 'UNIDADE', 0, 3, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78939745');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sprite 220ml Lata', '7894900681178', NULL, 'UNIDADE', 1.67, 3.5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900681178');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sprite 350ml Lata', '7894900681017', NULL, 'UNIDADE', 2.48, 6, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900681017');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sprite Ks', '7894900065206', NULL, 'UNIDADE', 0, 5, 0, '22021000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900065206');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sprite Ks 290ml', '135', '013500', 'UNIDADE', 0, 5, 0, '22011000', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '135');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sprite Lemon Fresh 1,5ml', '7894900680522', NULL, 'UNIDADE', 0, 8.5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900680522');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sprite Lemon Fresh 510ml', '7894900680508', NULL, 'UNIDADE', 2.52, 5, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900680508');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sprite Zero Açucar 2l', '7894900061512', NULL, 'UNIDADE', 8.29, 13, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900061512');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sprite zero caçulinha', '78938601', NULL, 'UNIDADE', 0, 3, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78938601');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Abacaxi', '3052', '305200', 'UNIDADE', 0, 10, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3052');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Abacaxi C/ Hortela', '3056', '305600', 'UNIDADE', 0, 10, 0, '20091900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3056');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Acerola', '3055', '305500', 'UNIDADE', 0, 10, 0, '20091900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3055');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Caju', '3057', '305700', 'UNIDADE', 0, 10, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3057');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Frutas Vermelhas', '6000', '600000', 'UNIDADE', 3.09, 10, 0, '22029900', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6000');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Garrafa Sabores', '463', '046300', 'UNIDADE', 0, 13, 0, '22029900', 'st', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '463');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Goiaba', '3051', '305100', 'UNIDADE', 0, 10, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3051');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de laranja 1 litro', '111', '011100', 'LITRO', 0, 26, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '111');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Laranja com Morango', '3048', '304800', 'UNIDADE', 0, 15, 0, '20091900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3048');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Laranja Natural', '3049', '304900', 'UNIDADE', 0, 11, 0, '20091200', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3049');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Limao Natural', '3050', '305000', 'UNIDADE', 0, 11, 0, '20091900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3050');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Manga', '6001', '600100', 'UNIDADE', 0, 10, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Maracuja', '3062', '306200', 'UNIDADE', 0, 14, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3062');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Morango', '3054', '305400', 'CAIXA', 0, 10, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3054');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco de Uva', '6002', '600200', 'UNIDADE', 0, 10, 0, '20096100', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6002');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco Del Valle Pêssego 200ml', '7894900660425', NULL, 'UNIDADE', 2.01, 3.5, 0, '22029900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900660425');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco Marata 1 Litro Sabor Acerola', '7898378180751', NULL, 'UNIDADE', 4.66, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180751');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco Marata 1 Litro Sabor Caju', '7898378180058', NULL, 'UNIDADE', 4.4, 8, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180058');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco Marata 200ml Sabor Maracuja', '7898378180447', NULL, 'UNIDADE', 1.48, 2.75, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180447');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco prats laranja 300ml', '7898953148701', NULL, 'UNIDADE', 5.45, 9.75, 0, '20091900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898953148701');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco Prats Uva 300ml', '7898953148718', NULL, 'UNIDADE', 6.75, 9.8, 7, '20096100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898953148718');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco Qualimax Uva 15g', '7891122124018', NULL, 'UNIDADE', 0.78, 1, 0, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891122124018');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco Sabor Limonada Fazenda Bela Vista 300ml', '7896229800872', NULL, 'UNIDADE', 3.99, 6, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896229800872');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco Sabor Uva Natural One 180ml', '7899916906031', NULL, 'UNIDADE', 2.99, 4.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899916906031');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco Uva Natural One 180ml', '7899916906031', NULL, 'UNIDADE', 2.99, 4.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899916906031');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suco Uva The Natural One 300ml', '7899916904716', NULL, 'UNIDADE', 4.99, 7.5, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899916904716');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Suflair Chocolate Ao Leite 50g', '7891000455722', NULL, 'UNIDADE', 5.64, 8.5, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000455722');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Sundae Kascão Chocolate 85g', '7896513915152', NULL, 'UNIDADE', 5.52, 7.5, 0, '21050010', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513915152');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Surpresa 20g', '7891000408490', NULL, 'UNIDADE', 0, 4, 0, '18063110', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000408490');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Surpresa de Uva', '327', '032700', 'UNIDADE', 0, 8, 0, '19019090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '327');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'SURPRESA DE UVA TAMANHO G', '3006', '300600', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3006');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tang Manga 18g', '7622210571526', NULL, 'UNIDADE', 0.99, 2, 0, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571526');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tang Sabor Abacaxi', '7622210571755', NULL, 'UNIDADE', 0.97, 2, 0, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571755');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tang Sabor Goiaba', '7622210571496', NULL, 'UNIDADE', 0.89, 2, 0, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571496');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tang Sabor Laranja', '7622210571601', NULL, 'UNIDADE', 1.04, 2, 0, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571601');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tang Sabor Limão', '7622210571540', NULL, 'UNIDADE', 0.99, 2, 0, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571540');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tang Sabor Maracuja', '7622210571694', NULL, 'UNIDADE', 0.97, 2, 0, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571694');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tang Sabor Morango', '7622210571724', NULL, 'UNIDADE', 0.97, 2, 0, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571724');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tang Sabor Tangerina', '7622210571632', NULL, 'UNIDADE', 0.89, 2, 0, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571632');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tang Sabor Uva 18g', '7622210571786', NULL, 'UNIDADE', 0.99, 2, 0, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571786');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tang Sabor Uva Intenso 18g', '7622210571663', NULL, 'UNIDADE', 0.89, 2, 0, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571663');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tang Uva', '7622210571786', NULL, 'UNIDADE', 1.04, 2, 0, '21069010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571786');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tapioca Calabresa com Queijo', '180', '018000', 'UNIDADE', 0, 14, 0, '19030000', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '180');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tapioca com Manteiga', '184', '018400', 'UNIDADE', 0, 7, 0, '19030000', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '184');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tapioca com Ovo', '8097', '809700', 'UNIDADE', 0, 10, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8097');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tapioca com Requeijão', '186', '018600', 'UNIDADE', 0, 8, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '186');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tapioca da Terrinha 1kg', '7898994081630', NULL, 'UNIDADE', 7.98, 15, 0, '19030000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898994081630');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tapioca da Terrinha 500gr', '7898994081623', NULL, 'UNIDADE', 4.59, 8, 0, '19030000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898994081623');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tapioca de frango', '181', '018100', 'UNIDADE', 0, 15, 0, '19030000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '181');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tapioca Frango com Queijo', '181', '018100', 'UNIDADE', 0, 15, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '181');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tapioca Peito de Peru e Mussarela', '183', '018300', 'UNIDADE', 0, 13, 0, '21069090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '183');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tapioca Presunto e Mussarela', '182', '018200', 'UNIDADE', 0, 13, 0, '21069090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '182');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tek Bond 2g', '7898904869044', NULL, 'UNIDADE', 1.29, 3.5, 0, '35061010', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898904869044');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tempero Maggi  114g', '7891000251539', NULL, 'UNIDADE', 2.47, 6, 0, '21041011', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000251539');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tempero Sazon Carne 60g', '7891132019281', NULL, 'UNIDADE', 5.58, 8.5, 0, '21039021', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891132019281');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tempero Sazón Feijão 60g', '7891132019724', NULL, 'UNIDADE', 4.59, 8.5, 0, '09109900', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891132019724');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tesoura Escolar', '70', '007000', 'UNIDADE', 0, 4, 0, '82130000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '70');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tixan ypê Xmax Primavera 700g', '7896055510594', NULL, 'UNIDADE', 6.99, 10.5, 0, '34025000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896055510594');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Toddynho 200ml', '7894321722016', NULL, 'UNIDADE', 2.75, 3.99, 0, '22029900', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894321722016');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tonica Antarctica Lata 350ml', '7891991000840', NULL, 'UNIDADE', 5.09, 6, 0, '22021000', 'st', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991000840');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Torrada Integral', '493', '049300', 'QUILOGRAMA', 10, 0, 0, '19054000', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '493');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Torrada Simples', '404', '040400', 'QUILOGRAMA', 0, 14.99, 0, '19054000', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '404');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'TORTA DE ALPINO TAMANHO G', '3010', '301000', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3010');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'TORTA DE COOKIE', '3031', '303100', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3031');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'TORTA DE KINDER BUENO', '3009', '300900', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3009');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Torta de limão com merengue', '314', '031400', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '314');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'TORTA DE LIMAO TAMANHO G', '3003', '300300', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3003');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'TORTA DE LIMAO TAMANHO M', '3002', '300200', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3002');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'TORTA DE MARACUJA C/ BRIGADEIRO T G', '3011', '301100', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3011');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'TORTA DE MORANGO TAMANHO G', '3001', '300100', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'TORTA DE MORANGO TAMANHO M', '3000', '300000', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3000');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'TORTA DE NINHO C/ NUTELLA TAMANHO G', '3012', '301200', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3012');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'TORTA DE OREO TAMANHO G', '3008', '300800', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3008');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Torta de Pistache Fatia', '1117', '111700', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1117');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'TORTA HOLANDESA TAMANHO G', '3015', '301500', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3015');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Torta liquidificador de Carne seca', '4040', '404000', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4040');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Torta maracuja com brigadeiro', '323', '032300', 'UNIDADE', 0, 0, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '323');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Torta salgada tamanho G', '30', '003000', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '30');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'TORTILETE', '4020', '402000', 'UNIDADE', 0, 0, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4020');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tortinha de Limão', '453', '045300', 'UNIDADE', 0, 8, 0, '19052090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '453');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Tortinha de Morango', '313', '031300', 'UNIDADE', 0, 8, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '313');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trakinas Chocolate 126gr', '7622210592750', NULL, 'UNIDADE', 2.66, 3.5, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210592750');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trakinas Meio a Meio 126g', '7622210592668', NULL, 'UNIDADE', 2.66, 3.5, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210592668');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trakinas Morango 126gr', '7622210592781', NULL, 'UNIDADE', 2.66, 3.5, 0, '19053100', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210592781');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trakinas sabor meio a meio 120g', '7622210592637', NULL, 'UNIDADE', 2.12, 3.5, 0, '19053100', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210592637');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trident Canela', '7895800304235', NULL, 'UNIDADE', 1.78, 3, 0, '21069050', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895800304235');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trident Hortela sem Açucar', '7895800304211', NULL, 'UNIDADE', 1.8, 3, 0, '21069050', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895800304211');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trident Melancia', '7895800309780', NULL, 'UNIDADE', 1.78, 3, 0, '21069050', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895800309780');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trident Menta', '7895800304228', NULL, 'UNIDADE', 1.78, 3, 0, '21069050', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895800304228');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trident Morango', '7895800201503', NULL, 'UNIDADE', 1.8, 3, 0, '21069050', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895800201503');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trident Tutti Fruit', '7895800430002', NULL, 'UNIDADE', 1.76, 3, 0, '21069050', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895800430002');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trident X Senses Cereja Ice', '7622210564337', NULL, 'UNIDADE', 1.9, 3, 0, '21069050', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210564337');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trident X Senses Herbal', '7622210564313', NULL, 'UNIDADE', 1.8, 3, 0, '17041000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210564313');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trident X Senses Intense', '7622210564290', NULL, 'UNIDADE', 1.9, 3, 0, '21069050', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210564290');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trident Xsenses', '7622210573261', NULL, 'UNIDADE', 0, 13.5, 0, '21069050', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210573261');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trident Xsenses Melancia', '7622210570376', NULL, 'UNIDADE', 0, 13.5, 0, '21069050', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210570376');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trouxinha de Ameixa', '449', '044900', 'UNIDADE', 0, 5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '449');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trouxinha de Banana', '450', '045000', 'UNIDADE', 0, 5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '450');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Trouxinha de Goiabada', '462', '046200', 'UNIDADE', 0, 5, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '462');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Unhex G', '6089', '608900', 'UNIDADE', 1.83, 5, 0, '82142000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '6089');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Unhex P', '001', '000100', 'UNIDADE', 1.2, 3, 0, '82142000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Uva Passa sem Sementes', NULL, NULL, 'KG', 0, 0, 0, '08062000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Uva Passa sem Sementes');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vassoura bell', '7898311540031', NULL, 'UNIDADE', 8.29, 12.5, 0, '96039000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898311540031');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vela de aniversario interrogação branca Junco', '7896523107578', NULL, 'UNIDADE', 4.9, 7.35, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896523107578');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vela de aniversário n.0 Junco', '7896523107462', NULL, 'UNIDADE', 4.9, 7.35, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896523107462');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vela de aniversario n.1 Junco', '7896523163437', NULL, 'UNIDADE', 4.9, 7.35, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896523163437');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vela de aniversario n.2 Junco', '7896523107486', NULL, 'UNIDADE', 4.9, 7.35, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896523107486');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vela de aniversario n.5 Junco', '7896523107516', NULL, 'UNIDADE', 4.9, 7.35, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896523107516');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vela de aniversario n.6 Junco', '7896523158761', NULL, 'UNIDADE', 4.9, 7.35, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896523158761');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vela de aniversario n.7 Junco', '7896523158808', NULL, 'UNIDADE', 4.9, 7.35, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896523158808');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vela de aniversario n.8 Junco', '7896523107547', NULL, 'UNIDADE', 4.9, 7.35, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896523107547');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vela de aniversario n.9 Junco', '7896523158884', NULL, 'UNIDADE', 4.9, 7.35, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896523158884');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'VELA INTERROG BRANCA', '7897284230420', NULL, 'UNIDADE', 0, 0, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897284230420');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vela interrogação puro glitter dourado', '7899348576178', NULL, 'UNIDADE', 6.95, 10, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899348576178');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vela interrogação puro glitter prata', '7899348576284', NULL, 'UNIDADE', 6.96, 10, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899348576284');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'VELA LUZ DIVINA N 8 BR', '7896017461803', NULL, 'UNIDADE', 7.88, 12, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896017461803');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vela PRATA c/ 8un número 2', '7896017470201', NULL, 'UNIDADE', 2.99, 4.5, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896017470201');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'vela santa cruz c/ 8 unid 17gr', '7896302100028', NULL, 'UNIDADE', 5.69, 8.5, 0, '34060000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896302100028');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Velho barreiro Dose', '417', '041700', 'UNIDADE', 0, 0, 0, '22084000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '417');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vinagre Vitalia 750ml', '7896048284631', NULL, 'UNIDADE', 1.31, 2.5, 0, '22090000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896048284631');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Virado a Paulista', '470', '047000', 'UNIDADE', 0, 28, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '470');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vitamina de Abacate', '3060', '306000', 'UNIDADE', 0, 14, 0, '21069030', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3060');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vitamina de Banana', '3058', '305800', 'UNIDADE', 0, 12, 0, '20091900', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3058');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vitamina de Mamao', '3059', '305900', 'UNIDADE', 0, 14, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3059');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vitamina de Morango', '3061', '306100', 'UNIDADE', 0, 14, 0, '20099000', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3061');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Vitamina Mista', '491', '049100', 'UNIDADE', 0, 17, 0, '21069090', 'normal', 'revenda', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '491');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Wafer Bono de Limão', '7891000329207', NULL, 'UNIDADE', 3.43, 5, 0, '19053200', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000329207');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Wafer Negresco 110g', '7891000077962', NULL, 'UNIDADE', 3.43, 5, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000077962');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Wafer Nescau 110g', '7891000364253', NULL, 'UNIDADE', 3.43, 5, 0, '18069000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000364253');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Wafer Nestlé Chocolate 110g', '7891000077948', NULL, 'UNIDADE', 3.43, 5, 0, '19053200', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000077948');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Waffer Bono Chocolate 110g', '7891000372586', NULL, 'UNIDADE', 3.43, 5, 0, '19053200', 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000372586');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Winston Blue', '78943360', NULL, 'UNIDADE', 0, 11, 0, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78943360');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Winston classic', '78943353', NULL, 'UNIDADE', 7.36, 11, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78943353');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Winston silver', '78939103', NULL, 'UNIDADE', 7.36, 12, 0, '24022000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78939103');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'X -  Burguer', '172', '017200', 'UNIDADE', 0, 12, 0, '16025000', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '172');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'X - Bacon', '174', '017400', 'UNIDADE', 0, 20, 0, '02101200', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '174');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'X - Calabresa', '175', '017500', 'UNIDADE', 0, 20, 0, '16010000', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '175');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'X - Egg', '173', '017300', 'UNIDADE', 0, 17, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '173');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'X - Frango', '176', '017600', 'UNIDADE', 0, 20, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '176');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'X - Salada', '171', '017100', 'UNIDADE', 0, 15, 0, '19059090', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '171');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'X - Tudo', '177', '017700', 'UNIDADE', 0, 30, 0, '16025000', 'normal', 'propria', NULL, 0, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '177');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'X-Salada', '371', '037100', 'UNIDADE', 0, 15, 0, NULL, 'normal', 'propria', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '371');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Xamego Bom', NULL, NULL, 'bd', 62.19, 0, 1, NULL, 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND (codigo_barras IS NULL OR codigo_barras = '') AND nome = 'Xamego Bom');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Yakult 80g', '78911000', NULL, 'UNIDADE', 0, 2.7, 0, '04039000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78911000');
INSERT INTO produtos (padaria_id, nome, codigo_barras, codigo_balanca, unidade, custo_unitario, preco_venda, estoque_minimo, ncm, situacao_icms, origem_producao, cest, controla_estoque, venda_rapida, validade_dias, embalagem_preco, embalagem_qtd, estoque_atual, ativo)
SELECT 2, 'Zomo ', '78420274', NULL, 'UNIDADE', 1.5, 4, 0, '48131000', 'normal', 'revenda', NULL, 1, 0, 0, NULL, NULL, 0, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78420274');
-- Completa NCM / codigo de balanca / CEST que estiverem VAZIOS na Jota 2, usando o da Jota 3 (mesmo codigo). Nunca sobrescreve.
UPDATE produtos SET ncm = '17019900' WHERE padaria_id = 2 AND codigo_barras = '7896894900013' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22011000' WHERE padaria_id = 2 AND codigo_barras = '7894900530032' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22011000' WHERE padaria_id = 2 AND codigo_barras = '7894900531015' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22011000' WHERE padaria_id = 2 AND codigo_barras = '7894900531008' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22011000' WHERE padaria_id = 2 AND codigo_barras = '7898906467309' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '28289011' WHERE padaria_id = 2 AND codigo_barras = '7898944352018' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22071090' WHERE padaria_id = 2 AND codigo_barras = '7898969948036' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '38099190' WHERE padaria_id = 2 AND codigo_barras = '7896083800810' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7896045504541' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7896045505319' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7896045506934' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '7896569405737' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '11041200' WHERE padaria_id = 2 AND codigo_barras = '7891000102640' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17041000' WHERE padaria_id = 2 AND codigo_barras = '7895800002957' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7898230716654' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049010' WHERE padaria_id = 2 AND codigo_barras = '7622210674319' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20052000' WHERE padaria_id = 2 AND codigo_barras = '7897844304653' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18063210' WHERE padaria_id = 2 AND codigo_barras = '78912359' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049010' WHERE padaria_id = 2 AND codigo_barras = '78912366' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053200' WHERE padaria_id = 2 AND codigo_barras = '7622210575999' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053200' WHERE padaria_id = 2 AND codigo_barras = '7622210575975' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7896003740233' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7896058258530' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896003740226' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33074900' WHERE padaria_id = 2 AND codigo_barras = '7891035534072' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '08055000' WHERE padaria_id = 2 AND codigo_barras = '7891035536700' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33074900' WHERE padaria_id = 2 AND codigo_barras = '7891035325625' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7891149010509' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7891149010400' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029100' WHERE padaria_id = 2 AND codigo_barras = '7891149104932' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09012100' WHERE padaria_id = 2 AND codigo_barras = '262' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '026200' WHERE padaria_id = 2 AND codigo_barras = '262' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21011110' WHERE padaria_id = 2 AND codigo_barras = '7896045103003' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '44029000' WHERE padaria_id = 2 AND codigo_barras = '7908119296822' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09021000' WHERE padaria_id = 2 AND codigo_barras = '7891098000149' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7896423438994' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18063110' WHERE padaria_id = 2 AND codigo_barras = '7896423470994' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900011715' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '78933873' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '410' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '041000' WHERE padaria_id = 2 AND codigo_barras = '410' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900700015' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900705034' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900701517' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900701609' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900704211' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900700398' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7891000247624' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '6026' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '602600' WHERE padaria_id = 2 AND codigo_barras = '6026' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898341430111' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900660265' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900660401' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900660319' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900550030' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '38089419' WHERE padaria_id = 2 AND codigo_barras = '7898944352186' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '38089419' WHERE padaria_id = 2 AND codigo_barras = '7898944352391' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78947504' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7898367983790' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900093001' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900030013' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900031515' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900050011' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900051513' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '11062000' WHERE padaria_id = 2 AND codigo_barras = '7896116900623' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19019090' WHERE padaria_id = 2 AND codigo_barras = '7898960982213' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '7895144028019' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '7896262301022' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '7895144025117' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7892840808037' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069029' WHERE padaria_id = 2 AND codigo_barras = '7896327516132' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7891991001342' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7891991002646' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '02071419' WHERE padaria_id = 2 AND codigo_barras = '7891991000727' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7891991002684' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7896326100219' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7892840812850' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7896045506590' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '78936683' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7896045506873' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '78905498' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '78935495' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7891098040848' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7891098040893' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04032000' WHERE padaria_id = 2 AND codigo_barras = '7896862000011' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04032000' WHERE padaria_id = 2 AND codigo_barras = '7896862000806' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04032000' WHERE padaria_id = 2 AND codigo_barras = '7896862000431' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7898377662425' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7898377662487' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7898377662449' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7897395020101' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '78906709' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7896052603497' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7896052604975' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7896052606191' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78943148' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78942936' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18063210' WHERE padaria_id = 2 AND codigo_barras = '7622210673831' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04022110' WHERE padaria_id = 2 AND codigo_barras = '7898080641694' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04039000' WHERE padaria_id = 2 AND codigo_barras = '7896862002060' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04012010' WHERE padaria_id = 2 AND codigo_barras = '7898080640611' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04012010' WHERE padaria_id = 2 AND codigo_barras = '7896283800801' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7891035210334' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '7895144899947' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '7896262304351' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '10059010' WHERE padaria_id = 2 AND codigo_barras = '7898416520563' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20058000' WHERE padaria_id = 2 AND codigo_barras = '7898902299843' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '7891079013038' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896327511984' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039021' WHERE padaria_id = 2 AND codigo_barras = '7898286190361' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898938890076' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '070847033301' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21032090' WHERE padaria_id = 2 AND codigo_barras = '7896292300477' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21011200' WHERE padaria_id = 2 AND codigo_barras = '7891000110829' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '15079011' WHERE padaria_id = 2 AND codigo_barras = '7891107101621' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7622300989408' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7891991015493' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '78905351' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053200' WHERE padaria_id = 2 AND codigo_barras = '78939318' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48181000' WHERE padaria_id = 2 AND codigo_barras = '7891172421174' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48181000' WHERE padaria_id = 2 AND codigo_barras = '7897844300723' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48189090' WHERE padaria_id = 2 AND codigo_barras = '7896075301257' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7891000457368' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '96151100' WHERE padaria_id = 2 AND codigo_barras = '7898504933596' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7892840813505' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912199' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900508017' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '979' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '097900' WHERE padaria_id = 2 AND codigo_barras = '979' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '9002490214166' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04061090' WHERE padaria_id = 2 AND codigo_barras = '7896862000486' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78947603' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '02012020' WHERE padaria_id = 2 AND codigo_barras = '78947597' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78944237' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '02012020' WHERE padaria_id = 2 AND codigo_barras = '78947610' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78944497' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78944503' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34012090' WHERE padaria_id = 2 AND codigo_barras = '7898944352445' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7891149200504' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7891149200405' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7891991000833' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053200' WHERE padaria_id = 2 AND codigo_barras = '78939301' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900681246' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900061604' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900060010' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898344179123' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20091200' WHERE padaria_id = 2 AND codigo_barras = '7898344178874' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898344179079' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039021' WHERE padaria_id = 2 AND codigo_barras = '7891000037300' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7897395031602' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '16010000' WHERE padaria_id = 2 AND codigo_barras = '217' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '021700' WHERE padaria_id = 2 AND codigo_barras = '217' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7891035210006' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7891035209000' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053200' WHERE padaria_id = 2 AND codigo_barras = '7891000077924' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900701609' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04051000' WHERE padaria_id = 2 AND codigo_barras = '24' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '002400' WHERE padaria_id = 2 AND codigo_barras = '24' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7622210411501' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '96190000' WHERE padaria_id = 2 AND codigo_barras = '7506339394535' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '96190000' WHERE padaria_id = 2 AND codigo_barras = '7506339394603' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '96190000' WHERE padaria_id = 2 AND codigo_barras = '7896007540631' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '96190000' WHERE padaria_id = 2 AND codigo_barras = '7896007540662' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000379585' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000412855' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7894321711171' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7892840819507' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17019900' WHERE padaria_id = 2 AND codigo_barras = '7896894900013' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900087048' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900087055' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900087062' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900087079' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900087093' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900087116' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900087123' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20091900' WHERE padaria_id = 2 AND codigo_barras = '3074' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '307400' WHERE padaria_id = 2 AND codigo_barras = '3074' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '10063021' WHERE padaria_id = 2 AND codigo_barras = '7070' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '707000' WHERE padaria_id = 2 AND codigo_barras = '7070' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16024900' WHERE padaria_id = 2 AND codigo_barras = '8095' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '809500' WHERE padaria_id = 2 AND codigo_barras = '8095' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21011110' WHERE padaria_id = 2 AND codigo_barras = '777' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '077700' WHERE padaria_id = 2 AND codigo_barras = '777' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '8096' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '809600' WHERE padaria_id = 2 AND codigo_barras = '8096' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET codigo_balanca = '402300' WHERE padaria_id = 2 AND codigo_barras = '4023' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '07133399' WHERE padaria_id = 2 AND codigo_barras = '7071' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '707100' WHERE padaria_id = 2 AND codigo_barras = '7071' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16023220' WHERE padaria_id = 2 AND codigo_barras = '262' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '026200' WHERE padaria_id = 2 AND codigo_barras = '262' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '311' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '031100' WHERE padaria_id = 2 AND codigo_barras = '311' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20091900' WHERE padaria_id = 2 AND codigo_barras = '3063' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '306300' WHERE padaria_id = 2 AND codigo_barras = '3063' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '07069000' WHERE padaria_id = 2 AND codigo_barras = '8094' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '809400' WHERE padaria_id = 2 AND codigo_barras = '8094' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16010000' WHERE padaria_id = 2 AND codigo_barras = '504' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '050400' WHERE padaria_id = 2 AND codigo_barras = '504' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16010000' WHERE padaria_id = 2 AND codigo_barras = '307' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '030700' WHERE padaria_id = 2 AND codigo_barras = '307' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '483' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '048300' WHERE padaria_id = 2 AND codigo_barras = '483' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '04061090' WHERE padaria_id = 2 AND codigo_barras = '505' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '050500' WHERE padaria_id = 2 AND codigo_barras = '505' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '29054300' WHERE padaria_id = 2 AND codigo_barras = '7891104393104' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '7896094910904' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22011000' WHERE padaria_id = 2 AND codigo_barras = '7898217480011' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22011000' WHERE padaria_id = 2 AND codigo_barras = '7898386200083' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '28289011' WHERE padaria_id = 2 AND codigo_barras = '7898944352025' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22011000' WHERE padaria_id = 2 AND codigo_barras = '7898368290132' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900300017' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '28363000' WHERE padaria_id = 2 AND codigo_barras = '7898917671498' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '38089419' WHERE padaria_id = 2 AND codigo_barras = '7896090703616' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '38089419' WHERE padaria_id = 2 AND codigo_barras = '0602883061613' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22071090' WHERE padaria_id = 2 AND codigo_barras = '7898969948067' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22072019' WHERE padaria_id = 2 AND codigo_barras = '7896090704804' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '218' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '021800' WHERE padaria_id = 2 AND codigo_barras = '218' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '217' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '021700' WHERE padaria_id = 2 AND codigo_barras = '217' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '7000' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '700000' WHERE padaria_id = 2 AND codigo_barras = '7000' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '214' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '021400' WHERE padaria_id = 2 AND codigo_barras = '214' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '4090' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '409000' WHERE padaria_id = 2 AND codigo_barras = '4090' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '250' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '025000' WHERE padaria_id = 2 AND codigo_barras = '250' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '215' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '021500' WHERE padaria_id = 2 AND codigo_barras = '215' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '216' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '021600' WHERE padaria_id = 2 AND codigo_barras = '216' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '5090' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '509000' WHERE padaria_id = 2 AND codigo_barras = '5090' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '219' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '021900' WHERE padaria_id = 2 AND codigo_barras = '219' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7891000067048' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18063210' WHERE padaria_id = 2 AND codigo_barras = '7891000410707' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '38091010' WHERE padaria_id = 2 AND codigo_barras = '7500435252942' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '38099190' WHERE padaria_id = 2 AND codigo_barras = '7896056404700' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20081100' WHERE padaria_id = 2 AND codigo_barras = '7896058599060' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '163' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '016300' WHERE padaria_id = 2 AND codigo_barras = '163' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '11081200' WHERE padaria_id = 2 AND codigo_barras = '7896327512615' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896002362412' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896002301510' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896002301497' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896002363259' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896002311823' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896002368230' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896002303781' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896002362436' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896002311830' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '10063021' WHERE padaria_id = 2 AND codigo_barras = '7893500020301' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '10063021' WHERE padaria_id = 2 AND codigo_barras = '7896006711117' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '73231000' WHERE padaria_id = 2 AND codigo_barras = '7896090100101' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '11041200' WHERE padaria_id = 2 AND codigo_barras = '7896327501855' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '11041200' WHERE padaria_id = 2 AND codigo_barras = '7892840815769' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7895800002933' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912120' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7898171341366' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1999' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '199900' WHERE padaria_id = 2 AND codigo_barras = '1999' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '9086' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '908600' WHERE padaria_id = 2 AND codigo_barras = '9086' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '537' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '053700' WHERE padaria_id = 2 AND codigo_barras = '537' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16023220' WHERE padaria_id = 2 AND codigo_barras = '5335' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '533500' WHERE padaria_id = 2 AND codigo_barras = '5335' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '4018' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '401800' WHERE padaria_id = 2 AND codigo_barras = '4018' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '4019' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '401900' WHERE padaria_id = 2 AND codigo_barras = '4019' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '4022' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '402200' WHERE padaria_id = 2 AND codigo_barras = '4022' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '905' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '090500' WHERE padaria_id = 2 AND codigo_barras = '905' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '377' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '037700' WHERE padaria_id = 2 AND codigo_barras = '377' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '271' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '027100' WHERE padaria_id = 2 AND codigo_barras = '271' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '396' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '039600' WHERE padaria_id = 2 AND codigo_barras = '396' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '454' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '045400' WHERE padaria_id = 2 AND codigo_barras = '454' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '7891151035293' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '102' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '010200' WHERE padaria_id = 2 AND codigo_barras = '102' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '30051090' WHERE padaria_id = 2 AND codigo_barras = '75' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '007500' WHERE padaria_id = 2 AND codigo_barras = '75' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19019090' WHERE padaria_id = 2 AND codigo_barras = '326' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '032600' WHERE padaria_id = 2 AND codigo_barras = '326' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '3014' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '301400' WHERE padaria_id = 2 AND codigo_barras = '3014' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20052000' WHERE padaria_id = 2 AND codigo_barras = '7898766840083' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20052000' WHERE padaria_id = 2 AND codigo_barras = '7898931140543' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20052000' WHERE padaria_id = 2 AND codigo_barras = '7898931140512' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20052000' WHERE padaria_id = 2 AND codigo_barras = '7898925211945' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20052000' WHERE padaria_id = 2 AND codigo_barras = '7898937864955' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '6068' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '606800' WHERE padaria_id = 2 AND codigo_barras = '6068' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '146' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '014600' WHERE padaria_id = 2 AND codigo_barras = '146' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '165' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '016500' WHERE padaria_id = 2 AND codigo_barras = '165' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7896005809518' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '374' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '037400' WHERE padaria_id = 2 AND codigo_barras = '374' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '627' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '062700' WHERE padaria_id = 2 AND codigo_barras = '627' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '96131000' WHERE padaria_id = 2 AND codigo_barras = '070330909229' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '96131000' WHERE padaria_id = 2 AND codigo_barras = '070330913431' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '451' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '045100' WHERE padaria_id = 2 AND codigo_barras = '451' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '38089419' WHERE padaria_id = 2 AND codigo_barras = '7908185600424' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34022000' WHERE padaria_id = 2 AND codigo_barras = '7908185601575' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053200' WHERE padaria_id = 2 AND codigo_barras = '7622210534576' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7897053100077' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1132' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '113200' WHERE padaria_id = 2 AND codigo_barras = '1132' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '7898070347865' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7898070347872' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896486202884' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7898070347841' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7896213006426' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20052000' WHERE padaria_id = 2 AND codigo_barras = '7898070347858' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20052000' WHERE padaria_id = 2 AND codigo_barras = '7898070347834' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7898070347896' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7898070347827' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '789807347797' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896002360234' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '5333' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '533300' WHERE padaria_id = 2 AND codigo_barras = '5333' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '06' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '000600' WHERE padaria_id = 2 AND codigo_barras = '06' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7896213006242' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7891000376843' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7891000376928' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7891000452165' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7891000376959' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7896003738612' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896071030069' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896003740189' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896003740240' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7891000376768' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7891000051436' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7896085087417' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7896085087424' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '3900' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '390000' WHERE padaria_id = 2 AND codigo_barras = '3900' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '431' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '043100' WHERE padaria_id = 2 AND codigo_barras = '431' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19021900' WHERE padaria_id = 2 AND codigo_barras = '42' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '004200' WHERE padaria_id = 2 AND codigo_barras = '42' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1900' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '190000' WHERE padaria_id = 2 AND codigo_barras = '1900' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '441' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '044100' WHERE padaria_id = 2 AND codigo_barras = '441' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '4009' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '400900' WHERE padaria_id = 2 AND codigo_barras = '4009' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '274' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '027400' WHERE padaria_id = 2 AND codigo_barras = '274' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '484' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '048400' WHERE padaria_id = 2 AND codigo_barras = '484' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '336' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '033600' WHERE padaria_id = 2 AND codigo_barras = '336' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '527' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '052700' WHERE padaria_id = 2 AND codigo_barras = '527' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '394' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '039400' WHERE padaria_id = 2 AND codigo_barras = '394' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '390' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '039000' WHERE padaria_id = 2 AND codigo_barras = '390' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '601' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '060100' WHERE padaria_id = 2 AND codigo_barras = '601' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '442' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '044200' WHERE padaria_id = 2 AND codigo_barras = '442' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1010' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '101000' WHERE padaria_id = 2 AND codigo_barras = '1010' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '391' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '039100' WHERE padaria_id = 2 AND codigo_barras = '391' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '338' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '033800' WHERE padaria_id = 2 AND codigo_barras = '338' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896002361019' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '909600' WHERE padaria_id = 2 AND codigo_barras = '9096' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '8001' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '800100' WHERE padaria_id = 2 AND codigo_barras = '8001' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '8070' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '807000' WHERE padaria_id = 2 AND codigo_barras = '8070' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '8901' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '890100' WHERE padaria_id = 2 AND codigo_barras = '8901' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '389' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '038900' WHERE padaria_id = 2 AND codigo_barras = '389' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '1911' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '191100' WHERE padaria_id = 2 AND codigo_barras = '1911' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1118' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '111800' WHERE padaria_id = 2 AND codigo_barras = '1118' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896002362146' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '393' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '039300' WHERE padaria_id = 2 AND codigo_barras = '393' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896002361033' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '534' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '053400' WHERE padaria_id = 2 AND codigo_barras = '534' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '3030' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '303000' WHERE padaria_id = 2 AND codigo_barras = '3030' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '567' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '056700' WHERE padaria_id = 2 AND codigo_barras = '567' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '8900' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '890000' WHERE padaria_id = 2 AND codigo_barras = '8900' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '9055' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '905500' WHERE padaria_id = 2 AND codigo_barras = '9055' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '2008' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '200800' WHERE padaria_id = 2 AND codigo_barras = '2008' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '3047' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '304700' WHERE padaria_id = 2 AND codigo_barras = '3047' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1533' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '153300' WHERE padaria_id = 2 AND codigo_barras = '1533' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '3046' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '304600' WHERE padaria_id = 2 AND codigo_barras = '3046' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '2007' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '200700' WHERE padaria_id = 2 AND codigo_barras = '2007' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '3045' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '304500' WHERE padaria_id = 2 AND codigo_barras = '3045' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '430' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '043000' WHERE padaria_id = 2 AND codigo_barras = '430' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '110' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '011000' WHERE padaria_id = 2 AND codigo_barras = '110' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '603' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '060300' WHERE padaria_id = 2 AND codigo_barras = '603' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '604' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '060400' WHERE padaria_id = 2 AND codigo_barras = '604' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '605' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '060500' WHERE padaria_id = 2 AND codigo_barras = '605' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896002360982' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '480' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '048000' WHERE padaria_id = 2 AND codigo_barras = '480' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '02071419' WHERE padaria_id = 2 AND codigo_barras = '1002' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '100200' WHERE padaria_id = 2 AND codigo_barras = '1002' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '530' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '053000' WHERE padaria_id = 2 AND codigo_barras = '530' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '02071419' WHERE padaria_id = 2 AND codigo_barras = '1004' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '100400' WHERE padaria_id = 2 AND codigo_barras = '1004' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '349' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '034900' WHERE padaria_id = 2 AND codigo_barras = '349' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '42022210' WHERE padaria_id = 2 AND codigo_barras = '7089' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '708900' WHERE padaria_id = 2 AND codigo_barras = '7089' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '610' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '061000' WHERE padaria_id = 2 AND codigo_barras = '610' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '3013' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '301300' WHERE padaria_id = 2 AND codigo_barras = '3013' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '73231000' WHERE padaria_id = 2 AND codigo_barras = '7891022868036' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '8010' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '801000' WHERE padaria_id = 2 AND codigo_barras = '8010' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19019090' WHERE padaria_id = 2 AND codigo_barras = '17' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '001700' WHERE padaria_id = 2 AND codigo_barras = '17' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '3080' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '308000' WHERE padaria_id = 2 AND codigo_barras = '3080' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '447' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '044700' WHERE padaria_id = 2 AND codigo_barras = '447' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19021900' WHERE padaria_id = 2 AND codigo_barras = '387' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '038700' WHERE padaria_id = 2 AND codigo_barras = '387' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '474' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '047400' WHERE padaria_id = 2 AND codigo_barras = '474' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '330' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '033000' WHERE padaria_id = 2 AND codigo_barras = '330' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7891991011877' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09012100' WHERE padaria_id = 2 AND codigo_barras = '998' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '099800' WHERE padaria_id = 2 AND codigo_barras = '998' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '09012100' WHERE padaria_id = 2 AND codigo_barras = '7891018427599' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09012100' WHERE padaria_id = 2 AND codigo_barras = '7891018427582' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09012100' WHERE padaria_id = 2 AND codigo_barras = '7891018001386' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09012100' WHERE padaria_id = 2 AND codigo_barras = '7896089011203' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09012100' WHERE padaria_id = 2 AND codigo_barras = '7896089010916' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21011200' WHERE padaria_id = 2 AND codigo_barras = '7896005800157' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21011200' WHERE padaria_id = 2 AND codigo_barras = '7896005802373' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21011200' WHERE padaria_id = 2 AND codigo_barras = '189' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '018900' WHERE padaria_id = 2 AND codigo_barras = '189' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '09012100' WHERE padaria_id = 2 AND codigo_barras = '187' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '018700' WHERE padaria_id = 2 AND codigo_barras = '187' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '194' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '019400' WHERE padaria_id = 2 AND codigo_barras = '194' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '191' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '019100' WHERE padaria_id = 2 AND codigo_barras = '191' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '190' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '019000' WHERE padaria_id = 2 AND codigo_barras = '190' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '09012100' WHERE padaria_id = 2 AND codigo_barras = '7896005801512' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09012100' WHERE padaria_id = 2 AND codigo_barras = '7896089011982' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09012100' WHERE padaria_id = 2 AND codigo_barras = '7896089012019' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21011110' WHERE padaria_id = 2 AND codigo_barras = '7891018427766' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09012100' WHERE padaria_id = 2 AND codigo_barras = '7891910030347' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000457467' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09096110' WHERE padaria_id = 2 AND codigo_barras = '475' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '047500' WHERE padaria_id = 2 AND codigo_barras = '475' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21041011' WHERE padaria_id = 2 AND codigo_barras = '7891000250174' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21041019' WHERE padaria_id = 2 AND codigo_barras = '7891122123486' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '44219900' WHERE padaria_id = 2 AND codigo_barras = '997' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '099700' WHERE padaria_id = 2 AND codigo_barras = '997' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '203' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '020300' WHERE padaria_id = 2 AND codigo_barras = '203' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7896005809501' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '07149000' WHERE padaria_id = 2 AND codigo_barras = '381' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '038100' WHERE padaria_id = 2 AND codigo_barras = '381' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '248' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '024800' WHERE padaria_id = 2 AND codigo_barras = '248' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '249' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '024900' WHERE padaria_id = 2 AND codigo_barras = '249' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '457' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '045700' WHERE padaria_id = 2 AND codigo_barras = '457' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '423' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '042300' WHERE padaria_id = 2 AND codigo_barras = '423' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '18063210' WHERE padaria_id = 2 AND codigo_barras = '7891008121193' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19019090' WHERE padaria_id = 2 AND codigo_barras = '461' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '046100' WHERE padaria_id = 2 AND codigo_barras = '461' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '448' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '044800' WHERE padaria_id = 2 AND codigo_barras = '448' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '494' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '049400' WHERE padaria_id = 2 AND codigo_barras = '494' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '02012020' WHERE padaria_id = 2 AND codigo_barras = '7898946867077' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '4446' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '444600' WHERE padaria_id = 2 AND codigo_barras = '4446' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '900' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '090000' WHERE padaria_id = 2 AND codigo_barras = '900' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '901' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '090100' WHERE padaria_id = 2 AND codigo_barras = '901' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7896388010556' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7898367984285' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09021000' WHERE padaria_id = 2 AND codigo_barras = '195' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '019500' WHERE padaria_id = 2 AND codigo_barras = '195' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '12119090' WHERE padaria_id = 2 AND codigo_barras = '7891098000163' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09022000' WHERE padaria_id = 2 AND codigo_barras = '7891048038055' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09021000' WHERE padaria_id = 2 AND codigo_barras = '7891098000170' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21012010' WHERE padaria_id = 2 AND codigo_barras = '7891098010575' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09030090' WHERE padaria_id = 2 AND codigo_barras = '7891098000040' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09030090' WHERE padaria_id = 2 AND codigo_barras = '7891098038456' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09030090' WHERE padaria_id = 2 AND codigo_barras = '7891098000057' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09021000' WHERE padaria_id = 2 AND codigo_barras = '195' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '019500' WHERE padaria_id = 2 AND codigo_barras = '195' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '85163200' WHERE padaria_id = 2 AND codigo_barras = '6070' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '607000' WHERE padaria_id = 2 AND codigo_barras = '6070' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '73269090' WHERE padaria_id = 2 AND codigo_barras = '7083' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '708300' WHERE padaria_id = 2 AND codigo_barras = '7083' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '73269090' WHERE padaria_id = 2 AND codigo_barras = '6062' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '606200' WHERE padaria_id = 2 AND codigo_barras = '6062' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78937680' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78939424' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78942660' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78946675' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78938380' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912113' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7891000402979' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18063210' WHERE padaria_id = 2 AND codigo_barras = '7891000369098' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7622202274619' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000464908' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18063120' WHERE padaria_id = 2 AND codigo_barras = '7891000462300' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7896072646733' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053200' WHERE padaria_id = 2 AND codigo_barras = '7891000248768' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053200' WHERE padaria_id = 2 AND codigo_barras = '7891000249239' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7896423438727' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049010' WHERE padaria_id = 2 AND codigo_barras = '7896423488883' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7896423439014' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000107836' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7896423497984' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000477410' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000476475' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '520' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '052000' WHERE padaria_id = 2 AND codigo_barras = '520' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '8091' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '809100' WHERE padaria_id = 2 AND codigo_barras = '8091' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '18063210' WHERE padaria_id = 2 AND codigo_barras = '7891000422083' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000377543' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '120' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '012000' WHERE padaria_id = 2 AND codigo_barras = '120' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '119' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '011900' WHERE padaria_id = 2 AND codigo_barras = '119' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '121' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '012100' WHERE padaria_id = 2 AND codigo_barras = '121' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '28289011' WHERE padaria_id = 2 AND codigo_barras = '7898944352100' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '28289011' WHERE padaria_id = 2 AND codigo_barras = '7898944352117' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '28289011' WHERE padaria_id = 2 AND codigo_barras = '7898944352100' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '28289011' WHERE padaria_id = 2 AND codigo_barras = '7898944352124' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7622300990701' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059020' WHERE padaria_id = 2 AND codigo_barras = '7622210641632' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059020' WHERE padaria_id = 2 AND codigo_barras = '7622210661609' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '63079090' WHERE padaria_id = 2 AND codigo_barras = '7891021002103' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900015119' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900027013' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900701517' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900010015' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900011609' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '78908901' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900025019' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '138' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '013800' WHERE padaria_id = 2 AND codigo_barras = '138' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900010398' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900010015' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900014211' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19021900' WHERE padaria_id = 2 AND codigo_barras = '23' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '002300' WHERE padaria_id = 2 AND codigo_barras = '23' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '08011100' WHERE padaria_id = 2 AND codigo_barras = '7896016601217' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '08011100' WHERE padaria_id = 2 AND codigo_barras = '7896004401058' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '08011100' WHERE padaria_id = 2 AND codigo_barras = '7896028030661' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '521' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '052100' WHERE padaria_id = 2 AND codigo_barras = '521' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19011010' WHERE padaria_id = 2 AND codigo_barras = '7896051168720' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '02013000' WHERE padaria_id = 2 AND codigo_barras = '1800' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '180000' WHERE padaria_id = 2 AND codigo_barras = '1800' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7891000350119' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7891000339237' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513940048' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513940239' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '625' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '062500' WHERE padaria_id = 2 AND codigo_barras = '625' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912588' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '8100' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '810000' WHERE padaria_id = 2 AND codigo_barras = '8100' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '56012190' WHERE padaria_id = 2 AND codigo_barras = '7898916237015' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '56012190' WHERE padaria_id = 2 AND codigo_barras = '7896227621059' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '02071300' WHERE padaria_id = 2 AND codigo_barras = '40' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '004000' WHERE padaria_id = 2 AND codigo_barras = '40' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '9090' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '909000' WHERE padaria_id = 2 AND codigo_barras = '9090' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '2009' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '200900' WHERE padaria_id = 2 AND codigo_barras = '2009' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1988' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '198800' WHERE padaria_id = 2 AND codigo_barras = '1988' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19022000' WHERE padaria_id = 2 AND codigo_barras = '3068' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '306800' WHERE padaria_id = 2 AND codigo_barras = '3068' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1987' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '198700' WHERE padaria_id = 2 AND codigo_barras = '1987' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '04015021' WHERE padaria_id = 2 AND codigo_barras = '7891000126905' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04015021' WHERE padaria_id = 2 AND codigo_barras = '7898215151784' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33061000' WHERE padaria_id = 2 AND codigo_barras = '7891024132906' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33061000' WHERE padaria_id = 2 AND codigo_barras = '7891024132128' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33061000' WHERE padaria_id = 2 AND codigo_barras = '7891024134702' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33061000' WHERE padaria_id = 2 AND codigo_barras = '7896013106951' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33061000' WHERE padaria_id = 2 AND codigo_barras = '7891528029498' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '8011' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '801100' WHERE padaria_id = 2 AND codigo_barras = '8011' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '8009' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '800900' WHERE padaria_id = 2 AND codigo_barras = '8009' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '8007' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '800700' WHERE padaria_id = 2 AND codigo_barras = '8007' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891008124583' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '398' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '039800' WHERE padaria_id = 2 AND codigo_barras = '398' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '223' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '022300' WHERE padaria_id = 2 AND codigo_barras = '223' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '270' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '027000' WHERE padaria_id = 2 AND codigo_barras = '270' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '12019000' WHERE padaria_id = 2 AND codigo_barras = '27' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '002700' WHERE padaria_id = 2 AND codigo_barras = '27' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '332' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '033200' WHERE padaria_id = 2 AND codigo_barras = '332' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '7891079013083' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '4011' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '401100' WHERE padaria_id = 2 AND codigo_barras = '4011' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '4010' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '401000' WHERE padaria_id = 2 AND codigo_barras = '4010' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '4014' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '401400' WHERE padaria_id = 2 AND codigo_barras = '4014' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19019090' WHERE padaria_id = 2 AND codigo_barras = '540' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '054000' WHERE padaria_id = 2 AND codigo_barras = '540' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900660364' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900666502' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900563702' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900573701' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900583700' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900593709' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900556056' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900556032' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900660302' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900660333' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900660357' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898341430074' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898341430036' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900660418' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898341430098' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900660432' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900550054' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '38089419' WHERE padaria_id = 2 AND codigo_barras = '7898944352193' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '38089419' WHERE padaria_id = 2 AND codigo_barras = '7898944352179' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '38089419' WHERE padaria_id = 2 AND codigo_barras = '7898944352315' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '38089419' WHERE padaria_id = 2 AND codigo_barras = '7898944352292' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '38089419' WHERE padaria_id = 2 AND codigo_barras = '7898944352209' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '38089419' WHERE padaria_id = 2 AND codigo_barras = '7898944352384' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33072010' WHERE padaria_id = 2 AND codigo_barras = '7896044936923' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33072010' WHERE padaria_id = 2 AND codigo_barras = '7891350034622' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33072010' WHERE padaria_id = 2 AND codigo_barras = '7898919411900' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33072010' WHERE padaria_id = 2 AND codigo_barras = '7891350034639' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33072090' WHERE padaria_id = 2 AND codigo_barras = '7896049525726' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33072090' WHERE padaria_id = 2 AND codigo_barras = '7896049508514' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33072090' WHERE padaria_id = 2 AND codigo_barras = '7896049528604' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33072090' WHERE padaria_id = 2 AND codigo_barras = '7896049528567' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33072090' WHERE padaria_id = 2 AND codigo_barras = '7896049528536' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33072010' WHERE padaria_id = 2 AND codigo_barras = '7897042010455' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33072010' WHERE padaria_id = 2 AND codigo_barras = '7897042012039' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7891022637007' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7891022639001' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7897664130043' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7897664130036' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7896098900208' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7622210573322' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '30049069' WHERE padaria_id = 2 AND codigo_barras = '114' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '011400' WHERE padaria_id = 2 AND codigo_barras = '114' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '17041000' WHERE padaria_id = 2 AND codigo_barras = '7898754690751' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '02061000' WHERE padaria_id = 2 AND codigo_barras = '468' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '046800' WHERE padaria_id = 2 AND codigo_barras = '468' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '144' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '014400' WHERE padaria_id = 2 AND codigo_barras = '144' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7896462300115' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7896462300139' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '30049069' WHERE padaria_id = 2 AND codigo_barras = '113' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '011300' WHERE padaria_id = 2 AND codigo_barras = '113' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7892840822729' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22084000' WHERE padaria_id = 2 AND codigo_barras = '419' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '041900' WHERE padaria_id = 2 AND codigo_barras = '419' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '30049029' WHERE padaria_id = 2 AND codigo_barras = '264' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '026400' WHERE padaria_id = 2 AND codigo_barras = '264' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '30049029' WHERE padaria_id = 2 AND codigo_barras = '265' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '026500' WHERE padaria_id = 2 AND codigo_barras = '265' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '30049029' WHERE padaria_id = 2 AND codigo_barras = '437' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '043700' WHERE padaria_id = 2 AND codigo_barras = '437' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '415' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '041500' WHERE padaria_id = 2 AND codigo_barras = '415' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22082000' WHERE padaria_id = 2 AND codigo_barras = '416' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '041600' WHERE padaria_id = 2 AND codigo_barras = '416' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78947467' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78947474' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78947542' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '620' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '062000' WHERE padaria_id = 2 AND codigo_barras = '620' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513916081' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78400924' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7898367983615' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '96151100' WHERE padaria_id = 2 AND codigo_barras = '6074' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '607400' WHERE padaria_id = 2 AND codigo_barras = '6074' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19041000' WHERE padaria_id = 2 AND codigo_barras = '7898667960668' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '235' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '023500' WHERE padaria_id = 2 AND codigo_barras = '235' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20054000' WHERE padaria_id = 2 AND codigo_barras = '7899659900785' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20059900' WHERE padaria_id = 2 AND codigo_barras = '7899659900792' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20054000' WHERE padaria_id = 2 AND codigo_barras = '7896292340541' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20054000' WHERE padaria_id = 2 AND codigo_barras = '7896292343719' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '96032100' WHERE padaria_id = 2 AND codigo_barras = '7891024024386' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '96032100' WHERE padaria_id = 2 AND codigo_barras = '7898395840362' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1012' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '101200' WHERE padaria_id = 2 AND codigo_barras = '1012' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET codigo_balanca = '024400' WHERE padaria_id = 2 AND codigo_barras = '244' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET codigo_balanca = '024300' WHERE padaria_id = 2 AND codigo_barras = '243' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET codigo_balanca = '024200' WHERE padaria_id = 2 AND codigo_barras = '242' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET codigo_balanca = '024600' WHERE padaria_id = 2 AND codigo_barras = '246' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET codigo_balanca = '024500' WHERE padaria_id = 2 AND codigo_barras = '245' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '17049090' WHERE padaria_id = 2 AND codigo_barras = '343' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '034300' WHERE padaria_id = 2 AND codigo_barras = '343' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '70099200' WHERE padaria_id = 2 AND codigo_barras = '7088' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '708800' WHERE padaria_id = 2 AND codigo_barras = '7088' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '70099200' WHERE padaria_id = 2 AND codigo_barras = '7087' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '708700' WHERE padaria_id = 2 AND codigo_barras = '7087' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '70099200' WHERE padaria_id = 2 AND codigo_barras = '7082' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '708200' WHERE padaria_id = 2 AND codigo_barras = '7082' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '3115' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '311500' WHERE padaria_id = 2 AND codigo_barras = '3115' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '96162000' WHERE padaria_id = 2 AND codigo_barras = '6069' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '606900' WHERE padaria_id = 2 AND codigo_barras = '6069' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '252' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '025200' WHERE padaria_id = 2 AND codigo_barras = '252' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '78936478' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900031607' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900035117' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900053630' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19019090' WHERE padaria_id = 2 AND codigo_barras = '339' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '033900' WHERE padaria_id = 2 AND codigo_barras = '339' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '11010010' WHERE padaria_id = 2 AND codigo_barras = '7891080007682' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '11010010' WHERE padaria_id = 2 AND codigo_barras = '7896419431015' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '11010010' WHERE padaria_id = 2 AND codigo_barras = '7896005202074' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '11010010' WHERE padaria_id = 2 AND codigo_barras = '7898234850576' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '11010010' WHERE padaria_id = 2 AND codigo_barras = '7892020200194' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19011020' WHERE padaria_id = 2 AND codigo_barras = '7891000369340' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19019090' WHERE padaria_id = 2 AND codigo_barras = '7891095911639' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19019090' WHERE padaria_id = 2 AND codigo_barras = '7891095911486' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19019090' WHERE padaria_id = 2 AND codigo_barras = '7891095911394' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '312' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '031200' WHERE padaria_id = 2 AND codigo_barras = '312' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '337' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '033700' WHERE padaria_id = 2 AND codigo_barras = '337' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '53' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '005300' WHERE padaria_id = 2 AND codigo_barras = '53' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '331' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '033100' WHERE padaria_id = 2 AND codigo_barras = '331' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '4016' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '401600' WHERE padaria_id = 2 AND codigo_barras = '4016' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '907' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '090700' WHERE padaria_id = 2 AND codigo_barras = '907' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '6061' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '606100' WHERE padaria_id = 2 AND codigo_barras = '6061' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '1997' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '199700' WHERE padaria_id = 2 AND codigo_barras = '1997' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '2010' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '201000' WHERE padaria_id = 2 AND codigo_barras = '2010' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '321' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '032100' WHERE padaria_id = 2 AND codigo_barras = '321' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '322' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '032200' WHERE padaria_id = 2 AND codigo_barras = '322' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '07133399' WHERE padaria_id = 2 AND codigo_barras = '7896006744115' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21023000' WHERE padaria_id = 2 AND codigo_barras = '7896327512967' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '02013000' WHERE padaria_id = 2 AND codigo_barras = '514' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '051400' WHERE padaria_id = 2 AND codigo_barras = '514' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '02071422' WHERE padaria_id = 2 AND codigo_barras = '513' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '051300' WHERE padaria_id = 2 AND codigo_barras = '513' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '48232099' WHERE padaria_id = 2 AND codigo_barras = '7891021001885' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48232099' WHERE padaria_id = 2 AND codigo_barras = '7891021002127' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48232099' WHERE padaria_id = 2 AND codigo_barras = '7891021001946' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48232099' WHERE padaria_id = 2 AND codigo_barras = '7896005803714' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48232099' WHERE padaria_id = 2 AND codigo_barras = '7896005803721' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '7898591450648' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '7898591459511' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '7898279799823' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '11022000' WHERE padaria_id = 2 AND codigo_barras = '7896333200117' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '11041900' WHERE padaria_id = 2 AND codigo_barras = '7898932426042' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19041000' WHERE padaria_id = 2 AND codigo_barras = '7892840823214' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19041000' WHERE padaria_id = 2 AND codigo_barras = '7892840823177' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19041000' WHERE padaria_id = 2 AND codigo_barras = '7892840823191' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19041000' WHERE padaria_id = 2 AND codigo_barras = '7892840823207' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19041000' WHERE padaria_id = 2 AND codigo_barras = '7892840823221' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '36050000' WHERE padaria_id = 2 AND codigo_barras = '9039' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '903900' WHERE padaria_id = 2 AND codigo_barras = '9039' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '36050000' WHERE padaria_id = 2 AND codigo_barras = '1022' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '102200' WHERE padaria_id = 2 AND codigo_barras = '1022' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '36050000' WHERE padaria_id = 2 AND codigo_barras = '1022' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '102200' WHERE padaria_id = 2 AND codigo_barras = '1022' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '36050000' WHERE padaria_id = 2 AND codigo_barras = '4047' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '404700' WHERE padaria_id = 2 AND codigo_barras = '4047' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16023220' WHERE padaria_id = 2 AND codigo_barras = '254' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '025400' WHERE padaria_id = 2 AND codigo_barras = '254' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16023220' WHERE padaria_id = 2 AND codigo_barras = '516' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '051600' WHERE padaria_id = 2 AND codigo_barras = '516' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16023220' WHERE padaria_id = 2 AND codigo_barras = '471' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '047100' WHERE padaria_id = 2 AND codigo_barras = '471' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16023290' WHERE padaria_id = 2 AND codigo_barras = '452' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '045200' WHERE padaria_id = 2 AND codigo_barras = '452' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16023220' WHERE padaria_id = 2 AND codigo_barras = '469' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '046900' WHERE padaria_id = 2 AND codigo_barras = '469' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '255' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '025500' WHERE padaria_id = 2 AND codigo_barras = '255' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19053200' WHERE padaria_id = 2 AND codigo_barras = '7891000372548' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7892840822019' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7892840808020' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7892840808174' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7892840808051' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '3007' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '300700' WHERE padaria_id = 2 AND codigo_barras = '3007' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '5039' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '503900' WHERE padaria_id = 2 AND codigo_barras = '5039' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069029' WHERE padaria_id = 2 AND codigo_barras = '7896327511472' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069029' WHERE padaria_id = 2 AND codigo_barras = '7896327513957' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069029' WHERE padaria_id = 2 AND codigo_barras = '7896327516118' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19019090' WHERE padaria_id = 2 AND codigo_barras = '9999' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '999900' WHERE padaria_id = 2 AND codigo_barras = '9999' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19019090' WHERE padaria_id = 2 AND codigo_barras = '9998' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '999800' WHERE padaria_id = 2 AND codigo_barras = '9998' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78410282' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21011110' WHERE padaria_id = 2 AND codigo_barras = '83' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '008300' WHERE padaria_id = 2 AND codigo_barras = '83' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '82121020' WHERE padaria_id = 2 AND codigo_barras = '7500435154772' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20079910' WHERE padaria_id = 2 AND codigo_barras = '7898045702583' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17041000' WHERE padaria_id = 2 AND codigo_barras = '7898934596064' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '7897064812853' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7896058599473' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7891991008761' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48182000' WHERE padaria_id = 2 AND codigo_barras = '7897532800030' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '8998989121200' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '118' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '011800' WHERE padaria_id = 2 AND codigo_barras = '118' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7892840812423' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '78949416' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '78938793' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '78938854' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '78938830' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '78938823' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '78938847' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '78938816' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '78938861' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '024100' WHERE padaria_id = 2 AND codigo_barras = '241' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16025000' WHERE padaria_id = 2 AND codigo_barras = '7894904500383' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '269' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '026900' WHERE padaria_id = 2 AND codigo_barras = '269' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '64022000' WHERE padaria_id = 2 AND codigo_barras = '7890557722257' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64022000' WHERE padaria_id = 2 AND codigo_barras = '7890557722264' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64022000' WHERE padaria_id = 2 AND codigo_barras = '7891109714485' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64022000' WHERE padaria_id = 2 AND codigo_barras = '7891109714515' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64022000' WHERE padaria_id = 2 AND codigo_barras = '7891109486221' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64029990' WHERE padaria_id = 2 AND codigo_barras = '7890557502477' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64029990' WHERE padaria_id = 2 AND codigo_barras = '7891266542051' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64029990' WHERE padaria_id = 2 AND codigo_barras = '7890557502484' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64029990' WHERE padaria_id = 2 AND codigo_barras = '7891266542068' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64029990' WHERE padaria_id = 2 AND codigo_barras = '7890557502491' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64029990' WHERE padaria_id = 2 AND codigo_barras = '7891266542075' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64022000' WHERE padaria_id = 2 AND codigo_barras = '7890541601889' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64022000' WHERE padaria_id = 2 AND codigo_barras = '7890557722264' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64022000' WHERE padaria_id = 2 AND codigo_barras = '7890557722226' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64022000' WHERE padaria_id = 2 AND codigo_barras = '7891109714454' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64022000' WHERE padaria_id = 2 AND codigo_barras = '7891109635216' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64022000' WHERE padaria_id = 2 AND codigo_barras = '7891109486191' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '64022000' WHERE padaria_id = 2 AND codigo_barras = '7891109486207' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029100' WHERE padaria_id = 2 AND codigo_barras = '7896045506040' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '8000' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '800000' WHERE padaria_id = 2 AND codigo_barras = '8000' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '04032000' WHERE padaria_id = 2 AND codigo_barras = '200' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '020000' WHERE padaria_id = 2 AND codigo_barras = '200' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '04032000' WHERE padaria_id = 2 AND codigo_barras = '7896862000875' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04032000' WHERE padaria_id = 2 AND codigo_barras = '7896862002763' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04032000' WHERE padaria_id = 2 AND codigo_barras = '7896862000431' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '96138000' WHERE padaria_id = 2 AND codigo_barras = '131' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '013100' WHERE padaria_id = 2 AND codigo_barras = '131' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '96131000' WHERE padaria_id = 2 AND codigo_barras = '8412765505447' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7898377662401' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898080640239' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7 894900 563702' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21032010' WHERE padaria_id = 2 AND codigo_barras = '7896102502763' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21032010' WHERE padaria_id = 2 AND codigo_barras = '7898045701760' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21032010' WHERE padaria_id = 2 AND codigo_barras = '7891150079212' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21032010' WHERE padaria_id = 2 AND codigo_barras = '7896292360464' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21032010' WHERE padaria_id = 2 AND codigo_barras = '7896102502909' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '16025000' WHERE padaria_id = 2 AND codigo_barras = '263' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '026300' WHERE padaria_id = 2 AND codigo_barras = '263' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '96151100' WHERE padaria_id = 2 AND codigo_barras = '6067' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '606700' WHERE padaria_id = 2 AND codigo_barras = '6067' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '4444' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '444400' WHERE padaria_id = 2 AND codigo_barras = '4444' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '4445' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '444500' WHERE padaria_id = 2 AND codigo_barras = '4445' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '96151100' WHERE padaria_id = 2 AND codigo_barras = '6260' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '626000' WHERE padaria_id = 2 AND codigo_barras = '6260' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78942646' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78948228' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78942653' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '96159000' WHERE padaria_id = 2 AND codigo_barras = '7085' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '708500' WHERE padaria_id = 2 AND codigo_barras = '7085' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '17049010' WHERE padaria_id = 2 AND codigo_barras = '7622210573353' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '85395200' WHERE padaria_id = 2 AND codigo_barras = '7899710006579' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '524' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '052400' WHERE padaria_id = 2 AND codigo_barras = '524' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '525' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '052500' WHERE padaria_id = 2 AND codigo_barras = '525' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16022000' WHERE padaria_id = 2 AND codigo_barras = '526' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '052600' WHERE padaria_id = 2 AND codigo_barras = '526' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '333' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '033300' WHERE padaria_id = 2 AND codigo_barras = '333' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1120' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '112000' WHERE padaria_id = 2 AND codigo_barras = '1120' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '320' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '032000' WHERE padaria_id = 2 AND codigo_barras = '320' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20058000' WHERE padaria_id = 2 AND codigo_barras = '7898930142784' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '199' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '019900' WHERE padaria_id = 2 AND codigo_barras = '199' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '198' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '019800' WHERE padaria_id = 2 AND codigo_barras = '198' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '04029900' WHERE padaria_id = 2 AND codigo_barras = '7891000305553' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04029900' WHERE padaria_id = 2 AND codigo_barras = '7898215152002' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20098990' WHERE padaria_id = 2 AND codigo_barras = '7898406780755' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04022110' WHERE padaria_id = 2 AND codigo_barras = '7898080640376' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04021010' WHERE padaria_id = 2 AND codigo_barras = '7896051130123' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04022110' WHERE padaria_id = 2 AND codigo_barras = '7898215152347' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04039000' WHERE padaria_id = 2 AND codigo_barras = '7896862002107' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04021010' WHERE padaria_id = 2 AND codigo_barras = '7896256601848' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04012010' WHERE padaria_id = 2 AND codigo_barras = '7896569405003' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '197' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '019700' WHERE padaria_id = 2 AND codigo_barras = '197' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '196' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '019600' WHERE padaria_id = 2 AND codigo_barras = '196' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '48183000' WHERE padaria_id = 2 AND codigo_barras = '7896076001149' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7898944352285' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7898650860418' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7891035209901' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '16010000' WHERE padaria_id = 2 AND codigo_barras = '436' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '043600' WHERE padaria_id = 2 AND codigo_barras = '436' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '68052000' WHERE padaria_id = 2 AND codigo_barras = '0001' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '000100' WHERE padaria_id = 2 AND codigo_barras = '0001' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000092606' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '319' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '031900' WHERE padaria_id = 2 AND codigo_barras = '319' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1091' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '109100' WHERE padaria_id = 2 AND codigo_barras = '1091' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1092' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '109200' WHERE padaria_id = 2 AND codigo_barras = '1092' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1094' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '109400' WHERE padaria_id = 2 AND codigo_barras = '1094' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78946293' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78944305' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78923782' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '02071412' WHERE padaria_id = 2 AND codigo_barras = '78946460' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7896423419276' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049090' WHERE padaria_id = 2 AND codigo_barras = '582' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '058200' WHERE padaria_id = 2 AND codigo_barras = '582' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19021100' WHERE padaria_id = 2 AND codigo_barras = '7896005281710' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19021100' WHERE padaria_id = 2 AND codigo_barras = '7896005286579' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19021100' WHERE padaria_id = 2 AND codigo_barras = '7896005286593' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19021100' WHERE padaria_id = 2 AND codigo_barras = '7896205788217' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19021100' WHERE padaria_id = 2 AND codigo_barras = '7896022200213' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039021' WHERE padaria_id = 2 AND codigo_barras = '7896102584998' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039021' WHERE padaria_id = 2 AND codigo_barras = '7894000050027' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039011' WHERE padaria_id = 2 AND codigo_barras = '7891150072046' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039021' WHERE padaria_id = 2 AND codigo_barras = '7894000030470' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039011' WHERE padaria_id = 2 AND codigo_barras = '7897517205638' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039011' WHERE padaria_id = 2 AND codigo_barras = '7896102509434' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039021' WHERE padaria_id = 2 AND codigo_barras = '7891999948908' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '11081200' WHERE padaria_id = 2 AND codigo_barras = '7894000010021' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7897395020194' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '8888' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '888800' WHERE padaria_id = 2 AND codigo_barras = '8888' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '04051000' WHERE padaria_id = 2 AND codigo_barras = '151' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '015100' WHERE padaria_id = 2 AND codigo_barras = '151' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '33049100' WHERE padaria_id = 2 AND codigo_barras = '7896154101280' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180768' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180041' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180010' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180034' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180072' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180065' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180096' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180027' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180171' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180164' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180133' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180157' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180188' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180829' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069010' WHERE padaria_id = 2 AND codigo_barras = '7898378180447' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180140' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '15171000' WHERE padaria_id = 2 AND codigo_barras = '7891515537531' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '15171000' WHERE padaria_id = 2 AND codigo_barras = '7893000394209' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '15171000' WHERE padaria_id = 2 AND codigo_barras = '7891515644499' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049090' WHERE padaria_id = 2 AND codigo_barras = '329' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '032900' WHERE padaria_id = 2 AND codigo_barras = '329' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78947986' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '02012020' WHERE padaria_id = 2 AND codigo_barras = '78940871' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78937352' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78900134' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78900066' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '02012020' WHERE padaria_id = 2 AND codigo_barras = '78946781' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78903418' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78939837' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '231' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '023100' WHERE padaria_id = 2 AND codigo_barras = '231' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '1008' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '100800' WHERE padaria_id = 2 AND codigo_barras = '1008' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '39241000' WHERE padaria_id = 2 AND codigo_barras = '261' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '026100' WHERE padaria_id = 2 AND codigo_barras = '261' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '8710' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '871000' WHERE padaria_id = 2 AND codigo_barras = '8710' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '482' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '048200' WHERE padaria_id = 2 AND codigo_barras = '482' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '529' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '052900' WHERE padaria_id = 2 AND codigo_barras = '529' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '479' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '047900' WHERE padaria_id = 2 AND codigo_barras = '479' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '2002' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '200200' WHERE padaria_id = 2 AND codigo_barras = '2002' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '395' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '039500' WHERE padaria_id = 2 AND codigo_barras = '395' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19021900' WHERE padaria_id = 2 AND codigo_barras = '7896005271377' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7891098040688' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '300' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '030000' WHERE padaria_id = 2 AND codigo_barras = '300' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '228' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '022800' WHERE padaria_id = 2 AND codigo_barras = '228' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '993' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '099300' WHERE padaria_id = 2 AND codigo_barras = '993' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '508' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '050800' WHERE padaria_id = 2 AND codigo_barras = '508' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '02013000' WHERE padaria_id = 2 AND codigo_barras = '296' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '029600' WHERE padaria_id = 2 AND codigo_barras = '296' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20041000' WHERE padaria_id = 2 AND codigo_barras = '299' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '029900' WHERE padaria_id = 2 AND codigo_barras = '299' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16010000' WHERE padaria_id = 2 AND codigo_barras = '294' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '029400' WHERE padaria_id = 2 AND codigo_barras = '294' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16022000' WHERE padaria_id = 2 AND codigo_barras = '297' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '029700' WHERE padaria_id = 2 AND codigo_barras = '297' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16010000' WHERE padaria_id = 2 AND codigo_barras = '295' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '029500' WHERE padaria_id = 2 AND codigo_barras = '295' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '7896262304306' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '78947283' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '78947276' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '7895144603063' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '7895144603223' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '7895144603087' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20081900' WHERE padaria_id = 2 AND codigo_barras = '7891095002207' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '10059010' WHERE padaria_id = 2 AND codigo_barras = '7892300030107' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '078900' WHERE padaria_id = 2 AND codigo_barras = '789' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20058000' WHERE padaria_id = 2 AND codigo_barras = '7896292340503' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20058000' WHERE padaria_id = 2 AND codigo_barras = '7898902299058' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '399' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '039900' WHERE padaria_id = 2 AND codigo_barras = '399' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '9666' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '966600' WHERE padaria_id = 2 AND codigo_barras = '9666' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '220' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '022000' WHERE padaria_id = 2 AND codigo_barras = '220' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '6043' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '604300' WHERE padaria_id = 2 AND codigo_barras = '6043' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '8090' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '809000' WHERE padaria_id = 2 AND codigo_barras = '8090' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '406' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '040600' WHERE padaria_id = 2 AND codigo_barras = '406' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '225' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '022500' WHERE padaria_id = 2 AND codigo_barras = '225' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '27' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '002700' WHERE padaria_id = 2 AND codigo_barras = '27' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '316' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '031600' WHERE padaria_id = 2 AND codigo_barras = '316' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '221' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '022100' WHERE padaria_id = 2 AND codigo_barras = '221' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7898024395232' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '346' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '034600' WHERE padaria_id = 2 AND codigo_barras = '346' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '227' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '022700' WHERE padaria_id = 2 AND codigo_barras = '227' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '318' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '031800' WHERE padaria_id = 2 AND codigo_barras = '318' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '577' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '057700' WHERE padaria_id = 2 AND codigo_barras = '577' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '350' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '035000' WHERE padaria_id = 2 AND codigo_barras = '350' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '433' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '043300' WHERE padaria_id = 2 AND codigo_barras = '433' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '901' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '090100' WHERE padaria_id = 2 AND codigo_barras = '901' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '5099' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '509900' WHERE padaria_id = 2 AND codigo_barras = '5099' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '4089' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '408900' WHERE padaria_id = 2 AND codigo_barras = '4089' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '226' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '022600' WHERE padaria_id = 2 AND codigo_barras = '226' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16025000' WHERE padaria_id = 2 AND codigo_barras = '315' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '031500' WHERE padaria_id = 2 AND codigo_barras = '315' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '7891079013120' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '7891079013069' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '7891079000229' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '7891079000205' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '02109100' WHERE padaria_id = 2 AND codigo_barras = '257' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '025700' WHERE padaria_id = 2 AND codigo_barras = '257' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '149' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '014900' WHERE padaria_id = 2 AND codigo_barras = '149' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '02109100' WHERE padaria_id = 2 AND codigo_barras = '162' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '016200' WHERE padaria_id = 2 AND codigo_barras = '162' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '506' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '050600' WHERE padaria_id = 2 AND codigo_barras = '506' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '161' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '016100' WHERE padaria_id = 2 AND codigo_barras = '161' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '458' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '045800' WHERE padaria_id = 2 AND codigo_barras = '458' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '3091' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '309100' WHERE padaria_id = 2 AND codigo_barras = '3091' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16023220' WHERE padaria_id = 2 AND codigo_barras = '3092' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '309200' WHERE padaria_id = 2 AND codigo_barras = '3092' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16010000' WHERE padaria_id = 2 AND codigo_barras = '3093' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '309300' WHERE padaria_id = 2 AND codigo_barras = '3093' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896005272046' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896327511991' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '3090' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '309000' WHERE padaria_id = 2 AND codigo_barras = '3090' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '375' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '037500' WHERE padaria_id = 2 AND codigo_barras = '375' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '376' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '037600' WHERE padaria_id = 2 AND codigo_barras = '376' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '455' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '045500' WHERE padaria_id = 2 AND codigo_barras = '455' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '456' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '045600' WHERE padaria_id = 2 AND codigo_barras = '456' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '17049090' WHERE padaria_id = 2 AND codigo_barras = '7891098370198' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21031010' WHERE padaria_id = 2 AND codigo_barras = '7896007811021' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039091' WHERE padaria_id = 2 AND codigo_barras = '7898075643917' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039021' WHERE padaria_id = 2 AND codigo_barras = '7896025801196' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039021' WHERE padaria_id = 2 AND codigo_barras = '7896007811304' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21032010' WHERE padaria_id = 2 AND codigo_barras = '7899659901096' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21032010' WHERE padaria_id = 2 AND codigo_barras = '7897517206086' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21032010' WHERE padaria_id = 2 AND codigo_barras = '7896292333000' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21032010' WHERE padaria_id = 2 AND codigo_barras = '7899659901331' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039021' WHERE padaria_id = 2 AND codigo_barras = '7896056100176' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039091' WHERE padaria_id = 2 AND codigo_barras = '7898075643948' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039021' WHERE padaria_id = 2 AND codigo_barras = '7898286190316' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21031010' WHERE padaria_id = 2 AND codigo_barras = '7896007811007' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21031010' WHERE padaria_id = 2 AND codigo_barras = '7896056101234' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '070847022015' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20079990' WHERE padaria_id = 2 AND codigo_barras = '9008' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '900800' WHERE padaria_id = 2 AND codigo_barras = '9008' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20079990' WHERE padaria_id = 2 AND codigo_barras = '9011' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '901100' WHERE padaria_id = 2 AND codigo_barras = '9011' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20079990' WHERE padaria_id = 2 AND codigo_barras = '9007' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '900700' WHERE padaria_id = 2 AND codigo_barras = '9007' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20079990' WHERE padaria_id = 2 AND codigo_barras = '9010' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '901000' WHERE padaria_id = 2 AND codigo_barras = '9010' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '08101000' WHERE padaria_id = 2 AND codigo_barras = '909' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '090900' WHERE padaria_id = 2 AND codigo_barras = '909' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '08101000' WHERE padaria_id = 2 AND codigo_barras = '624' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '062400' WHERE padaria_id = 2 AND codigo_barras = '624' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET codigo_balanca = '901200' WHERE padaria_id = 2 AND codigo_barras = '9012' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET codigo_balanca = '901500' WHERE padaria_id = 2 AND codigo_barras = '9015' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '08101000' WHERE padaria_id = 2 AND codigo_barras = '616' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '061600' WHERE padaria_id = 2 AND codigo_barras = '616' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16010000' WHERE padaria_id = 2 AND codigo_barras = '915' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '091500' WHERE padaria_id = 2 AND codigo_barras = '915' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16010000' WHERE padaria_id = 2 AND codigo_barras = '946' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '094600' WHERE padaria_id = 2 AND codigo_barras = '946' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21032090' WHERE padaria_id = 2 AND codigo_barras = '7896102509144' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '010800' WHERE padaria_id = 2 AND codigo_barras = '108' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19019090' WHERE padaria_id = 2 AND codigo_barras = '310' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '031000' WHERE padaria_id = 2 AND codigo_barras = '310' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '309' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '030900' WHERE padaria_id = 2 AND codigo_barras = '309' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19019090' WHERE padaria_id = 2 AND codigo_barras = '308' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '030800' WHERE padaria_id = 2 AND codigo_barras = '308' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '325' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '032500' WHERE padaria_id = 2 AND codigo_barras = '325' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '04061010' WHERE padaria_id = 2 AND codigo_barras = '977' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '097700' WHERE padaria_id = 2 AND codigo_barras = '977' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19011030' WHERE padaria_id = 2 AND codigo_barras = '7891000319505' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7891000389300' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7891000389171' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21011110' WHERE padaria_id = 2 AND codigo_barras = '7891000307083' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000338162' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7891000359822' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19041000' WHERE padaria_id = 2 AND codigo_barras = '7891000070673' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7891000101926' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000312919' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7891000090732' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33074900' WHERE padaria_id = 2 AND codigo_barras = '7896013405238' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '07032090' WHERE padaria_id = 2 AND codigo_barras = '7896036096451' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '15179010' WHERE padaria_id = 2 AND codigo_barras = '7908435501068' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '15179010' WHERE padaria_id = 2 AND codigo_barras = '7896036098325' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '15079011' WHERE padaria_id = 2 AND codigo_barras = '7898247780297' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '206' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '020600' WHERE padaria_id = 2 AND codigo_barras = '206' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '204' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '020400' WHERE padaria_id = 2 AND codigo_barras = '204' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '205' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '020500' WHERE padaria_id = 2 AND codigo_barras = '205' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET codigo_balanca = '020400' WHERE padaria_id = 2 AND codigo_barras = '204' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET codigo_balanca = '020600' WHERE padaria_id = 2 AND codigo_barras = '206' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET codigo_balanca = '020500' WHERE padaria_id = 2 AND codigo_barras = '205' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '85061019' WHERE padaria_id = 2 AND codigo_barras = '208' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '020800' WHERE padaria_id = 2 AND codigo_barras = '208' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '207' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '020700' WHERE padaria_id = 2 AND codigo_barras = '207' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '8019' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '801900' WHERE padaria_id = 2 AND codigo_barras = '8019' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7622300830151' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7622300873554' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22030000' WHERE padaria_id = 2 AND codigo_barras = '7891991295086' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04072900' WHERE padaria_id = 2 AND codigo_barras = '106' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '010600' WHERE padaria_id = 2 AND codigo_barras = '106' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '164' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '016400' WHERE padaria_id = 2 AND codigo_barras = '164' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '39249000' WHERE padaria_id = 2 AND codigo_barras = '7898311540536' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049090' WHERE padaria_id = 2 AND codigo_barras = '7896336005917' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049090' WHERE padaria_id = 2 AND codigo_barras = '7891098310019' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049090' WHERE padaria_id = 2 AND codigo_barras = '7898530843142' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049010' WHERE padaria_id = 2 AND codigo_barras = '7898530842381' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '44219900' WHERE padaria_id = 2 AND codigo_barras = '7896007952144' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '44219900' WHERE padaria_id = 2 AND codigo_barras = '7896080900001' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19052010' WHERE padaria_id = 2 AND codigo_barras = '51' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '005100' WHERE padaria_id = 2 AND codigo_barras = '51' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '8092' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '809200' WHERE padaria_id = 2 AND codigo_barras = '8092' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '63071000' WHERE padaria_id = 2 AND codigo_barras = '7898124850020' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '63071000' WHERE padaria_id = 2 AND codigo_barras = '042882906735' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '2001' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '200100' WHERE padaria_id = 2 AND codigo_barras = '2001' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '9085' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '908500' WHERE padaria_id = 2 AND codigo_barras = '9085' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '178' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '017800' WHERE padaria_id = 2 AND codigo_barras = '178' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '156' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '015600' WHERE padaria_id = 2 AND codigo_barras = '156' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19021900' WHERE padaria_id = 2 AND codigo_barras = '388' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '038800' WHERE padaria_id = 2 AND codigo_barras = '388' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '179' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '017900' WHERE padaria_id = 2 AND codigo_barras = '179' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '169' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '016900' WHERE padaria_id = 2 AND codigo_barras = '169' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '169' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '016900' WHERE padaria_id = 2 AND codigo_barras = '169' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1992' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '199200' WHERE padaria_id = 2 AND codigo_barras = '1992' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '168' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '016800' WHERE padaria_id = 2 AND codigo_barras = '168' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '154' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '015400' WHERE padaria_id = 2 AND codigo_barras = '154' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '170' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '017000' WHERE padaria_id = 2 AND codigo_barras = '170' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '148' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '014800' WHERE padaria_id = 2 AND codigo_barras = '148' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '156' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '015600' WHERE padaria_id = 2 AND codigo_barras = '156' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '150' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '015000' WHERE padaria_id = 2 AND codigo_barras = '150' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '159' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '015900' WHERE padaria_id = 2 AND codigo_barras = '159' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '160' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '016000' WHERE padaria_id = 2 AND codigo_barras = '160' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '8093' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '809300' WHERE padaria_id = 2 AND codigo_barras = '8093' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '459' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '045900' WHERE padaria_id = 2 AND codigo_barras = '459' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '158' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '015800' WHERE padaria_id = 2 AND codigo_barras = '158' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059020' WHERE padaria_id = 2 AND codigo_barras = '8099' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '809900' WHERE padaria_id = 2 AND codigo_barras = '8099' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '2108' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '210800' WHERE padaria_id = 2 AND codigo_barras = '2108' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '167' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '016700' WHERE padaria_id = 2 AND codigo_barras = '167' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '166' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '016600' WHERE padaria_id = 2 AND codigo_barras = '166' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '157' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '015700' WHERE padaria_id = 2 AND codigo_barras = '157' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '178' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '017800' WHERE padaria_id = 2 AND codigo_barras = '178' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '222' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '022200' WHERE padaria_id = 2 AND codigo_barras = '222' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '992' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '099200' WHERE padaria_id = 2 AND codigo_barras = '992' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '3099' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '309900' WHERE padaria_id = 2 AND codigo_barras = '3099' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '5555' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '555500' WHERE padaria_id = 2 AND codigo_barras = '5555' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '9087' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '908700' WHERE padaria_id = 2 AND codigo_barras = '9087' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '9084' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '908400' WHERE padaria_id = 2 AND codigo_barras = '9084' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '348' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '034800' WHERE padaria_id = 2 AND codigo_barras = '348' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059010' WHERE padaria_id = 2 AND codigo_barras = '464' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '046400' WHERE padaria_id = 2 AND codigo_barras = '464' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19021900' WHERE padaria_id = 2 AND codigo_barras = '386' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '038600' WHERE padaria_id = 2 AND codigo_barras = '386' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059010' WHERE padaria_id = 2 AND codigo_barras = '384' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '038400' WHERE padaria_id = 2 AND codigo_barras = '384' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059010' WHERE padaria_id = 2 AND codigo_barras = '344' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '034400' WHERE padaria_id = 2 AND codigo_barras = '344' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059010' WHERE padaria_id = 2 AND codigo_barras = '536' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '053600' WHERE padaria_id = 2 AND codigo_barras = '536' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059010' WHERE padaria_id = 2 AND codigo_barras = '466' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '046600' WHERE padaria_id = 2 AND codigo_barras = '466' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '347' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '034700' WHERE padaria_id = 2 AND codigo_barras = '347' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '345' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '034500' WHERE padaria_id = 2 AND codigo_barras = '345' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7897972001165' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '481' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '048100' WHERE padaria_id = 2 AND codigo_barras = '481' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059010' WHERE padaria_id = 2 AND codigo_barras = '7891203010056' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059010' WHERE padaria_id = 2 AND codigo_barras = '7896002360326' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7891193010074' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '16023220' WHERE padaria_id = 2 AND codigo_barras = '253' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '025300' WHERE padaria_id = 2 AND codigo_barras = '253' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '258' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '025800' WHERE padaria_id = 2 AND codigo_barras = '258' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '342' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '034200' WHERE padaria_id = 2 AND codigo_barras = '342' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '403' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '040300' WHERE padaria_id = 2 AND codigo_barras = '403' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '465' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '046500' WHERE padaria_id = 2 AND codigo_barras = '465' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19021900' WHERE padaria_id = 2 AND codigo_barras = '385' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '038500' WHERE padaria_id = 2 AND codigo_barras = '385' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '341' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '034100' WHERE padaria_id = 2 AND codigo_barras = '341' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '9082' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '908200' WHERE padaria_id = 2 AND codigo_barras = '9082' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '472' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '047200' WHERE padaria_id = 2 AND codigo_barras = '472' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1112' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '111200' WHERE padaria_id = 2 AND codigo_barras = '1112' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '405' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '040500' WHERE padaria_id = 2 AND codigo_barras = '405' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '621' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '062100' WHERE padaria_id = 2 AND codigo_barras = '621' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7898910016012' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '13' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '001300' WHERE padaria_id = 2 AND codigo_barras = '13' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '247' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '024700' WHERE padaria_id = 2 AND codigo_barras = '247' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '3041' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '304100' WHERE padaria_id = 2 AND codigo_barras = '3041' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '362' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '036200' WHERE padaria_id = 2 AND codigo_barras = '362' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '340' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '034000' WHERE padaria_id = 2 AND codigo_barras = '340' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '460' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '046000' WHERE padaria_id = 2 AND codigo_barras = '460' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '424' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '042400' WHERE padaria_id = 2 AND codigo_barras = '424' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '155' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '015500' WHERE padaria_id = 2 AND codigo_barras = '155' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '39' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '003900' WHERE padaria_id = 2 AND codigo_barras = '39' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19021900' WHERE padaria_id = 2 AND codigo_barras = '38' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '003800' WHERE padaria_id = 2 AND codigo_barras = '38' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1440' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '144000' WHERE padaria_id = 2 AND codigo_barras = '1440' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '224' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '022400' WHERE padaria_id = 2 AND codigo_barras = '224' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '402' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '040200' WHERE padaria_id = 2 AND codigo_barras = '402' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '486' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '048600' WHERE padaria_id = 2 AND codigo_barras = '486' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '151' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '015100' WHERE padaria_id = 2 AND codigo_barras = '151' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '152' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '015200' WHERE padaria_id = 2 AND codigo_barras = '152' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '407' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '040700' WHERE padaria_id = 2 AND codigo_barras = '407' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059010' WHERE padaria_id = 2 AND codigo_barras = '147' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '014700' WHERE padaria_id = 2 AND codigo_barras = '147' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '153' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '015300' WHERE padaria_id = 2 AND codigo_barras = '153' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19021900' WHERE padaria_id = 2 AND codigo_barras = '380' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '038000' WHERE padaria_id = 2 AND codigo_barras = '380' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1013' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '101300' WHERE padaria_id = 2 AND codigo_barras = '1013' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '401' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '040100' WHERE padaria_id = 2 AND codigo_barras = '401' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1034' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '103400' WHERE padaria_id = 2 AND codigo_barras = '1034' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '76071110' WHERE padaria_id = 2 AND codigo_barras = '7898930672465' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48181000' WHERE padaria_id = 2 AND codigo_barras = '7896053410025' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48181000' WHERE padaria_id = 2 AND codigo_barras = '7896076000388' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48181000' WHERE padaria_id = 2 AND codigo_barras = '7896053411626' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48181000' WHERE padaria_id = 2 AND codigo_barras = '7896110000176' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48181000' WHERE padaria_id = 2 AND codigo_barras = '7899853800249' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48181000' WHERE padaria_id = 2 AND codigo_barras = '7898910365028' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48189090' WHERE padaria_id = 2 AND codigo_barras = '7897844300730' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48189090' WHERE padaria_id = 2 AND codigo_barras = '7896110012728' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48182000' WHERE padaria_id = 2 AND codigo_barras = '7898329809991' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48182000' WHERE padaria_id = 2 AND codigo_barras = '7896075301080' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19022000' WHERE padaria_id = 2 AND codigo_barras = '1014' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '101400' WHERE padaria_id = 2 AND codigo_barras = '1014' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '8082' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '808200' WHERE padaria_id = 2 AND codigo_barras = '8082' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '626' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '062600' WHERE padaria_id = 2 AND codigo_barras = '626' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '17049020' WHERE padaria_id = 2 AND codigo_barras = '78910041' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '16022000' WHERE padaria_id = 2 AND codigo_barras = '7893000025653' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '3042' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '304200' WHERE padaria_id = 2 AND codigo_barras = '3042' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '328' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '032800' WHERE padaria_id = 2 AND codigo_barras = '328' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '334' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '033400' WHERE padaria_id = 2 AND codigo_barras = '334' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '292' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '029200' WHERE padaria_id = 2 AND codigo_barras = '292' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16023290' WHERE padaria_id = 2 AND codigo_barras = '606' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '060600' WHERE padaria_id = 2 AND codigo_barras = '606' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16023100' WHERE padaria_id = 2 AND codigo_barras = '991' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '099100' WHERE padaria_id = 2 AND codigo_barras = '991' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '251' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '025100' WHERE padaria_id = 2 AND codigo_barras = '251' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912731' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912069' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912977' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912038' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912007' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912205' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912397' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912557' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912540' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912984' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513909168' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912755' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912359' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '85061020' WHERE padaria_id = 2 AND codigo_barras = '8002' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '800200' WHERE padaria_id = 2 AND codigo_barras = '8002' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '85061020' WHERE padaria_id = 2 AND codigo_barras = '041333050812' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '85061020' WHERE padaria_id = 2 AND codigo_barras = '7896067203040' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '85061020' WHERE padaria_id = 2 AND codigo_barras = '041333050850' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '85061019' WHERE padaria_id = 2 AND codigo_barras = '142' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '014200' WHERE padaria_id = 2 AND codigo_barras = '142' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '85061020' WHERE padaria_id = 2 AND codigo_barras = '7896067203033' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '82141000' WHERE padaria_id = 2 AND codigo_barras = '9009' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '900900' WHERE padaria_id = 2 AND codigo_barras = '9009' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19019020' WHERE padaria_id = 2 AND codigo_barras = '10001' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20081900' WHERE padaria_id = 2 AND codigo_barras = '7898416527104' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19041000' WHERE padaria_id = 2 AND codigo_barras = '7898667960125' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17049090' WHERE padaria_id = 2 AND codigo_barras = '260' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '026000' WHERE padaria_id = 2 AND codigo_barras = '260' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '17049090' WHERE padaria_id = 2 AND codigo_barras = '7898964630929' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '37' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '003700' WHERE padaria_id = 2 AND codigo_barras = '37' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '467' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '046700' WHERE padaria_id = 2 AND codigo_barras = '467' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21023000' WHERE padaria_id = 2 AND codigo_barras = '7622300119621' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04061090' WHERE padaria_id = 2 AND codigo_barras = '7891143017887' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '298' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '029800' WHERE padaria_id = 2 AND codigo_barras = '298' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16010000' WHERE padaria_id = 2 AND codigo_barras = '212' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '021200' WHERE padaria_id = 2 AND codigo_barras = '212' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '213' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '021300' WHERE padaria_id = 2 AND codigo_barras = '213' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '210' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '021000' WHERE padaria_id = 2 AND codigo_barras = '210' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '209' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '020900' WHERE padaria_id = 2 AND codigo_barras = '209' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '211' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '021100' WHERE padaria_id = 2 AND codigo_barras = '211' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900504002' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900500035' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900503029' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900501001' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '96151900' WHERE padaria_id = 2 AND codigo_barras = '7081' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '708100' WHERE padaria_id = 2 AND codigo_barras = '7081' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000460207' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000454589' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '82121020' WHERE padaria_id = 2 AND codigo_barras = '7500435154420' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '16024100' WHERE padaria_id = 2 AND codigo_barras = '976' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '097600' WHERE padaria_id = 2 AND codigo_barras = '976' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20052000' WHERE padaria_id = 2 AND codigo_barras = '7896004008998' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20052000' WHERE padaria_id = 2 AND codigo_barras = '7896004006277' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '96190000' WHERE padaria_id = 2 AND codigo_barras = '7896007550548' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19021900' WHERE padaria_id = 2 AND codigo_barras = '20' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '002000' WHERE padaria_id = 2 AND codigo_barras = '20' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '324' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '032400' WHERE padaria_id = 2 AND codigo_barras = '324' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '3004' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '300400' WHERE padaria_id = 2 AND codigo_barras = '3004' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '3005' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '300500' WHERE padaria_id = 2 AND codigo_barras = '3005' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '71179000' WHERE padaria_id = 2 AND codigo_barras = '6071' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '607100' WHERE padaria_id = 2 AND codigo_barras = '6071' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16024900' WHERE padaria_id = 2 AND codigo_barras = '7898021631319' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '523' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '052300' WHERE padaria_id = 2 AND codigo_barras = '523' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '04061090' WHERE padaria_id = 2 AND codigo_barras = '160' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '016000' WHERE padaria_id = 2 AND codigo_barras = '160' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16022000' WHERE padaria_id = 2 AND codigo_barras = '485' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '048500' WHERE padaria_id = 2 AND codigo_barras = '485' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '04069020' WHERE padaria_id = 2 AND codigo_barras = '960' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '096000' WHERE padaria_id = 2 AND codigo_barras = '960' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '04061090' WHERE padaria_id = 2 AND codigo_barras = '960' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '096000' WHERE padaria_id = 2 AND codigo_barras = '960' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '145' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '014500' WHERE padaria_id = 2 AND codigo_barras = '145' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '04062000' WHERE padaria_id = 2 AND codigo_barras = '7896051165491' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '23091000' WHERE padaria_id = 2 AND codigo_barras = '1133' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '113300' WHERE padaria_id = 2 AND codigo_barras = '1133' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '23091000' WHERE padaria_id = 2 AND codigo_barras = '1134' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '113400' WHERE padaria_id = 2 AND codigo_barras = '1134' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1137' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '113700' WHERE padaria_id = 2 AND codigo_barras = '1137' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1136' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '113600' WHERE padaria_id = 2 AND codigo_barras = '1136' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '611269991000' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7891991008655' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04061090' WHERE padaria_id = 2 AND codigo_barras = '7896862003098' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04061090' WHERE padaria_id = 2 AND codigo_barras = '7898217001872' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04061090' WHERE padaria_id = 2 AND codigo_barras = '7896030518027' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '04061010' WHERE padaria_id = 2 AND codigo_barras = '7896030521690' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '238' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '023800' WHERE padaria_id = 2 AND codigo_barras = '238' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '239' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '023900' WHERE padaria_id = 2 AND codigo_barras = '239' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '531' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '053100' WHERE padaria_id = 2 AND codigo_barras = '531' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '478' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '047800' WHERE padaria_id = 2 AND codigo_barras = '478' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '400' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '040000' WHERE padaria_id = 2 AND codigo_barras = '400' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '96039000' WHERE padaria_id = 2 AND codigo_barras = '7897788822022' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19021900' WHERE padaria_id = 2 AND codigo_barras = '784' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '078400' WHERE padaria_id = 2 AND codigo_barras = '784' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7896071030014' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7896253401472' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7896071030007' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7896071021548' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '382' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '038200' WHERE padaria_id = 2 AND codigo_barras = '382' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '02012020' WHERE padaria_id = 2 AND codigo_barras = '78947580' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78944220' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '02012020' WHERE padaria_id = 2 AND codigo_barras = '78947627' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78943087' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78942806' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78944527' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78944541' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34011900' WHERE padaria_id = 2 AND codigo_barras = '7908324402865' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34011900' WHERE padaria_id = 2 AND codigo_barras = '58' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '005800' WHERE padaria_id = 2 AND codigo_barras = '58' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7891150064317' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7896098909737' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7896098909720' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7896098909751' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34013000' WHERE padaria_id = 2 AND codigo_barras = '2000000003122' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34011190' WHERE padaria_id = 2 AND codigo_barras = '7509546695389' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34011190' WHERE padaria_id = 2 AND codigo_barras = '7896098902233' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34011190' WHERE padaria_id = 2 AND codigo_barras = '7891150095304' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34011190' WHERE padaria_id = 2 AND codigo_barras = '7891024034880' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34011190' WHERE padaria_id = 2 AND codigo_barras = '7908324410167' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34011190' WHERE padaria_id = 2 AND codigo_barras = '7908324410174' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '303900' WHERE padaria_id = 2 AND codigo_barras = '3039' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '25010020' WHERE padaria_id = 2 AND codigo_barras = '7896035210001' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '25010020' WHERE padaria_id = 2 AND codigo_barras = '7896035210018' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '25010020' WHERE padaria_id = 2 AND codigo_barras = '7896035210018' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '25010020' WHERE padaria_id = 2 AND codigo_barras = '7896110100814' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '25010020' WHERE padaria_id = 2 AND codigo_barras = '7896110100043' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '16010000' WHERE padaria_id = 2 AND codigo_barras = '984' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '098400' WHERE padaria_id = 2 AND codigo_barras = '984' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19041000' WHERE padaria_id = 2 AND codigo_barras = '7892840822811' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7892840822866' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '9056' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '905600' WHERE padaria_id = 2 AND codigo_barras = '9056' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '2020' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '202000' WHERE padaria_id = 2 AND codigo_barras = '2020' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '240' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '024000' WHERE padaria_id = 2 AND codigo_barras = '240' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '236' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '023600' WHERE padaria_id = 2 AND codigo_barras = '236' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16041310' WHERE padaria_id = 2 AND codigo_barras = '7898943163011' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '16041310' WHERE padaria_id = 2 AND codigo_barras = '7896117101036' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '16041310' WHERE padaria_id = 2 AND codigo_barras = '7896009301049' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '16041310' WHERE padaria_id = 2 AND codigo_barras = '789943163011' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '16041310' WHERE padaria_id = 2 AND codigo_barras = '7896117101043' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '16041310' WHERE padaria_id = 2 AND codigo_barras = '7896114901738' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '38089119' WHERE padaria_id = 2 AND codigo_barras = '7891035618567' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900180541' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900180503' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33074900' WHERE padaria_id = 2 AND codigo_barras = '7896013404682' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '33059000' WHERE padaria_id = 2 AND codigo_barras = '420' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '042000' WHERE padaria_id = 2 AND codigo_barras = '420' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '473' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '047300' WHERE padaria_id = 2 AND codigo_barras = '473' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '3040' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '304000' WHERE padaria_id = 2 AND codigo_barras = '3040' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19041000' WHERE padaria_id = 2 AND codigo_barras = '7891000050880' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19023000' WHERE padaria_id = 2 AND codigo_barras = '507' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '050700' WHERE padaria_id = 2 AND codigo_barras = '507' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '378' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '037800' WHERE padaria_id = 2 AND codigo_barras = '378' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '435' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '043500' WHERE padaria_id = 2 AND codigo_barras = '435' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '30049029' WHERE padaria_id = 2 AND codigo_barras = '7896090611607' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513916104' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '7896513910065' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513910058' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513915336' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513940093' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513915107' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513940017' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513916012' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513915237' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513915220' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513912717' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513940178' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513915251' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900681000' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '78939745' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900681178' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900681017' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900065206' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22011000' WHERE padaria_id = 2 AND codigo_barras = '135' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '013500' WHERE padaria_id = 2 AND codigo_barras = '135' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900680522' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900680508' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7894900061512' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '3052' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '305200' WHERE padaria_id = 2 AND codigo_barras = '3052' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20091900' WHERE padaria_id = 2 AND codigo_barras = '3056' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '305600' WHERE padaria_id = 2 AND codigo_barras = '3056' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20091900' WHERE padaria_id = 2 AND codigo_barras = '3055' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '305500' WHERE padaria_id = 2 AND codigo_barras = '3055' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '3057' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '305700' WHERE padaria_id = 2 AND codigo_barras = '3057' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '6000' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '600000' WHERE padaria_id = 2 AND codigo_barras = '6000' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '463' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '046300' WHERE padaria_id = 2 AND codigo_barras = '463' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '3051' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '305100' WHERE padaria_id = 2 AND codigo_barras = '3051' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET codigo_balanca = '011100' WHERE padaria_id = 2 AND codigo_barras = '111' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20091900' WHERE padaria_id = 2 AND codigo_barras = '3048' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '304800' WHERE padaria_id = 2 AND codigo_barras = '3048' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20091200' WHERE padaria_id = 2 AND codigo_barras = '3049' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '304900' WHERE padaria_id = 2 AND codigo_barras = '3049' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20091900' WHERE padaria_id = 2 AND codigo_barras = '3050' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '305000' WHERE padaria_id = 2 AND codigo_barras = '3050' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '6001' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '600100' WHERE padaria_id = 2 AND codigo_barras = '6001' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '3062' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '306200' WHERE padaria_id = 2 AND codigo_barras = '3062' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '3054' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '305400' WHERE padaria_id = 2 AND codigo_barras = '3054' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20096100' WHERE padaria_id = 2 AND codigo_barras = '6002' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '600200' WHERE padaria_id = 2 AND codigo_barras = '6002' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894900660425' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180751' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180058' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7898378180447' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20091900' WHERE padaria_id = 2 AND codigo_barras = '7898953148701' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '20096100' WHERE padaria_id = 2 AND codigo_barras = '7898953148718' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069010' WHERE padaria_id = 2 AND codigo_barras = '7891122124018' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7896229800872' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7899916906031' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7899916906031' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7899916904716' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000455722' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21050010' WHERE padaria_id = 2 AND codigo_barras = '7896513915152' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18063110' WHERE padaria_id = 2 AND codigo_barras = '7891000408490' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19019090' WHERE padaria_id = 2 AND codigo_barras = '327' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '032700' WHERE padaria_id = 2 AND codigo_barras = '327' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '3006' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '300600' WHERE padaria_id = 2 AND codigo_barras = '3006' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069010' WHERE padaria_id = 2 AND codigo_barras = '7622210571526' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069010' WHERE padaria_id = 2 AND codigo_barras = '7622210571755' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069010' WHERE padaria_id = 2 AND codigo_barras = '7622210571496' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069010' WHERE padaria_id = 2 AND codigo_barras = '7622210571601' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069010' WHERE padaria_id = 2 AND codigo_barras = '7622210571540' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069010' WHERE padaria_id = 2 AND codigo_barras = '7622210571694' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069010' WHERE padaria_id = 2 AND codigo_barras = '7622210571724' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069010' WHERE padaria_id = 2 AND codigo_barras = '7622210571632' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069010' WHERE padaria_id = 2 AND codigo_barras = '7622210571786' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069010' WHERE padaria_id = 2 AND codigo_barras = '7622210571663' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069010' WHERE padaria_id = 2 AND codigo_barras = '7622210571786' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19030000' WHERE padaria_id = 2 AND codigo_barras = '180' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '018000' WHERE padaria_id = 2 AND codigo_barras = '180' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19030000' WHERE padaria_id = 2 AND codigo_barras = '184' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '018400' WHERE padaria_id = 2 AND codigo_barras = '184' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '8097' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '809700' WHERE padaria_id = 2 AND codigo_barras = '8097' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '186' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '018600' WHERE padaria_id = 2 AND codigo_barras = '186' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19030000' WHERE padaria_id = 2 AND codigo_barras = '7898994081630' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19030000' WHERE padaria_id = 2 AND codigo_barras = '7898994081623' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19030000' WHERE padaria_id = 2 AND codigo_barras = '181' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '018100' WHERE padaria_id = 2 AND codigo_barras = '181' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '181' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '018100' WHERE padaria_id = 2 AND codigo_barras = '181' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '183' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '018300' WHERE padaria_id = 2 AND codigo_barras = '183' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '182' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '018200' WHERE padaria_id = 2 AND codigo_barras = '182' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '35061010' WHERE padaria_id = 2 AND codigo_barras = '7898904869044' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21041011' WHERE padaria_id = 2 AND codigo_barras = '7891000251539' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21039021' WHERE padaria_id = 2 AND codigo_barras = '7891132019281' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '09109900' WHERE padaria_id = 2 AND codigo_barras = '7891132019724' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '82130000' WHERE padaria_id = 2 AND codigo_barras = '70' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '007000' WHERE padaria_id = 2 AND codigo_barras = '70' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '34025000' WHERE padaria_id = 2 AND codigo_barras = '7896055510594' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22029900' WHERE padaria_id = 2 AND codigo_barras = '7894321722016' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22021000' WHERE padaria_id = 2 AND codigo_barras = '7891991000840' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19054000' WHERE padaria_id = 2 AND codigo_barras = '493' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '049300' WHERE padaria_id = 2 AND codigo_barras = '493' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19054000' WHERE padaria_id = 2 AND codigo_barras = '404' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '040400' WHERE padaria_id = 2 AND codigo_barras = '404' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '3010' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '301000' WHERE padaria_id = 2 AND codigo_barras = '3010' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '3031' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '303100' WHERE padaria_id = 2 AND codigo_barras = '3031' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '3009' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '300900' WHERE padaria_id = 2 AND codigo_barras = '3009' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '314' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '031400' WHERE padaria_id = 2 AND codigo_barras = '314' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '3003' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '300300' WHERE padaria_id = 2 AND codigo_barras = '3003' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '3002' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '300200' WHERE padaria_id = 2 AND codigo_barras = '3002' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '3011' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '301100' WHERE padaria_id = 2 AND codigo_barras = '3011' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '3001' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '300100' WHERE padaria_id = 2 AND codigo_barras = '3001' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '3000' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '300000' WHERE padaria_id = 2 AND codigo_barras = '3000' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '3012' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '301200' WHERE padaria_id = 2 AND codigo_barras = '3012' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '3008' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '300800' WHERE padaria_id = 2 AND codigo_barras = '3008' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '1117' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '111700' WHERE padaria_id = 2 AND codigo_barras = '1117' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '3015' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '301500' WHERE padaria_id = 2 AND codigo_barras = '3015' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '4040' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '404000' WHERE padaria_id = 2 AND codigo_barras = '4040' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '323' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '032300' WHERE padaria_id = 2 AND codigo_barras = '323' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '30' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '003000' WHERE padaria_id = 2 AND codigo_barras = '30' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '4020' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '402000' WHERE padaria_id = 2 AND codigo_barras = '4020' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19052090' WHERE padaria_id = 2 AND codigo_barras = '453' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '045300' WHERE padaria_id = 2 AND codigo_barras = '453' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '313' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '031300' WHERE padaria_id = 2 AND codigo_barras = '313' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7622210592750' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7622210592668' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7622210592781' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053100' WHERE padaria_id = 2 AND codigo_barras = '7622210592637' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '7895800304235' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '7895800304211' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '7895800309780' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '7895800304228' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '7895800201503' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '7895800430002' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '7622210564337' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '17041000' WHERE padaria_id = 2 AND codigo_barras = '7622210564313' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '7622210564290' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '7622210573261' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069050' WHERE padaria_id = 2 AND codigo_barras = '7622210570376' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '449' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '044900' WHERE padaria_id = 2 AND codigo_barras = '449' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '450' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '045000' WHERE padaria_id = 2 AND codigo_barras = '450' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '462' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '046200' WHERE padaria_id = 2 AND codigo_barras = '462' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '82142000' WHERE padaria_id = 2 AND codigo_barras = '6089' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '608900' WHERE padaria_id = 2 AND codigo_barras = '6089' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '82142000' WHERE padaria_id = 2 AND codigo_barras = '001' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '000100' WHERE padaria_id = 2 AND codigo_barras = '001' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '96039000' WHERE padaria_id = 2 AND codigo_barras = '7898311540031' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7896523107578' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7896523107462' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7896523163437' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7896523107486' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7896523107516' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7896523158761' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7896523158808' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7896523107547' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7896523158884' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7897284230420' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7899348576178' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7899348576284' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7896017461803' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7896017470201' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '34060000' WHERE padaria_id = 2 AND codigo_barras = '7896302100028' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '22084000' WHERE padaria_id = 2 AND codigo_barras = '417' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '041700' WHERE padaria_id = 2 AND codigo_barras = '417' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '22090000' WHERE padaria_id = 2 AND codigo_barras = '7896048284631' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '470' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '047000' WHERE padaria_id = 2 AND codigo_barras = '470' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069030' WHERE padaria_id = 2 AND codigo_barras = '3060' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '306000' WHERE padaria_id = 2 AND codigo_barras = '3060' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20091900' WHERE padaria_id = 2 AND codigo_barras = '3058' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '305800' WHERE padaria_id = 2 AND codigo_barras = '3058' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '3059' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '305900' WHERE padaria_id = 2 AND codigo_barras = '3059' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '20099000' WHERE padaria_id = 2 AND codigo_barras = '3061' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '306100' WHERE padaria_id = 2 AND codigo_barras = '3061' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '21069090' WHERE padaria_id = 2 AND codigo_barras = '491' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '049100' WHERE padaria_id = 2 AND codigo_barras = '491' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19053200' WHERE padaria_id = 2 AND codigo_barras = '7891000329207' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000077962' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '18069000' WHERE padaria_id = 2 AND codigo_barras = '7891000364253' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053200' WHERE padaria_id = 2 AND codigo_barras = '7891000077948' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '19053200' WHERE padaria_id = 2 AND codigo_barras = '7891000372586' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78943353' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '24022000' WHERE padaria_id = 2 AND codigo_barras = '78939103' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '16025000' WHERE padaria_id = 2 AND codigo_barras = '172' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '017200' WHERE padaria_id = 2 AND codigo_barras = '172' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '02101200' WHERE padaria_id = 2 AND codigo_barras = '174' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '017400' WHERE padaria_id = 2 AND codigo_barras = '174' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16010000' WHERE padaria_id = 2 AND codigo_barras = '175' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '017500' WHERE padaria_id = 2 AND codigo_barras = '175' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '173' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '017300' WHERE padaria_id = 2 AND codigo_barras = '173' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '176' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '017600' WHERE padaria_id = 2 AND codigo_barras = '176' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '19059090' WHERE padaria_id = 2 AND codigo_barras = '171' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '017100' WHERE padaria_id = 2 AND codigo_barras = '171' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '16025000' WHERE padaria_id = 2 AND codigo_barras = '177' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET codigo_balanca = '017700' WHERE padaria_id = 2 AND codigo_barras = '177' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET codigo_balanca = '037100' WHERE padaria_id = 2 AND codigo_barras = '371' AND (codigo_balanca IS NULL OR codigo_balanca = '');
UPDATE produtos SET ncm = '04039000' WHERE padaria_id = 2 AND codigo_barras = '78911000' AND (ncm IS NULL OR ncm = '');
UPDATE produtos SET ncm = '48131000' WHERE padaria_id = 2 AND codigo_barras = '78420274' AND (ncm IS NULL OR ncm = '');
SELECT COUNT(*) AS produtos_jota2 FROM produtos WHERE padaria_id = 2;
