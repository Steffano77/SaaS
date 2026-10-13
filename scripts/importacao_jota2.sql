-- Importacao de produtos da Padaria do Jota 2 (padaria_id = 2), gerado da planilha do Saurus.
-- Pode rodar mais de uma vez: so insere o codigo que ainda nao existe pra padaria 2.
SET NAMES utf8mb4;
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Kit festa massa de chocolate', '4445', 'un', 280.00, 0.0000, 0.000, '02071412', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4445');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Kit festa massa branca', '4444', 'un', 260.00, 0.0000, 0.000, '02071412', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4444');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'CENTO DE SALGADO FRITO', '901', 'un', 100.00, 0.0000, 689.010, '19059090', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '901');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'café moido', '998', 'kg', 95.00, 0.0000, 0.000, '09012200', 'st', '998', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '998');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'CENTO DE DOCINHO', '4446', 'un', 90.00, 0.0000, 0.000, '19059090', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '4446');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'CENTO DE SALGADO CRÚ', '900', 'un', 80.00, 0.0000, 0.000, '02071412', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '900');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'BOLO DECORADO TRUFADO', '605', 'kg', 75.00, 0.0000, 0.000, '19059090', 'normal', '605', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '605');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'BOLO DECORADO MASSA DE CHOCOLATE', '604', 'kg', 70.00, 0.0000, 0.000, '19052090', 'normal', '604', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '604');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'BOLO DECORADO MASSA BRANCA', '603', 'kg', 60.00, 0.0000, 0.000, '19059090', 'normal', '603', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '603');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Açaí FRUTOS 1.3kg', '7896513909014', 'un', 45.00, 34.5000, 0.000, '08119000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513909014');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Biscoito goiania', '9000', 'kg', 40.00, 0.0000, 0.000, '19059090', 'st', '9000', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9000');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'croissant de goiabada', '398', 'kg', 40.00, 0.0000, 0.000, '19022000', 'st', '398', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '398');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Biscoito amanteigado Jota', '1132', 'kg', 40.00, 16.0000, 0.000, '19053100', 'st', '1132', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1132');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'bolo de chocolate c/ cobertura', '391', 'kg', 37.00, 0.0000, 0.000, '19059090', 'st', '391', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '391');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'jundia napolitano 2 litros', '7898036492370', 'un', 32.00, 0.0000, 0.000, '21050010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898036492370');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'sorvetes pote 2 litros flocos', '7898036491472', 'un', 32.00, 0.0000, 0.000, '21050010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898036491472');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'SORVETES e 3 em 1 cioccolato jundia 2 litros', '7898036492738', 'un', 32.00, 0.0000, 0.000, '21050010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898036492738');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'LINGUIÇA CALABRESA PERDIGAO', '3036', 'kg', 32.00, 0.0000, 0.000, '16010000', 'normal', '3036', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3036');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'havaianas branca 41/42', '7891109714508', 'un', 30.00, 0.0000, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109714508');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'havaianas azul 41/42', '7890541601902', 'un', 30.00, 0.0000, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890541601902');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaianas preto 35/36', '7891109486207', 'un', 30.00, 21.7600, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109486207');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaianas Branca lisa 39/40', '7891109714492', 'un', 30.00, 21.7600, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109714492');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaianas rosa 35/36', '7893249648064', 'un', 30.00, 21.7600, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7893249648064');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'havaianas 33/34 rosa', '7893249648057', 'un', 30.00, 0.0000, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7893249648057');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'havaianas 35/36  azul marinho', '7890541601872', 'un', 30.00, 0.0000, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890541601872');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaiana preto 37/38', '7891109486214', 'un', 30.00, 21.7600, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109486214');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaiana Branca lisa 37/38', '7891109714485', 'un', 30.00, 21.7600, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109714485');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'havaianas 37/38 azul', '7890541601889', 'un', 30.00, 0.0000, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890541601889');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaianas rosa 37/38', '7893249648071', 'un', 30.00, 21.7600, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7893249648071');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaiana preta 43/44', '7891109486245', 'un', 30.00, 21.7600, 0.000, '64022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109486245');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'mini broa', '399', 'kg', 29.99, 0.0000, 0.000, '19059090', 'st', '399', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '399');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'HAVAIANAS BRANCO 35/36', '7891109714478', 'un', 28.00, 0.0000, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109714478');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'bolo de cenoura', '390', 'kg', 28.00, 0.0000, 0.000, '19059090', 'st', '390', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '390');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'bolo de aipim', '336', 'kg', 28.00, 0.0000, 0.000, '19059090', 'st', '336', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '336');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bolo de fuba c/ coco', '1118', 'kg', 28.00, 0.0000, 0.000, '19059090', 'st', '1118', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1118');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'bolo de fubá', '389', 'kg', 27.99, 0.0000, 0.000, '19052090', 'st', '389', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '389');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'BOLO DE LARANJA', '393', 'kg', 27.99, 0.0000, 0.000, '19059090', 'st', '393', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '393');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'BOLO DE MILHO', '567', 'kg', 27.99, 0.0000, 0.000, '19059090', 'normal', '567', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '567');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'havaianas 27/28 azul', '7890557722189', 'un', 26.00, 0.0000, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557722189');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'havaianas 29/30 preto', '7891109635209', 'un', 26.00, 0.0000, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109635209');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'havaianas 27/28 branca', '7891109714430', 'un', 26.00, 0.0000, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109714430');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'BISTECA SADIA', '1031', 'kg', 25.00, 0.0000, 0.000, '02012020', 'st', '1031', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1031');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Leite em pó integral piracanjuba 400g', '7898215152347', 'un', 23.85, 15.7900, 6.000, '04022110', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898215152347');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'pão de hamburguer', '403', 'kg', 22.00, 0.0000, 0.000, '19052090', 'st', '403', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '403');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'HAVAIANAS BRANCO 31/32', '7891109714454', 'un', 21.65, 0.0000, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891109714454');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Oleo comp Maria tradicional 500ml', '7896036092934', 'un', 21.50, 16.4000, 1.000, '15179010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896036092934');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Óleo composto Cebola e alho Maria 500ml', '7896036096451', 'un', 19.99, 12.9600, 2.000, '15179010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896036096451');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'TORRADA SIMPLES', '404', 'kg', 16.99, 0.0000, 0.000, '19054000', 'normal', '404', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '404');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Rothmans internacional azul Max', '78947603', 'un', 16.00, 12.9200, 0.000, '24022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947603');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Red bull 473ml', '9002490214166', 'un', 16.00, 10.7200, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9002490214166');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Mini Nutella 140g', '7898024395232', 'un', 15.99, 9.9900, 0.000, '18069000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898024395232');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Óleo milho Liza 900ml', '7896036090619', 'un', 15.40, 13.3800, 0.000, '15152910', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896036090619');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Rothmans click sense Max', '78947597', 'un', 15.00, 0.0000, 0.000, '24022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947597');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Canoa de Frango', '997', 'un', 15.00, 0.0000, 0.000, '44219900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '997');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Achocolatado Toddy 370g', '7892840819507', 'un', 14.99, 9.9600, 4.000, '18069000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840819507');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Composto todo dia Itambé 400g', '7896051168720', 'un', 14.85, 8.9000, 0.000, '19019090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896051168720');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Lucky Strike Purple Mix', '78946217', 'pc', 14.50, 0.0000, 0.000, '24022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78946217');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Marlboro crafted selection gold', '78946798', 'un', 14.25, 11.3100, 0.000, '24022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78946798');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Marlboro gold/ouro', '78900073', 'un', 13.75, 11.5400, 0.000, '24022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78900073');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'MAIONESE HELLMAN´NS 500GR', '7894000050034', 'un', 13.50, 8.6000, 0.000, '21039011', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894000050034');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sprite 2 Litros', '7894900681000', 'un', 13.50, 8.2800, 0.000, '22021000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900681000');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Oleo Composto Faisão 500ml', '7908435500085', 'un', 13.50, 8.4900, 12.000, '15179010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908435500085');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'CARVAO 3 irmãos 2kg', '7908119296822', 'un', 13.00, 10.0000, 0.000, '44029000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908119296822');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Monster Energy zero acucar 473ml', '7898938890076', 'un', 12.50, 0.0000, 0.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898938890076');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Monster mango loko 473ml', '070847033301', 'cx', 12.50, 0.0000, 1.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '070847033301');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Monster ultra branco sem açucar 473ml', '070847022206', 'un', 12.50, 8.0800, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '070847022206');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Monster Energy Ultra 473ml', '070847022015', 'un', 12.50, 8.3300, 0.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '070847022015');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Óleo composto de soja e oliva faisao 500ml', '7908435500665', 'un', 12.10, 8.4800, 9.000, '15179010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908435500665');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Torta de morango cravejado', '9013', 'un', 12.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '9013');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Leite em pó integral 200g', '7898080640376', 'pc', 12.00, 6.9900, 0.000, '04022110', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898080640376');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Brahma duplo malte 600ml', '7891149000142', 'un', 12.00, 6.8400, 5.000, '22030000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891149000142');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Torta de Pistache Fatia', '1117', 'un', 12.00, 0.0000, 0.000, '23063010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1117');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Chocotrio barra sabor avelã Nestle 90g', '7891000422083', 'un', 12.00, 7.6800, 0.000, '18063110', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000422083');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Barra chocolate laka Lacta 80g', '7622210674319', 'un', 12.00, 8.1300, 1.000, '17049010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210674319');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Kinder Bueno 43g', '80052760', 'un', 12.00, 8.3000, 0.000, '19053200', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '80052760');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Maionese hellman''s 250g', '7894000050027', 'un', 11.50, 7.9800, 2.000, '21039011', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894000050027');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'sorvete copo jundia nata c/ chocolate', '7898036490277', 'un', 11.50, 0.0000, 0.000, '21050010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898036490277');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sorvete Jundiá Flocos 150GR', '7898036490550', 'un', 11.50, 0.0000, 0.000, '21050010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898036490550');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Nescafé Capuccino Clássico NESTLÉ 270ml', '7891000110829', 'un', 11.00, 6.5700, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000110829');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Catchup Arisco 370g', '7891150079212', 'un', 11.00, 7.3500, 9.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891150079212');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Oleo de soja Soya 1L', '7891107101621', 'un', 10.99, 7.1900, 396.000, '15079011', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891107101621');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Chocolate diamante negro 80g', '7622210674050', 'un', 10.99, 6.9900, 17.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210674050');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'H2O limoneto 1,5 litros', '7892840812874', 'un', 10.50, 7.0900, 0.000, '22021000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840812874');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Oleo de soja Vitaliv 900ml', '7898247780297', 'un', 10.00, 6.1900, 392.000, '15079011', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898247780297');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Feijão camil 1kilo', '7896006744115', 'un', 10.00, 9.2500, 0.000, '07133399', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896006744115');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Feijao carioca Kicaldo 1kg', '7896116900029', 'un', 10.00, 6.1500, 0.000, '07133399', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896116900029');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Coca cola retornavel 2 litros', '7894900014211', 'un', 10.00, 6.1000, 0.000, '22021000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900014211');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'pão sovado', '401', 'un', 10.00, 0.0000, 0.000, '19012010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '401');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Café Solúvel MELITtA 40g', '7896348300901', 'un', 10.00, 6.9900, 0.000, '21011110', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896348300901');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Refrigerante Guaraná Antarctica 2,5L', '7891991008655', 'un', 9.99, 6.9400, 0.000, '22021000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991008655');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'PAO DE FORMA PANCO PREMIUM 500G', '7891203010056', 'un', 9.90, 7.9900, 1.000, '19059010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891203010056');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Achocolatado em pó Nescau 200g', '7891000379585', 'un', 9.50, 4.7800, 24.000, '18069000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000379585');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Achocolatado TODDY 200g', '7894321711171', 'un', 9.50, 4.5900, 24.000, '18069000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894321711171');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Pão de forma seven boys 450g', '7891193010074', 'un', 8.99, 4.8900, 0.000, '19059010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891193010074');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Ketchup picante Predilecta 400g', '7896292360464', 'un', 8.75, 5.8500, 1.000, '21032010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896292360464');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'cha matte leao c/ 25 sachê original 40g', '7891098000040', 'un', 8.60, 5.4800, 28.000, '09030090', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891098000040');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Batata palha AmaVita 140gr', '7898931140543', 'un', 8.50, 5.4900, 10.000, '20052000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898931140543');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Suflair chocolate ao leite 50g', '7891000455722', 'un', 8.50, 5.6400, 0.000, '18063210', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000455722');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Farinha Láctea Nestlé 160g', '7891000369340', 'pc', 8.50, 5.7800, 0.000, '19011020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000369340');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Salgadinho Fandangos presunto 60g', '7892840823061', 'un', 8.50, 5.4900, 1.000, '19041000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840823061');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'tapioca da terrinha 500gr', '7898994081623', 'un', 8.00, 4.5900, 0.000, '19030000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898994081623');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Gatorade sabor morango e maracuja 500ml', '7892840808174', 'un', 8.00, 4.5900, 6.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840808174');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Gatorade sabor uva 500ml', '7892840808051', 'un', 8.00, 4.5900, 8.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840808051');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Gatorade sabor limao 500ml', '7892840808037', 'un', 8.00, 4.5900, 14.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840808037');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Coca cola zero 600ml', '7894900701609', 'un', 8.00, 4.4200, 22.000, '22021000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900701609');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'pastel de carne', '8080', 'un', 8.00, 0.0000, 0.000, '19022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '8080');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco marata 1 litro sabor uva', '7898378180027', 'un', 8.00, 4.4000, 15.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180027');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco marata 1 litro sabor pessego', '7898378180065', 'un', 8.00, 4.4000, 2.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180065');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco marata 1 litro sabor manga', '7898378180034', 'un', 8.00, 4.6500, 15.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180034');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco marata 1 litro sabor caju', '7898378180058', 'un', 8.00, 4.4000, 5.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180058');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco marata 1 litro sabor goiaba', '7898378180041', 'un', 8.00, 4.6600, 12.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180041');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco marata 1 litro sabor tangerina', '7898378180096', 'un', 8.00, 0.0000, 1.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180096');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco marata 1 litro sabor laranja', '7898378180010', 'un', 8.00, 4.4000, 23.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180010');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sardinha c/ oleo Robinson crusoe 75g', '7898943163011', 'un', 7.99, 5.2900, 1.000, '16041310', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898943163011');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Mostarda Quero 190g', '7896102509144', 'un', 7.99, 5.4500, 4.000, '21033021', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896102509144');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sardinha Enlatada c/ molho de tomate Robinson Crusue 75g', '7898943163028', 'un', 7.90, 5.2900, 8.000, '16041310', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898943163028');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Leite integral italac 1 litro', '7898080640611', 'un', 7.50, 4.6500, 599.000, '04012010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898080640611');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Absorvente sym noturno', '7896110003740', 'un', 7.50, 4.1900, 0.000, '96190000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896110003740');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'bis lacta original 100,8gr', '7622210575975', 'un', 7.50, 6.1900, 1.000, '19053200', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210575975');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sardinha Enlatada tradicional em óleo Gomes Costa 175g', '7891167021013', 'un', 7.50, 4.8900, 9.000, '16041310', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891167021013');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Creme dental COLGATE 90g', '7891024132128', 'un', 7.50, 4.7900, 0.000, '33061000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891024132128');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bebida fest drink spritz 269ml', '7898377662753', 'un', 7.50, 5.0100, 5.000, '22089000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898377662753');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'leite integral 1 litro piracamjuba', '7898215151708', 'un', 7.50, 0.0000, 0.000, '04012010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898215151708');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Picolé Fruthos Açaí 80g', '7896513912793', 'un', 7.50, 4.6200, 8.000, '21050010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513912793');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Dolly Guaraná 2L', '7896462300115', 'un', 7.50, 4.2500, 2.000, '22021000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896462300115');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Dolly Limão 2L', '7896462300139', 'un', 7.50, 4.2500, 9.000, '22021000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896462300139');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'picole jundia napolitano', '7898036492677', 'un', 7.00, 0.0000, 0.000, '21050010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898036492677');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Farofa pronta da terrinha 400g', '7898960982213', 'un', 7.00, 5.2900, 0.000, '19019090', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898960982213');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Biscoito rosca de coco 130g', '7898070347896', 'un', 7.00, 4.8900, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898070347896');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'MAÇA DO AMOR', '582', 'un', 7.00, 0.0000, 0.000, '08081000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '582');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'bis  branco 100,8gr', '7622210575999', 'un', 6.99, 0.0000, 0.000, '19053200', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210575999');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'CURAL', '540', 'un', 6.50, 0.0000, 0.000, '19019090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '540');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Escova de dente colgate', '7891024024386', 'un', 6.50, 4.1500, 10.000, '96032100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891024024386');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Biscoito coquinho Prodasa 400g', '7896486202884', 'un', 6.00, 3.8900, 0.000, '19053100', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896486202884');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'coca cola retornavel 1 litro', '7894900015119', 'un', 6.00, 3.1100, 0.000, '22021000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900015119');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Fanta CHUCKY Punch 350ml', '7894900095203', 'un', 6.00, 2.8700, 0.000, '22021000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900095203');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'CHOCOLATE MM', '7896423470697', 'un', 6.00, 3.3000, 0.000, '18069000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896423470697');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'picole jundia milho', '7898036490611', 'un', 6.00, 0.0000, 0.000, '21050010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898036490611');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Dolly Laranja 2L', '7896462300122', 'un', 6.00, 4.5900, 0.000, '22021000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896462300122');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Açucar refinado Caravelas 1kg', '7896894900013', 'un', 5.50, 2.7900, 87.000, '17019900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896894900013');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Biscoito ADRIA água e sal 170g', '7896085087240', 'pc', 5.50, 3.8900, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896085087240');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Del valle lata limonada sabor classic', '7894900664003', 'un', 5.50, 0.0000, 0.000, '22021000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900664003');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Macarrão espaguete Renata 500g', '7896022200282', 'un', 5.50, 3.4900, 0.000, '19021100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896022200282');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'trakinas morango 126gr', '7622210592781', 'un', 5.00, 2.5900, 10.000, '19053100', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210592781');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'trakinas chocolate 126gr', '7622210592750', 'un', 5.00, 2.5900, 10.000, '19053100', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210592750');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Filtro de cafe Brigitta 102', '7891021002103', 'un', 5.00, 3.2900, 0.000, '48232099', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891021002103');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Guaraviton sabor açai 500ml', '7896326100219', 'un', 5.00, 2.2900, 120.000, '22021000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896326100219');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Creme de leite Piracanjuba 200g', '7898215151784', 'un', 5.00, 2.7800, 22.000, '04015021', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898215151784');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Chocolate Kit kat morango', '7891000435748', 'un', 5.00, 2.5900, 0.000, '19053200', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000435748');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'MODA RE', '375', 'un', 5.00, 0.0000, 0.000, '16010000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '375');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'coca cola ks zero 290ml', '410', 'un', 5.00, 2.3500, 0.000, '22021000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '410');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'PIPOCA DE MICRO-ONDAS SABOR NATURAL 100G', '7898937864931', 'un', 5.00, 0.0000, 0.000, '20081900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898937864931');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Maionese Vigor 200g', '7891999948908', 'un', 4.99, 3.2900, 5.000, '21039011', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891999948908');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'acetona zulu rosa', '7896090700301', 'un', 4.80, 0.0000, 0.000, '33043000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896090700301');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Acetona zulu 90ml', '7896090700455', 'un', 4.80, 3.9900, 0.000, '33043000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896090700455');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Acetona Vip 90ml', '7892141955904', 'un', 4.80, 3.1500, 0.000, '33043000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892141955904');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bananinha sem açucar Nutry 23g', '7891331018535', 'un', 4.20, 2.8000, 24.000, '19042000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891331018535');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Miojo Nissin sabor carne 85g', '7891079000205', 'un', 4.20, 2.7900, 91.000, '19023000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891079000205');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'ACUCAR REFINADO GLOBO 1K', '7896534404154', 'un', 4.20, 3.5000, 0.000, '17019900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896534404154');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Nescau bebida pronta 180ml', '7891000359822', 'un', 4.00, 2.2100, 38.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000359822');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'BISCOITO SPECIAL WAFER MORANGO 140G', '7891203057068', 'un', 4.00, 0.0000, 0.000, '19053200', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891203057068');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'BISCOITO SPECIAL WAFER CHOCOLATE 140G', '7891203057075', 'un', 4.00, 0.0000, 2.000, '19053200', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891203057075');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'SONHO DE CREME', '378', 'un', 4.00, 3.0000, 0.000, '19059090', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '378');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Toddynho 200ml', '7894321722016', 'un', 3.99, 2.3900, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894321722016');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'BOL PANFI CHOC CHOC PANCO 70G', '7891203057778', 'un', 3.90, 0.0000, 0.000, '19052090', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891203057778');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bananinha cremosa c/ açucar Nutry 30g', '7891331018528', 'un', 3.80, 2.4800, 24.000, '20079990', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891331018528');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'ades laranja 200ml', '7894900087055', 'un', 3.70, 2.4500, 0.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900087055');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'ades maça 200ml', '7894900087079', 'un', 3.70, 2.4500, 0.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900087079');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'sabão em barra neutro un', '58', 'cx', 3.50, 0.0000, 0.000, '34011900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '58');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'detergente ypê 500ml coco', '7896098900239', 'un', 3.50, 1.9900, 2.000, '34025000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896098900239');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Detergente maçã Ype 500ml', '7896098900215', 'un', 3.50, 1.9900, 0.000, '34025000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896098900215');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'DETERGENTE LIQUIDO LIMPOL NEUTRO', '7891022638004', 'un', 3.50, 1.8500, 0.000, '34025000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891022638004');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Chocolate prestigio 33g', '7891000460207', 'un', 3.50, 2.1700, 22.000, '18063120', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000460207');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sal Lebre 1kg', '7896110100043', 'un', 3.50, 1.9900, 8.000, '25010020', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896110100043');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Fruittella bala dura de caramelo', '7895144025117', 'un', 3.50, 2.2100, 0.000, '17049020', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895144025117');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Fruittella bala dura morango', '7895144028019', 'un', 3.50, 2.2100, 0.000, '17049020', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895144028019');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Fruittella bala mastigavel melancia', '7895144900001', 'un', 3.50, 1.8000, 0.000, '17049020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895144900001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Fruittella mastigavel morango', '7896262301022', 'un', 3.50, 1.8000, 10.000, '17049020', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896262301022');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'MIOJO NISSIN LAMEN GALINHA', '7891079000212', 'un', 3.50, 0.0000, 48.000, '19023000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891079000212');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Fruittella mastigável suco de frutas ácida', '7895144299549', 'un', 3.50, 2.3800, 0.000, '17049020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895144299549');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Biacoito Triunfo cream cracker 164g', '7896058258738', 'pc', 3.50, 2.2000, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896058258738');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Chocolate Prestigio frutas vermelhas 33g', '7891000454589', 'un', 3.50, 2.2900, 1.000, '18063120', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000454589');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bolacha Plugados Quadrada Morango 130gr', '7896085076190', 'un', 3.00, 2.4900, 0.000, '19053100', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896085076190');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Mentos freshmint 120g', '7895144899947', 'un', 3.00, 1.6700, 1.000, '21069050', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895144899947');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'italakinho 200ml', '7898080640239', 'un', 3.00, 1.2900, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898080640239');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'APARELHOS DE BARBEAR probak', '7702018118823', 'un', 3.00, 0.0000, 0.000, '82121020', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7702018118823');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Passatempo sabor morango 130g', '7891000241295', 'un', 2.99, 1.9800, 0.000, '19053100', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000241295');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Passatempo choco mix sabor morango Nestle 130g', '7891000259351', 'un', 2.99, 1.7900, 9.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000259351');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Creme culinário Damare 200g', '7898994026914', 'un', 2.70, 1.6900, 26.000, '21069090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898994026914');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sabonete lavanda Albany 85g', '7908324403985', 'un', 2.60, 1.3500, 3.000, '34011190', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908324403985');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Tortuguita ao leite sabor brigadeiro 11,5g', '7898142865082', 'un', 2.50, 1.4100, 23.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898142865082');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'dolly cola 350ml', '7896462300245', 'un', 2.50, 1.9900, 0.000, '22021000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896462300245');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'dolly limão 350ml', '7896462300269', 'un', 2.50, 1.9900, 0.000, '22021000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896462300269');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'dolly laranja 350ml', '7896462300252', 'un', 2.50, 1.9900, 0.000, '22021000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896462300252');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco marata 200ml sabor goiaba', '7898378180164', 'un', 2.50, 1.4800, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180164');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco marata 200ml sabor maracuja', '7898378180447', 'un', 2.50, 1.4800, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180447');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco marata 200ml sabor pessego', '7898378180188', 'un', 2.50, 1.4800, 1.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898378180188');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'agua de coco coco quadrado', '751320333650', 'un', 2.50, 0.0000, 0.000, '20098921', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '751320333650');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'cremosinho açai', '81', 'cx', 2.50, 0.0000, 0.000, '21050010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '81');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'cremosinho uva', '78', 'un', 2.50, 0.0000, 0.000, '22021000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'cremosinho babaloo', '79', 'cx', 2.50, 0.0000, 0.000, '21050010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '79');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Barrinha de cereal nutry banana e mel 22g', '7891331010508', 'un', 2.50, 1.3900, 5.000, '19042000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891331010508');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Barrinha de cereal nutry morango com chocolate 22g', '7891331010522', 'un', 2.50, 1.3900, 0.000, '19042000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891331010522');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Fini tubes twister azedo 15g', '7898591457869', 'un', 2.00, 0.6300, 1.000, '17049020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898591457869');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Tang sabor tangerina', '7622210571632', 'un', 2.00, 0.8900, 19.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571632');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Tang sabor uva', '7622210571786', 'un', 2.00, 0.9700, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571786');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Tang sabor maracuja', '7622210571694', 'un', 2.00, 0.8900, 69.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571694');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Tang sabor abacaxi', '7622210571755', 'un', 2.00, 0.8900, 22.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571755');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Tang sabor laranja', '7622210571601', 'un', 2.00, 0.9700, 40.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571601');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Tang sabor morango', '7622210571724', 'un', 2.00, 0.8900, 5.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571724');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Tang sabor limão', '7622210571540', 'un', 2.00, 0.8900, 98.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571540');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Lanchinho natural P', '1120', 'un', 2.00, 0.0000, 0.000, '19059090', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1120');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Palitos de madeira Parana 100un', '7896080900001', 'un', 1.99, 0.7900, 11.000, '44219900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896080900001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Black Kretek Menthol SOLTO', '06', 'un', 1.50, 0.0000, 0.000, '24022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '06');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco  frisco sabor salada de fruta', '7896045112418', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112418');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco frisco sabor abacaxi', '7896045112098', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112098');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco frisco sabor guaraná', '7896045112449', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112449');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco frisco sabor manga', '7896045112111', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112111');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco frisco sabor limão', '7896045112128', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112128');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco frisco sabor tangerina', '7896045112432', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112432');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco frisco sabor goiabada', '7896045112456', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112456');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco frisco sabor cajá', '7896045112630', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112630');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco frisco sabor maracujá c/ iogurte', '7896045112623', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112623');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco frisco sabor caju', '7896045112463', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112463');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco  frisco sabor morango com leite', '7896045112616', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112616');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco frisco sabor laranja c/ acerola', '7896045112425', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112425');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco frisco sabor laranja', '7896045112081', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112081');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco frisco sabor morango', '7896045112142', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112142');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco frisco sabor graviola', '7896045112470', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112470');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'suco frisco sabor maracuja', '7896045112135', 'un', 1.25, 0.0000, 0.000, '21069010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045112135');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Pirulito FLOPITO morango', '7896321011299', 'un', 1.00, 0.0000, 0.000, '17049020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896321011299');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Babbaloo uva unidade', '7895800002933', 'un', 0.50, 0.2600, 25.000, '17041000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895800002933');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'PIRULITO POP', '3078', 'un', 0.50, 0.0000, 0.000, '17049020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3078');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sabão em barra Ype neutro 160g', '7896098905906', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896098905906');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sabão em barra Ype neutro 160g', '7896098905944', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896098905944');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sabão em pó tixan ype primavera 700g', '7896055510594', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896055510594');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Detergente limpol cristal 500ml', '7891022100372', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891022100372');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'oleo de soja liza 1 litro', '7896036090244', 'un', 0.00, 6.9000, 0.000, '15079011', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896036090244');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Detergente limão Limpol 500ml', '7891022637007', 'un', 0.00, 2.3500, 0.000, '34025000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891022637007');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'DETERGENTE LIQUIDO MAÇA LIMPOL', '7891022639001', 'un', 0.00, 0.0000, 0.000, '34025000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891022639001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Pipoca doce Emilia 80g', '7898667960125', 'un', 0.00, 2.5000, 0.000, '19041000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898667960125');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'mistura pra bolo itaiquara sabor coco 390g', '7896545506236', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896545506236');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bolo sabor chocolate air fryer 230g', '7891048084816', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891048084816');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bolo cremoso Dr outker sabor coco 400g', '7891048061817', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891048061817');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bolo cremoso Dr outker sabor aipim 400g', '7891048061787', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891048061787');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bolo tradicional Dr outker sabor laranja  400g', '7891048061718', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891048061718');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Tang sabor guarana 18g', '7622210571816', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210571816');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sabão em pó BRILHANTE 800g', '7891150086524', 'un', 0.00, 8.9900, 0.000, '34025000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891150086524');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Mistura para bolo brigadeiro Dr. Oetker 300g', '7891048061824', 'un', 0.00, 5.2800, 0.000, '19012090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891048061824');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Mistura para bolo Chocolate cremoso Dr. Oetker 300g', '7891048061794', 'un', 0.00, 5.2800, 0.000, '19012090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891048061794');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Detergente clear Bulnez 500ml', '7896105510802', 'un', 0.00, 0.0000, 0.000, '34025000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896105510802');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Detergente bulnez maçã 500ml', '7896105510635', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896105510635');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Ketchup Ekma 400g', '7896455001142', 'un', 0.00, 4.5900, 0.000, '21032010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896455001142');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Arroz Albaruska 1kg', '7896230400245', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896230400245');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Biscoito cream cracker 270g', '7896003741636', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896003741636');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Fermento Químico QUALIMAX 100g', '7891122123530', 'un', 0.00, 0.0000, 0.000, '21023000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891122123530');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Biscoito maizena liane 330g', '7896080862149', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896080862149');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Lenço umedecido 96un Piquitucho', '7908032300873', 'un', 0.00, 0.0000, 0.000, '34011190', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908032300873');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Fanta guarana 200ml', '78937765', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78937765');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Hysotonic sabor frutas vermelhas 500ml', '7898738660879', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898738660879');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Energy desperte sabor manga summer 473ml', '7898738661081', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898738661081');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Detergente Ype platinum', '7896098904312', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896098904312');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Salgadinho Elma Chips Fandangos Queijo', '789840822866', 'kg', 0.00, 0.0000, 0.000, '19041000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '789840822866');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Absorvente sempre livre suave', '7891010503031', 'un', 0.00, 0.0000, 0.000, '96190000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891010503031');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'CERVEJA SPATEN 269ML', '7891991303347', 'un', 0.00, 3.7900, 0.000, '22030000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991303347');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Skol lata 269ml', '7891149103102', 'un', 0.00, 2.1800, 0.000, '22030000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891149103102');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Biscoito maizena leite vitarella 350g', '7896213006426', 'un', 0.00, 6.3000, 0.000, '19053100', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896213006426');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Granulado dori 120g', '7896058599473', 'un', 0.00, 3.9900, 0.000, '18069000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896058599473');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Suco nutri sabor laranja 1L', '7898961490526', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898961490526');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Suco nutri sabor morango 1L', '7898961490434', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898961490434');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Suco nutri sabor manga 1L', '7898920195110', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898920195110');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Suco nutri nectar sabor abacaxi 1L', '7898920195813', 'un', 0.00, 0.0000, 0.000, '02012020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898920195813');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bolacha Bono mini 24g', '7891000452165', 'un', 0.00, 0.9000, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000452165');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaiana Slim 35/36 rose gold', '7891266542051', 'un', 0.00, 27.1200, 0.000, '64022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891266542051');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaiana Slim 37/38 rose gold', '7891266542068', 'un', 0.00, 27.1200, 0.000, '64022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891266542068');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaiana Slim 39/40 rose gold', '7891266542075', 'un', 0.00, 27.1200, 0.000, '64022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891266542075');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaiana Slim 35/36 Areia/dourado', '7890557502477', 'un', 0.00, 27.1200, 0.000, '64022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557502477');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaiana Slim 37/38 Areia/dourado', '7890557502484', 'un', 0.00, 27.1200, 0.000, '64022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557502484');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaiana Slim 39/40 Areia/dourado', '7890557502491', 'un', 0.00, 27.1200, 0.000, '64022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557502491');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Coco ralado DuCoco 100g', '7896016601217', 'un', 0.00, 3.9900, 0.000, '08011100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896016601217');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Tinta de cabelo 7.0 louro medio Cor&Ton', '7896000706027', 'un', 0.00, 9.9000, 0.000, '33059000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896000706027');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Adoçante doce menor 100ml', '7896261405509', 'un', 0.00, 0.0000, 0.000, '21069090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896261405509');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Picolé JunDia JundMilk chocolate 60g', '7898036490710', 'un', 0.00, 0.0000, 0.000, '21050010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898036490710');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Leite de coco Mais coco 200ml', '7896004400297', 'un', 0.00, 5.3900, 0.000, '20098990', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896004400297');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Leite em pó integral Piracanjuba 400g', '7898215152439', 'un', 0.00, 15.9000, 0.000, '04022110', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898215152439');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Leite em pó integral Italac 200g', '7898080641687', 'un', 0.00, 8.2000, 0.000, '04022110', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898080641687');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Suco sabor uva The Natural one 300ml', '7899916904716', 'un', 0.00, 4.9900, 0.000, '20099000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899916904716');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Suco sabor limonada Fazenda bela vista 300ml', '7896229800872', 'un', 0.00, 3.9900, 0.000, '20093100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896229800872');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Suco sabor laranja Natural one 180ml', '7899916917150', 'un', 0.00, 2.9900, 0.000, '20099000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899916917150');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Suco sabor uva Natural one 180ml', '7899916906031', 'un', 0.00, 2.9900, 0.000, '20099000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899916906031');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sopão Legumes com macarrão KiSabor 150g', '7898937864870', 'un', 0.00, 3.9900, 0.000, '21041011', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898937864870');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Farnha de Aveia Integral', '7892840815783', 'un', 0.00, 0.0000, 0.000, '11029000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840815783');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Aveia Flocos Finos Integral', '7892840815769', 'un', 0.00, 0.0000, 0.000, '11041200', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840815769');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Torcida sabor bacon 60g', '7892840822552', 'un', 0.00, 0.0000, 0.000, '19059090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840822552');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Kit maquiagem infantil', '7899632512158', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899632512158');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Gloss labial pitaya Max love 5ml', '7908240524665', 'un', 0.00, 0.0000, 0.000, '33041000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908240524665');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Gloss labial mágico Max love 5ml', '7908240516813', 'un', 0.00, 0.0000, 0.000, '33041000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908240516813');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Café Cabloco Tradicional 500g', '7896089010916', 'un', 0.00, 0.0000, 0.000, '09012100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896089010916');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bolinho duo fini marshmallow bauducco 30g', '7891962080031', 'un', 0.00, 0.0000, 0.000, '19059090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891962080031');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Marmita pequena', '231', 'un', 0.00, 0.0000, 0.000, '70134900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '231');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Cobertura para sorvete sabor morango 190g', '7897711700519', 'un', 0.00, 0.0000, 0.000, '21069029', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897711700519');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Cobertura para sorvete sabor caramelo 190g', '7897711700526', 'un', 0.00, 0.0000, 0.000, '21069090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897711700526');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Marlboro Red Selection', '78946781', 'un', 0.00, 0.0000, 0.000, '24022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78946781');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Baden Baden IPA Maracujá 350ml', '7898230716654', 'un', 0.00, 0.0000, 0.000, '22030000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898230716654');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Condicionador hialuronico Monange 352ml', '7896235353430', 'un', 0.00, 0.0000, 0.000, '33059000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896235353430');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Shampoo hialuronico Monange 325ml', '7896235353362', 'un', 0.00, 0.0000, 0.000, '33051000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896235353362');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Condicionador hidratação intensiva 325ml', '7896235353393', 'un', 0.00, 0.0000, 0.000, '33059000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896235353393');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Kit shampoo + condicionador vinagre de maça Monange', '7896235354925', 'un', 0.00, 0.0000, 0.000, '33059000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896235354925');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Kit shampoo + condicionador hidratação intensiva Monange', '7896235354918', 'un', 0.00, 0.0000, 0.000, '33059000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896235354918');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Espelho prata', '7082', 'un', 0.00, 0.0000, 0.000, '70099100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7082');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Espelho dourado', '7087', 'un', 0.00, 0.0000, 0.000, '70099200', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7087');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bolacha Cream Cracker 300g', '7896003740202', 'un', 0.00, 0.0000, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896003740202');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Farinha de trigo c/fermento Dona Benta', '7896005232705', 'un', 0.00, 0.0000, 0.000, '11010010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005232705');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'MINI MOTO SOROCABA', '7898002432799', 'un', 0.00, 5.3000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898002432799');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'RAQUETE SAMARA', '7898393800696', 'un', 0.00, 4.3000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898393800696');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'DOMINO DE PLASTICO COLORIDO', '7898365250054', 'un', 0.00, 3.2000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898365250054');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'LAPIS DE COR APAGAVEL LEOLEO', '7897256275008', 'un', 0.00, 4.9000, 0.000, '96091000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897256275008');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'LAPIS DE COR C/24 UN', '7897256244875', 'un', 0.00, 6.9800, 0.000, '96091000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897256244875');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'LAPIS PRETO', '2000', 'un', 0.00, 0.1700, 0.000, '96091000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '2000');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'bolo de baunilha', '394', 'kg', 0.00, 0.0000, 0.000, '19059090', 'st', '394', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '394');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'SACO DE FARINHA', '3039', 'un', 0.00, 0.0000, 0.000, '11010010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3039');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'CHOCOLATTO 3 CORACOES 560G', '7896045104147', 'un', 0.00, 9.4000, 0.000, '18069000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896045104147');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'baguete folhada', '396', 'un', 0.00, 0.0000, 0.000, '19059090', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '396');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'promoção', '397', 'un', 0.00, 0.0000, 0.000, '19059090', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '397');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'ROCAMBOLE DE GOIABADA', '400', 'kg', 0.00, 0.0000, 0.000, '19059090', 'st', '400', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '400');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'mini coco', '406', 'un', 0.00, 0.0000, 0.000, '19059090', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '406');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'pão mandioquinha Grande', '407', 'un', 0.00, 0.0000, 0.000, '19059090', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '407');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'wafer morango bono 110gr', '7891000373262', 'un', 0.00, 0.0000, 0.000, '19053200', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000373262');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'ROCAMBOLE DE DOCE DE LEITE', '999', 'kg', 0.00, 0.0000, 0.000, '19059090', 'st', '999', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '999');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'tiss tubaina 2 litros', '7896263503234', 'un', 0.00, 0.0000, 0.000, '22021000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896263503234');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Chocobiscuit cocolate nestle 78g', '7891000402979', 'un', 0.00, 4.4200, 0.000, '19053100', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000402979');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'NESQUIK 180ML  promoção', '7891000366141', 'un', 0.00, 2.4800, 0.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000366141');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'COOKIES NESTLE SABORES 60G', '7891000339596', 'un', 0.00, 0.0000, 0.000, '19053100', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000339596');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'SALG ELMA CHIPS CHEETOS QJO SUICO 125G', '7892840823245', 'un', 0.00, 10.9800, 0.000, '19041000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840823245');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'CEBOLITOS 91GX14', '7892840822804', 'un', 0.00, 9.9800, 0.000, '19041000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840822804');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'ERVILHA 170GR ETTI LATA', '7898930142128', 'un', 0.00, 2.8900, 0.000, '20054000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898930142128');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'SOPA SABOR CARNE KITANO SACHE 196G', '7891095003945', 'un', 0.00, 7.9900, 0.000, '21041011', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891095003945');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaiana Azul naval  39/40', '7890557722240', 'un', 0.00, 21.7600, 0.000, '64022000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557722240');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Del valle sabor laranja 200ml', '7894900660418', 'un', 0.00, 0.0000, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900660418');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Pipoca Colorida Emilia 30g', '7898667960026', 'pc', 0.00, 0.0000, 0.000, '19041000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898667960026');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Mini biscoito amanteigado Peppa pig 100g', '7896064205207', 'un', 0.00, 0.0000, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896064205207');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Lampada 15W Kian', '7899710006579', 'un', 0.00, 0.0000, 0.000, '85395200', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899710006579');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Mini biscoito amanteigado Galinha pintadinha 100g', '7896064204576', 'un', 0.00, 0.0000, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896064204576');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sequilhos sabor coco Santa Edwiges 100g', '7896064205511', 'un', 0.00, 0.0000, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896064205511');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sequilhos sabor tradicional Santa Edwiges 100g', '7896064205504', 'un', 0.00, 0.0000, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896064205504');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Diploko sabor limão siciliano 11g', '7898970162018', 'un', 0.00, 0.0000, 0.000, '17049020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898970162018');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Café Soluvel Nescafé 40g', '7891000416228', 'un', 0.00, 0.0000, 0.000, '21011110', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000416228');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Café Solúvel Brasileiro', '7891018427766', 'un', 0.00, 0.0000, 0.000, '21011110', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891018427766');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Café Caboclo Extra forte 500g', '7896089016215', 'un', 0.00, 0.0000, 0.000, '09012100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896089016215');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Café Pele extra forte 500g', '7892222310509', 'un', 0.00, 0.0000, 0.000, '09012100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892222310509');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Chocolate Alpino ao Leite 80g', '7891000410707', 'un', 0.00, 0.0000, 0.000, '18063210', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000410707');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Pá plastica grande', '7897788813129', 'un', 0.00, 0.0000, 0.000, '39249000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897788813129');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Brinquedo Super ball gun', '7896771660405', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896771660405');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Evita mofo aroma floral 100g', '7898543383710', 'un', 0.00, 0.0000, 0.000, '28272090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898543383710');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Evita mofo aroma lavanda 100g', '7898543383772', 'un', 0.00, 0.0000, 0.000, '38249979', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898543383772');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Kit doutor braskit', '7896771660344', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896771660344');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Cola bastão 10g leo leo', '7897256220114', 'un', 0.00, 0.0000, 0.000, '35061090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897256220114');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Chupeta Pepeta bico silicone', '7896982901229', 'un', 0.00, 0.0000, 0.000, '39269040', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896982901229');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Chupeta pepeta bico silicone', '7896982901236', 'un', 0.00, 0.0000, 0.000, '39269040', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896982901236');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Kit super chef frigideira', '7896771660306', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896771660306');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Kit alicate sande mundial', '7891060773071', 'un', 0.00, 0.0000, 0.000, '82142000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891060773071');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Kit alicate mundial borboleta', '7891060025439', 'un', 0.00, 0.0000, 0.000, '82142000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891060025439');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Vela sandero branca c/8 un', '7896366408054', 'un', 0.00, 0.0000, 0.000, '34060000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896366408054');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Extensão bibolar', '7897356525249', 'un', 0.00, 0.0000, 0.000, '85444200', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897356525249');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Kit Dino encartelado', '7898676720659', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898676720659');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Kombi orange', '7898002431396', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898002431396');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Kit Carros e motos sorocaba', '7898002435172', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898002435172');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Carro mek aventura sorocaba', '7898002431426', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898002431426');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Moto sorocaba', '7898002431891', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898002431891');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Carro sorocaba conversível', '7898002431419', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898002431419');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Carro sorocaba', '7898002431372', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898002431372');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Lixa pedicure sheila', '7896818241659', 'un', 0.00, 0.0000, 0.000, '68053090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896818241659');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bolhas de sabão 50ml', '7908470002483', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908470002483');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Cubo mágico', '7908346286863', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908346286863');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Escova Beaty almofada', '7908422600897', 'un', 0.00, 0.0000, 0.000, '96032900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908422600897');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Escova beauty rosa', '7908422601344', 'un', 0.00, 0.0000, 0.000, '96032900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908422601344');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Kit pescaria pica pau', '7896464733157', 'un', 0.00, 0.0000, 0.000, '33072010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896464733157');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Mini kit beaut', '7898676720703', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898676720703');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Brinquedo vida animal dino 13 peças', '7896464734390', 'un', 0.00, 0.0000, 0.000, '95030039', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896464734390');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Arco e flexa', '7896464730057', 'un', 0.00, 0.0000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896464730057');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'MASSINHA DE MODELAR MAGIX', '0040232714924', 'un', 0.00, 2.9000, 0.000, '34070010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '0040232714924');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'COLA BRANCA ACRILEX 100G', '7891153031262', 'un', 0.00, 3.9900, 0.000, '35069190', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891153031262');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'COLA BRANCA ACRILEX 37G', '7891153028408', 'un', 0.00, 1.6000, 0.000, '35069190', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891153028408');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Maionese Mariana 3kg', '7896036092927', 'un', 0.00, 29.9000, 0.000, '21039019', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896036092927');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Fuba kisabor 4kg', '7898416520785', 'pc', 0.00, 19.9000, 3.000, '09041100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898416520785');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Rocambole 5kg', '7898264515834', 'pc', 0.00, 0.0000, 1.000, '19012090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898264515834');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Brownie 5kg', '7898264511881', 'pc', 0.00, 0.0000, 1.000, '19012090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898264511881');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Gelatina sem sabor Qualimax 510g', '7891122123318', 'pc', 0.00, 79.6300, 2.000, '21069029', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891122123318');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Leite em po integral piracajuba 1kg', '7898215152354', 'pc', 0.00, 35.8900, 2.000, '04022110', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898215152354');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'PISTOLA BOLHA DE SABAO', '7896462006284', 'un', 0.00, 9.9000, 0.000, '95030099', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896462006284');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'KIT MEDICO DOUCTOR JUNIOR', '7896464706397', 'un', 0.00, 5.9900, 0.000, '95030080', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896464706397');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'KIT MASSINHA PARA MODELAR', '7896464707578', 'un', 0.00, 10.5000, 0.000, '34070010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896464707578');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Tapioca Lopes 500g', '7898113940305', 'un', 0.00, 3.2000, 0.000, '11081400', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898113940305');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'KIT MASSINHA PARA MODELAR PICA PAU', '7896464707097', 'un', 0.00, 9.9900, 0.000, '34070010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896464707097');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Tapioca Lopes 1kg', '7898113940299', 'un', 0.00, 6.4000, 0.000, '19030000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898113940299');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Crepioca |Lopes 500g', '7898113941425', 'un', 0.00, 10.0000, 0.000, '19030000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898113941425');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'KIT GUERREIRO NINJA', '7896464703877', 'un', 0.00, 6.7000, 0.000, '95030022', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896464703877');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'KIT COMBATE E FORÇA', '7896464704362', 'un', 0.00, 13.9900, 0.000, '95030080', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896464704362');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'KIT DINOSSAUROS', '7908470018651', 'un', 0.00, 3.9900, 0.000, '33072010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908470018651');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bolacha Cream cracker Marilan 140g', '7896003740318', 'un', 0.00, 1.9900, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896003740318');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bolacha de Água e sal Mabel 300g', '7896071030069', 'un', 0.00, 4.3900, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896071030069');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Molho inglês Campo Belo 150ml', '7898075643948', 'un', 0.00, 2.3900, 0.000, '21039091', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898075643948');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Miojo Cup noodles Bolonhesa nissin 72g', '7891079013120', 'un', 0.00, 5.2900, 0.000, '19023000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891079013120');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Miojo Cup noodles Galinha picante Nissin 68g', '7891079013069', 'un', 0.00, 5.2900, 0.000, '19023000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891079013069');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sabao em Po Ace 800 g', '7898132847821', 'cx', 0.00, 5.9900, 0.000, '34025000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898132847821');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Amaciante Confort Puro Cuidado 500ml', '7891150039001', 'cx', 0.00, 8.4900, 0.000, '38099190', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891150039001');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Amaciante CONFORT Frescor Intenso 500ml', '7891150000971', 'cx', 0.00, 8.4900, 0.000, '38099190', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891150000971');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sabão em pó Tixan Ype Primavera 1,6KG', '7896098909768', 'un', 0.00, 15.8900, 0.000, '34025000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896098909768');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Escovas dentais ORAL-B 2 un', '7506339358247', 'un', 0.00, 13.5000, 0.000, '96032100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7506339358247');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Monster Absolutely Zero 473ml', '070847022305', 'un', 0.00, 0.0000, 0.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '070847022305');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Cookies Nescau duo 60g', '7891000339558', 'un', 0.00, 0.0000, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000339558');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Detergente liquido coco Bulnez 500g', '7896105510796', 'un', 0.00, 1.8500, 0.000, '34025000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896105510796');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Mistura para bolo chocolate c/ avelã Fleischmann 390g', '7898331013331', 'un', 0.00, 6.9800, 0.000, '19012090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898331013331');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bala 0,50', '1115', 'un', 0.00, 0.0000, 0.000, '17049020', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1115');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Cepera katchup sache', '7896025805170', 'cx', 0.00, 15.8000, 5.000, '21032010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896025805170');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Batata palha karis 800gm', '7898936296030', 'pc', 0.00, 18.9000, 0.000, '20052000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898936296030');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Energy monster  THE DOCTOR 473ML', '7898770420042', 'kg', 0.00, 0.0000, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898770420042');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Del valle lata limonada tropical 290ml', '7894900664027', 'un', 0.00, 3.5000, 0.000, '22021000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900664027');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Pururuca sabor bacon 60g', '7898021631319', 'un', 0.00, 0.0000, 0.000, '19059090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898021631319');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Macarrão espaguete Adria 500gr', '7896205788033', 'un', 0.00, 0.0000, 0.000, '19021100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896205788033');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'FINI sabor tutti-frutti 27g', '7908228804826', 'un', 0.00, 2.0800, 0.000, '17049020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908228804826');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Fini morango e nata 27g', '7908228801634', 'un', 0.00, 1.5900, 0.000, '17049020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7908228801634');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Paçoca AGTAL 20g', '7896261401846', 'un', 0.00, 0.5900, 0.000, '17049090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896261401846');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Rosquinha de coco RANCHEIRO 300g', '7896253401465', 'un', 0.00, 3.5900, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896253401465');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sabão em pó SURF 1,6kilo', '7891150086814', 'un', 0.00, 11.9900, 0.000, '34025000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891150086814');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Vela PRATA c/ 8un número 2', '7896017470201', 'un', 0.00, 2.9900, 0.000, '34060000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896017470201');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bananinha Fazendinha sem açúcar 23g', '7897011000258', 'un', 0.00, 1.8400, 0.000, '20079990', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897011000258');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sorvete Chocotella kascão 715g', '7896513915336', 'un', 0.00, 0.0000, 0.000, '21050010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896513915336');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Desodorante Aerosol Giovanna baby 150ml', '7896044936923', 'un', 0.00, 10.9000, 0.000, '33072010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896044936923');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Desodorante masculino one 150ml', '7899674034267', 'un', 0.00, 6.9900, 0.000, '33072010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899674034267');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Oreo sabor chocolate 90g', '7622300873554', 'un', 0.00, 3.3300, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622300873554');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sorvete Azuloko Jundiá 60g', '7898036494091', 'un', 0.00, 0.0000, 0.000, '21050010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898036494091');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Chesterfield remix wild roxo', '78938380', 'un', 0.00, 0.0000, 0.000, '24022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78938380');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Iogurte sabor frutas vermelhas Frutilac 130g', '7896862003128', 'un', 0.00, 0.0000, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896862003128');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Iogurte sabor morango Frutilac 130g', '7896862001780', 'un', 0.00, 0.0000, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896862001780');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Trakinas sabor meio a meio 120g', '7622210592637', 'un', 0.00, 0.0000, 0.000, '19053100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7622210592637');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Molho shoyu Sakura 150ml', '7896007811007', 'un', 0.00, 3.7000, 0.000, '21031010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896007811007');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Milho de pipoca Sinha 400g', '7892300030107', 'un', 0.00, 3.7900, 0.000, '10059010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892300030107');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Amaciante brisa de verão Downy 350ml', '7500435252942', 'un', 0.00, 7.5900, 0.000, '38099190', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7500435252942');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Suco del valle pêssego 200ml', '7894900660425', 'un', 0.00, 0.0000, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900660425');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Pão de batata', '3099', 'un', 0.00, 0.0000, 0.000, '19059090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3099');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'ChocoStick avelã Nestlé 26g', '7891000477410', 'un', 0.00, 2.3000, 0.000, '18063120', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891000477410');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Goiabada Xavante 200g', '7896235800279', 'un', 0.00, 2.4900, 0.000, '20079990', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896235800279');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Papel higienico fofinho 12 rolos', '7896053411220', 'un', 0.00, 9.3400, 0.000, '48181000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896053411220');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Papel higienico BestLite folha dupla 4 rolos', '7896053470166', 'un', 0.00, 3.5900, 0.000, '48181000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896053470166');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Papel higienico Primavera 4 rolos', '7896075301103', 'un', 0.00, 2.8900, 0.000, '48181000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896075301103');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sabonete em barra rosas Francis intenso 85g', '7891176117462', 'un', 0.00, 1.4800, 0.000, '34011190', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891176117462');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sabonete em barra jasmim Francis intenso 85g', '7891176117349', 'un', 0.00, 1.4800, 0.000, '34011190', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891176117349');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sabonete em barra lavanda Francis intenso 85g', '7891176117516', 'un', 0.00, 1.4800, 0.000, '34011190', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891176117516');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Farinha de trigo Dona Laura 1kg', '7897932900040', 'un', 0.00, 2.7900, 0.000, '11010010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897932900040');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Velas c/6 n*9 Paraná', '7896080901145', 'un', 0.00, 0.0000, 0.000, '34060000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896080901145');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Vela c/8 n*6 Luz do senhor', '7897935400509', 'un', 0.00, 0.0000, 0.000, '34060000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897935400509');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Vela c/8 n*8 Paraná', '7896080901114', 'un', 0.00, 0.0000, 0.000, '34060000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896080901114');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Rothmans silver global', '78947634', 'un', 0.00, 0.0000, 0.000, '24022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78947634');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Fermento Biologico  Seca 10g', '7896005271964', 'cx', 0.00, 1.0900, 264.000, '21023000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896005271964');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'CUP NOODLES PARMEGIANA 68G', '7891079014233', 'un', 0.00, 5.4900, 0.000, '19023000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891079014233');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Chiclete Bubbaloo Tutti Fruti', '7895800002957', 'un', 0.00, 0.0000, 0.000, '17041000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895800002957');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Chiclete Bubballo Morango', '7895800002940', 'un', 0.00, 0.0000, 0.000, '17041000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7895800002940');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Gatorade Sabor Frutas Citricas', '7892840808013', 'un', 0.00, 0.0000, 0.000, '22029900', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840808013');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Fermento Biologico Pão e Pizza 125 g', '7898409952128', 'un', 0.00, 9.9900, 0.000, '21021090', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898409952128');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Guaraná Antartica Zero 2L', '7891991001373', 'un', 0.00, 0.0000, 0.000, '22021000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891991001373');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'OVO SURPRESA PET MONSTER', '7898967923837', 'un', 0.00, 3.5000, 0.000, '17049020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898967923837');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'PIRULITO DE UNICORNIO', '7898964630004', 'un', 0.00, 0.0000, 0.000, '17049020', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898964630004');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'PICOLE PATRULHA CANINA SABOR FLOCOS, UVA, E CHOCOLATE', '7898036493896', 'cx', 0.00, 0.0000, 0.000, '21050010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898036493896');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'SORVETE POTE SABOR CHOCOLATE E MORANGO', '7898036493865', 'un', 0.00, 0.0000, 0.000, '21050010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898036493865');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'PICOLE SABOR LEITE TRUFADO 110g', '7898036492110', 'un', 0.00, 0.0000, 0.000, '21050010', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898036492110');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sprite Retornavel  290 ml', '7894900065206', 'un', 0.00, 0.0000, 0.000, '22021000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7894900065206');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Chá Verde Leão 450 ml', '7891098041913', 'un', 0.00, 3.2900, 0.000, '22021000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891098041913');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Refrigerante Peps 350 ml', '7892840800079', 'un', 0.00, 2.3200, 0.000, '22021000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7892840800079');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'CORDA P/ VARAL N 10', '7897323800560', 'un', 0.00, 0.0000, 0.000, '56074900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897323800560');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Bolinho gotas de chocolate Bauducco 40g', '7891962074665', 'cx', 0.00, 2.2000, 0.000, '19059090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891962074665');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'MARIA MOLE APTI SABOR MORANGO 50G', '7896327501169', 'un', 0.00, 2.4900, 0.000, '21069029', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896327501169');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'MARIA MOLE SABOR COCO 50G', '7896327501152', 'un', 0.00, 2.4900, 0.000, '21069029', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896327501152');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'PUDIM APTI SABOR CHOCOLATE 50G', '7896327514909', 'un', 0.00, 1.4900, 0.000, '21069021', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896327514909');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Sabonete framboesa e amora Palmolive 85g', '7891024034828', 'un', 0.00, 2.1900, 0.000, '34011190', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891024034828');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'PILHA  AA UN', '1035', 'un', 0.00, 0.0000, 0.000, '85061019', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '1035');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'SALSICHA PERDIGAO', '3037', 'kg', 0.00, 0.0000, 0.000, '16010000', 'normal', '3037', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '3037');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Isqueiro Bic Grande Decorado', '070330662582', 'un', 0.00, 0.0000, 0.000, '96131000', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '070330662582');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Óleo Composto Saude 500ml', '7896248101103', 'un', 0.00, 0.0000, 0.000, '15179010', 'st', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896248101103');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Corda para varal 10m', '7897323800119', 'un', 0.00, 0.0000, 0.000, '56074900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7897323800119');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Vela queluz n5', '7896100901544', 'un', 0.00, 0.0000, 0.000, '34060000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896100901544');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Oregano', '10', 'un', 0.00, 0.0000, 0.000, '21039029', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '10');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'edu guedes tempero', '002', 'un', 0.00, 0.0000, 0.000, '21039021', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '002');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Energetico dopamina coco e açai 473ml', '7898738660121', 'un', 0.00, 0.0000, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898738660121');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Vassoura carmela', '7898311540062', 'un', 0.00, 0.0000, 0.000, '96039000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898311540062');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'pente de mao', '051', 'un', 0.00, 0.0000, 0.000, '96151100', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '051');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaiana Azul naval 43/44', '7890557722264', 'un', 0.00, 21.7600, 0.000, '64022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557722264');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaiana Azul naval 37/38', '7890557722233', 'un', 0.00, 21.7600, 0.000, '64022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557722233');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Havaiana Azul naval 41/42', '7890557722257', 'un', 0.00, 21.7600, 0.000, '64022000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7890557722257');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Palito unha', '022', 'un', 0.00, 0.0000, 0.000, '44219900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '022');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Fanta uva 200ml', '78938571', 'un', 0.00, 1.3100, 0.000, '22021000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '78938571');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Hysotonic sabor laranja 500ml', '7898738660466', 'un', 0.00, 4.2300, 0.000, '20091200', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898738660466');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Hysotonic sabor tangerina 500ml', '7898738660473', 'un', 0.00, 0.0000, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898738660473');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Hysotonic sabor limao 500ml', '7898738660459', 'un', 0.00, 0.0000, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898738660459');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Hysotonic sabor mix de frutas 500ml', '7898738660480', 'un', 0.00, 0.0000, 0.000, '22029900', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898738660480');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Agua tonica cidade imperial 350ml', '7898915949988', 'un', 0.00, 3.1900, 0.000, '22021000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7898915949988');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'MORTEIN MATA BARATAS', '7891035002427', 'un', 0.00, 0.0000, 0.000, '38085910', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7891035002427');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'GEL FIXADOR ABOVE 300G', '7899674037480', 'un', 0.00, 0.0000, 0.000, '33059000', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7899674037480');
INSERT INTO produtos (padaria_id, nome, codigo_barras, unidade, preco_venda, custo_unitario, estoque_atual, ncm, situacao_icms, codigo_balanca, ativo)
SELECT 2, 'Desodorante herbissimo neutro 55g', '7896049528505', 'un', 0.00, 6.9900, 0.000, '33072090', 'normal', NULL, 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE padaria_id = 2 AND codigo_barras = '7896049528505');
SELECT COUNT(*) AS produtos_jota2 FROM produtos WHERE padaria_id = 2;
