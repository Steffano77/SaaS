-- Passo 1: Adicionar coluna NCM
ALTER TABLE produtos ADD COLUMN ncm VARCHAR(20) NULL;

-- Passo 2: Inserir produtos (sem duplicar por codigo_barras)

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Waffer bono chocolate 110g', '7891000372586', 4.5, 0, '19053200', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000372586' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'MISTURA CONTRA FILE', '3091', 15, 0, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'MISTURA CONTRA FILE' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cookies alpino nestlé 60g', '7891000350119', 3.6, 1.98, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000350119' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chocolate Lollo 28g', '7891000092606', 3.99, 2.2, '18069000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000092606' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chocolate prestigio 33g', '7891000460207', 3.5, 2.21, '18069000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000460207' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'adicional', '7070', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'adicional' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'trident tutti fruit', '7895800430002', 3, 1.9, '21069050', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7895800430002' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'trident morango', '7895800201503', 3, 1.9, '21069050', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7895800201503' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'trident canela', '7895800304235', 3, 1.9, '21069050', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7895800304235' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'trident menta', '7895800304228', 3, 1.71, '21069050', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7895800304228' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'rosquinha de chocolate', '784', 5, 0, '19021900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'rosquinha de chocolate' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'cha matte leao c/ 25 sachê original 40g', '7891098000040', 8.6, 4.89, '09030090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891098000040' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Creme dental colgate calci-protect 90g', '7891024134702', 6.5, 4.79, '33061000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891024134702' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'SKOL 350ml', '7891149200504', 6, 3.09, '22030000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891149200504' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'trident x senses cereja ice', '7622210564337', 3, 1.71, '21069050', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210564337' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'trident hortela sem açucar', '7895800304211', 3, 1.71, '21069050', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7895800304211' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'trident x senses intense', '7622210564290', 3, 1.71, '21069050', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210564290' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'trident melancia', '7895800309780', 3, 1.71, '21069050', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7895800309780' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Mini Nutella 140g', '7898024395232', 15.99, 9.99, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898024395232' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Mostarda Quero 190g', '7896102509144', 7.99, 5.45, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896102509144' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Katchup tradicional 200g', '7896102502763', 6.3, 4.19, '21032010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896102502763' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Guardanapo minifior c/50un', '7897532800030', 1.99, 1.15, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897532800030' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Escova de dente colgate', '7891024024386', 6.5, 4.15, '96032100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891024024386' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'del valle laranja pet 1L', '7894900556032', 7, 3.91, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900556032' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Del valle laranja 1 litro', '7898341430111', 11.5, 7.92, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898341430111' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'sprite 350ml lata', '7894900681017', 6, 2.48, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900681017' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Fanta Laranja 200ml', '78936478', 3, 1.32, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '78936478' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Fanta uva pet 2L', '7894900051513', 14, 8.28, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900051513' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cerveja Heineken 600ml', '78905498', 17.5, 11, '22030000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '78905498' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cerveja Amstel 600ml', '7896045504541', 12, 7.61, '22030000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896045504541' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cerveja Amstel lata 350ml', '7896045506934', 6.65, 4.66, '22030000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896045506934' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolinho duo bauducco 27g', '7891962051383', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891962051383' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'bolinho bauducco duplo chocolate 40g', '7891962031170', 3, 2.19, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891962031170' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite integral Tirol 1L', '7896256601848', 7.5, 5.29, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896256601848' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Papel  Toalha Yuri 2 rolo', '7896075301080', 0, 0, '48182000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896075301080' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolinho bauducco laranja 40g', '7891962067889', 0, 2.1, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891962067889' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolinho chocolate com baulilha Bauducco 40g', '7891962067346', 2.8, 2.19, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891962067346' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabão em pó TIXAN 400g', '7896098909737', 7.5, 5.48, '34025000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896098909737' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Lata de Milho Salsaretti  170g', '7898930142784', 0, 2.59, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898930142784' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Achocolatado liquido Italac 1L', '7898080640925', 0, 7.5, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898080640925' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Adicional de café', '777', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Adicional de café' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite Condensado Semidesnatado Italcc 395 g', '7898080640413', 0, 0, '02071412', 'cx', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898080640413' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Farofa tradicional Yoki 400g', '7891095911486', 4, 3.79, '19019090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891095911486' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coca Cola 600ml', '7894900011609', 8, 4.42, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900011609' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'coca cola 200ml zero açucar', '78933873', 3, 1.34, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '78933873' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coca Cola lata zero 350ml', '7894900700015', 6, 2.87, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900700015' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Requeijão Tirolez 400g', '7896030521690', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896030521690' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coca Cola lata 350ml', '7894900010015', 6, 2.88, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900010015' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sprite Zero 600ml', '7894900061604', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900061604' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Del valle pessego 1 litro', '7898341430036', 11.5, 7.62, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898341430036' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'ades maça 200ml', '7894900087079', 3.75, 0, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900087079' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Del valle maracuja 1 litro', '7898341430074', 11.5, 7.92, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898341430074' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'del valle 1 litro abacaxi', '7894900660364', 11.5, 7.92, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900660364' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Del valle uva pet 1L', '7894900550030', 7, 3.91, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900550030' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Fanta laranja 600ml', '7894900031607', 8, 4.1, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900031607' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Água crystal 500ml', '7894900530001', 4, 1.89, '22011000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900530001' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coca cola Café 220ml', '7894900025019', 0, 0, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900025019' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sprite 2 Litros', '7894900681000', 13.5, 8.38, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900681000' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coca cola zero 600ml', '7894900701609', 8, 4.31, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900701609' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Água crystal c/gás 1,5L', '7894900531015', 6, 2.97, '22011000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900531015' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Monster Absolutely Zero 473ml', '070847022305', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '070847022305' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Fanta uva lata 350ml', '7894900050011', 6, 2.48, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900050011' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sprite zero 200ml', '78938601', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '78938601' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sprite 600ml', '7894900681246', 8, 4.1, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900681246' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Del valle uva 450ml', '7894900550054', 5.5, 2.81, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900550054' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Suco Ades maça 1L', '7894900087062', 10, 0, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900087062' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Marlboro azul selection', '78947986', 0, 8.81, '24022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '78947986' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coca cola Zero 2L', '7894900701517', 15, 9.95, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900701517' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Água Crystal com gas 500ml', '7894900531008', 5, 1.7, '22011000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900531008' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sprite Lemon fresh 510ml', '7894900680508', 6.5, 2.52, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900680508' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coca cola pet 200ml', '78908901', 3, 1.34, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '78908901' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Fanta Laranja pet 2L', '7894900031515', 12, 8.49, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900031515' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Monster mango loko 473ml', '070847033301', 12, 0, '22029900', 'cx', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '070847033301' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coca Cola 2 litros', '7894900027013', 15, 9.13, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900027013' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coca Cola zero retornável 2L', '7894900704211', 10, 6.15, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900704211' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coca cola retornavel 2 litros', '7894900014211', 10, 6.1, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900014211' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Fruittela mastigavel morango', '7896262301022', 3.5, 2.11, '17049020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896262301022' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Schweppes citrus 350ml', '7894900180503', 6, 2.96, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900180503' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Fanta Laranja 350ml', '7894900030013', 6, 2.48, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900030013' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Monster Energy Ultra 473ml', '070847022015', 12, 8.08, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '070847022015' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'del valle uva 1 litro', '7898341430098', 11.5, 7.92, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898341430098' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chocolate M&Ms 40g', '7896423438727', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896423438727' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Yakult', '78911000', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '78911000' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolacha bono morango 90gr', '7891000376959', 3.3, 2.46, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000376959' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'bolo pedaço cenoura c/chocolate', '1002', 0, 0, '02071419', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'bolo pedaço cenoura c/chocolate' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'bolachão doce', '431', 25, 0, '19059090', 'kg', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'bolachão doce' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'fatia bolo de cenoura', '331', 0, 0, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'fatia bolo de cenoura' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolachao salgado', '42', 32, 0, '19021900', 'kg', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Bolachao salgado' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Toddynho 200ml', '7894321722016', 3.99, 2.39, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894321722016' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Gel fixador Nylooks F1 240g', '7891350034929', 0, 9.6, '33059000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891350034929' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Corda para varal n*3 plasoor', '7897323800096', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897323800096' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cerveja Heineken 330ml long neck', '78936683', 10, 4.84, '22030000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '78936683' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chá Matte Leão caixa 250g', '7891098038456', 13.99, 9.48, '09030090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891098038456' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'HEINEKEN  350ML', '7896045506873', 7, 0, '22030000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896045506873' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cerveja heineken 269ml', '7896045506590', 5, 0, '22030000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896045506590' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Itubaina garrafa de vidro 355ml', '7896052603497', 5, 0, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896052603497' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'itubaina lata 350ml', '7896052604975', 5, 3.04, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896052604975' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'TNT Original 269ml', '7897395031602', 8.5, 5.43, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897395031602' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cerveja itaipava 350ML', '7897395020101', 5, 2.71, '22030000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897395020101' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cerveja itaipava 600ml', '78906709', 10, 3.76, '22030000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '78906709' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite Fermentado Frutap 170ml', '7896862002107', 3.75, 2.55, '04039000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896862002107' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Iogurte frutap morango 160g', '7896862000806', 3.75, 2.7, '04032000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896862000806' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'IOGURTE frutap 850ml', '7896862000875', 12, 9.25, '04032000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896862000875' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Iogurte frutap 450gr', '7896862000011', 8, 5.8, '04032000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896862000011' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'FANTA UVA 220ML LATA', '7894900050394', 3.5, 1.67, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900050394' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sprite limão 200ml', '78939745', 3, 1.32, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '78939745' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'SPRITE 220ML LATA', '7894900681178', 3.5, 1.67, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900681178' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Fuba mimoso Rio 500g', '7897033500293', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897033500293' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Farofa pronta da terrinha 400g', '7898960982213', 7, 5.29, '19019090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898960982213' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Miojo Nissin sabor carne 85g', '7891079000205', 4.2, 2.79, '19023000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891079000205' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'italakinho 200ml', '7898080640239', 3, 1.29, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898080640239' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabão em pó OMO 800g', '7891150064317', 19.5, 10.9, '34025000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891150064317' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Creme dental Sorriso tripla ação 70g', '7891528029498', 5.1, 2.89, '33061000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891528029498' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Desodorante roll-on Love intense Skala 60ml', '7897042010455', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897042010455' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Fralda Tigrinhos tam XG', '7898773230600', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898773230600' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Fralda Tigrinhos tam G', '7898773230594', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898773230594' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Fralda Tigrinhos tam M', '7898773230587', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898773230587' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Amaciante Roupa e Carinho ternura 2L', '7896328500222', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896328500222' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Amaciante Roupa e Carinho conforto 2L', '7896328500185', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896328500185' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Doce de doce de leite Saborde 200g', '7896523182759', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896523182759' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Seleta de legumes Salsaretti 170g', '7898930142999', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898930142999' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Escova de dente Hillo', '7896444213143', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896444213143' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Detergente Minuano neutro 500ml', '7897664130036', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897664130036' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Granulado Camp 130g', '7898027657931', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898027657931' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Lâmpada SuperLed Durol 15w', '7898324004858', 0, 3.99, '85395200', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898324004858' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Lampada SuperLed Durol 12w', '7898324006166', 8.5, 5.39, '85395200', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898324006166' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Detergente neutro ype 500ml', '7896098900208', 3.5, 2.09, '34025000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896098900208' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Detergente Minuano clean 500ml', '7897664130043', 3, 0, '34025000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897664130043' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chá camomila leão 10g', '7891098000163', 6, 2.99, '12119090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891098000163' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chá leão capim cidreira 10g', '7891098000156', 5.8, 0, '21012010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891098000156' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Gel fixador Nylooks F4 240g', '7891350034950', 0, 10.99, '33059000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891350034950' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Algodão bolas piquitucho 50g', '7891800808117', 7.5, 0, '30059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891800808117' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cerveja Amstel lata 269ML', '7896045505319', 5, 2.95, '22030000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896045505319' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'COCA COLA LATA 220ML', '7894900010398', 3.5, 1.75, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900010398' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Del valle lata goiaba 290ml', '7894900660265', 5.5, 3.56, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900660265' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sorvete bombom de pistache Antonelli 105g', '7896513910058', 19.9, 13.25, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896513910058' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sorvete bombom de doce de leite Antonelli  105g', '7896513910065', 19.9, 13.25, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896513910065' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sorvete copão alegria napolitano 150gr', '7896513940093', 10.5, 7.35, '21050010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896513940093' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Pastel de palmito c/ queijo', '8082', 8, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Pastel de palmito c/ queijo' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Água serra negra 1,5L', '7898368290132', 6, 1.8, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898368290132' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sprite Zero açucar 350ml', '7894900060010', 6, 2.48, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900060010' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coca cola KS', '138', 5, 2.03, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Coca cola KS' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'del valle kapo morango 200ml', '7894900583700', 3.75, 2.38, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900583700' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Del valle lata pessego 290ml', '7894900660319', 5.5, 3.56, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900660319' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Iogurte integral frutap 150g', '7896862000431', 4, 2.7, '04032000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896862000431' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Tang sabor uva intenso 18g', '7622210571663', 2, 0.89, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210571663' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chocolate Suflair Nestlé 50g', '7891000107836', 8, 4.77, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000107836' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Tang sabor tangerina', '7622210571632', 2, 0.89, '21069010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210571632' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Tang sabor abacaxi', '7622210571755', 2, 0.89, '21069010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210571755' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Tang sabor goiaba', '7622210571496', 2, 0.89, '21069010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210571496' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Tang sabor laranja', '7622210571601', 2, 0.89, '21069010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210571601' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Tang sabor limão', '7622210571540', 2, 0.89, '21069010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210571540' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Tang sabor maracuja', '7622210571694', 2, 0.89, '21069010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210571694' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Tang sabor morango', '7622210571724', 2, 0.89, '21069010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210571724' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Suflair chocolate ao leite 50g', '7891000455722', 8.5, 5.64, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000455722' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chocolate Kit Kat branco', '7891000249239', 5, 3.6, '19053200', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000249239' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolo de laranja pullman 250g', '7896002361033', 12, 7.49, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002361033' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolo frapê pullman 250gr', '7896002360982', 12, 7.49, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002360982' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolo de gotas de chocolate pullman 250g', '7896002362146', 12, 7.49, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002362146' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolo de chocolate pullman 250g', '7896002361019', 12, 7.49, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002361019' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chocolate Twix caramelo 40g', '7896423470994', 5, 2.99, '18063110', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896423470994' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Pão de forma Pullman 480g', '7896002360326', 12, 6.99, '19059010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002360326' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Tempero Sazon carne 60g', '7891132019281', 7.5, 0, '21039021', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891132019281' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Tempero Sazon Salada 60g', '7891132019731', 0, 4.59, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891132019731' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'adicional de frango', '262', 10, 0, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'adicional de frango' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Fosfuro Que luz c/40 un', '4047', 0.6, 0.36, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Fosfuro Que luz c/40 un' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Fosfuro Paraná unidade', '1022', 0.6, 0.37, '36050000', 'cx', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Fosfuro Paraná unidade' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Palito de Dente c/100 unid Fiat lux', '7896007952144', 1.75, 0.99, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896007952144' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite em pó integral piracanjuba 400g', '7898215152347', 23.85, 13.99, '04022110', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898215152347' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Molho pimenta Gota 150ml', '7898286190316', 4.3, 2.89, '21039021', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898286190316' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Café extra forte 3 corações 250g', '7896005801512', 20.99, 13.95, '09012100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896005801512' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Creme dental colgate 50g', '7891024132906', 4.5, 3.05, '33061000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891024132906' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Farinha de trigo dona benta 1kg', '7896005202074', 7, 5.29, '11010010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896005202074' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Ana Maria sabor baunilha 35g', '7896002303781', 0, 2.39, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002303781' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sorvete kascão napolitano 1,5L', '7896513915220', 32.9, 23.42, '21050010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896513915220' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sorvete kascão flocos 1,5L', '7896513915237', 32.9, 23.42, '21050010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896513915237' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cloro Máximo 5 Litros', '7898944352124', 20, 18.5, '28011000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352124' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Agua sanitaria maximo 2L', '7898944352025', 5.5, 4.9, '28289011', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352025' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Refrigerante It Guarana 2L', '7898377662425', 3.99, 6.88, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898377662425' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Refrigerante It Cola 2L', '7898377662401', 3.99, 6.74, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898377662401' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Refrigerante it Limão 2L', '7898377662449', 4.99, 6.88, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898377662449' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'suco frisco sabor abacaxi', '7896045112098', 1.25, 0, '21069010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896045112098' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Café solúvel extra forte 3 corações', '7896045111398', 0, 0, '21011110', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896045111398' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Gelatina morango apit 20g', '7896327516118', 2.5, 1.48, '21069029', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896327516118' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'tapioca da terrinha 500gr', '7898994081623', 8, 4.59, '19030000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898994081623' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Miojo Nissin Galinha Caipira 85g', '7891079000229', 4.2, 2.79, '19023000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891079000229' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Goiabada Xavante 300g', '7896235800149', 4.2, 0, '20079924', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896235800149' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sardinha enlatada em oleo Coqueiro 175g', '7896009301049', 8.75, 5.99, '16041310', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896009301049' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite de coco Bom coco 200ml', '7898406780755', 2.5, 1.85, '20098990', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898406780755' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cafe soluvel 3 corações 40g', '7896045103003', 11.8, 6.99, '21011110', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896045103003' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Água de coco Sococo 200ml', '7896016601972', 0, 2.49, '20098921', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896016601972' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coco ralado menina 50gr', '7896028030661', 3.7, 2.99, '08011100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896028030661' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite de coco menina 200ml', '7896028014494', 5, 3.45, '20098990', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896028014494' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolacha bono chocolate 90gr', '7891000376843', 3.3, 2.23, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000376843' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolacha bono doce de leite 90gr', '7891000376928', 3.3, 1.74, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000376928' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolacha negresco 90gr', '7891000376768', 3.3, 2.24, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000376768' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Papel higienico tropicos 4 rolos', '7898910365028', 5.5, 3.71, '48181000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898910365028' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'ALCOOL tauipe 1 litro', '7898969948036', 0, 0, '22071090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898969948036' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Salgadinho Fandangos queijo Elma Chips 35g', '7892840822866', 0, 3.79, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7892840822866' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Salgadinhos Cheetos assado parmesao 35g', '7892840822286', 5.5, 3.85, '19041000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7892840822286' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Salgadinho Fandangos  Presunto 35G', '7892840822859', 0, 3.79, '19041000', 'kg', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7892840822859' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Salgadinho cheetos assado requeijao 40G', '7892840822309', 4.5, 3.45, '19041000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7892840822309' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'SAL GROSSO LEBRE', '7896110100814', 4.6, 2.59, '25010020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896110100814' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Filtro de cafe Brigitta 103', '7891021002127', 5.6, 3.19, '48232099', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891021002127' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Filtro de cafe melitta 103', '7891021001946', 6, 3.69, '48232099', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891021001946' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'dorflex unidade', '113', 1, 0.52, '30049069', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'dorflex unidade' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Kitut carne enlatada 320g', '7896031203359', 13.5, 10.49, '16025000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896031203359' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'MODA RE', '375', 5, 0, '16010000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'MODA RE' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chocolate Kit Kat ao leite', '7891000248768', 5, 3.58, '19053200', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000248768' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Rothmans global red/vermelho novo', '78947627', 8, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '78947627' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Ana maria chocolate 45g', '7896002301510', 2.5, 2.39, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002301510' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Ana maria sabor chocolate 42g', '7896002362054', 2.7, 2.79, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002362054' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Caixa de bombom nestle 220g', '7891000457467', 17, 11.51, '18069000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000457467' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cotonetes York 75un', '7896235353171', 0, 2.99, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896235353171' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Ana maria cenoura com chocolate 35g', '7896002366557', 2.75, 2.39, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002366557' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'goiabada anhembi 300gr', '7896113200214', 0, 0, '20079990', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896113200214' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Rothmans global blue/azul novo', '78947610', 8, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '78947610' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Pate sabor peito de peru Sadia 100g', '7893000025653', 3.7, 3.04, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7893000025653' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Milho de pipoca premium Kicaldo 400g', '7896116910011', 0, 2.93, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896116910011' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Pipoca sabor manteiga YOKI 100g', '7891095100934', 0, 4.69, '20081900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891095100934' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Iogurte sabor frutas vermelhas Frutilac 130g', '7896862003128', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896862003128' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Iogurte sabor morango Frutilac 130g', '7896862001780', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896862001780' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'OMELETE SIMPLES', '8019', 12, 0, '19052090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'OMELETE SIMPLES' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Macarrão espaguete Dona Benta 500g', '7896005286579', 5, 3.22, '19021100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896005286579' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Goma sabor eucalipto refrescante 18g', '7897064812853', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897064812853' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Pipoca de microondas sabor natural Kisabor 100g', '7898416527104', 5, 2.99, '20081900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898416527104' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coco ralado Mais coco 50g', '7896004401058', 0, 3.49, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896004401058' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Papel aluminio wyda 4 metros', '7898930672465', 5.85, 3.09, '76071110', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898930672465' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'MACARRÃO DONA BENTA PENNE 500GR', '7896005281710', 5.6, 0, '19021100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896005281710' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite Jussara integral 1 litro', '7896283800801', 7.99, 5.1, '04012010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896283800801' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Desodorante em creme herbissimo hibisco 55g', '7896049525726', 0, 5.29, '33072090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896049525726' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Desodorante herbissimo fresh 55g', '7896049528604', 0, 5.29, '33072090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896049528604' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Desodorante herbissimo sensitive 55g', '7896049528567', 0, 5.29, '33072090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896049528567' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabonete gardenia e oleo de amendoas Lux 85g', '7891150095304', 3.5, 2.39, '34011190', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891150095304' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabonete manteiga de cacau Palmolive 85g', '7891024034880', 0, 2.09, '34011190', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891024034880' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabonete melancia Albany 80g', '7908324410174', 0, 1.89, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7908324410174' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabonete maracujá Albany 80g', '7908324410167', 0, 1.89, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7908324410167' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabonete em barra argila preta Palmolive 85g', '7509546695389', 0, 2.09, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7509546695389' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Absorvente Always fluxo intenso seca G', '7506339394535', 12.75, 7.9, '96190000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7506339394535' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Absorvente Always Fluxo Intenso suave G', '7506339394603', 12.75, 7.9, '96190000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7506339394603' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sal Lebre 1kg', '7896110100043', 3.5, 2.99, '25010020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896110100043' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Café Caboclo tradicional 500g', '7896089011470', 43, 19.9, '09012100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896089011470' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Amido de milho Apti 200g', '7896327512615', 0, 2.58, '11081200', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896327512615' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Paçocão irinel doces 70g', '7891098310019', 2, 1.1, '17049090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891098310019' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'creme skala coco 1000kg', '7897042010974', 0, 9.49, '33059000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897042010974' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'CREME SKALA ABACATE COM OLEO RICINO 1000G', '7897042005048', 0, 11.9, '33059000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897042005048' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Creme Skala divino potão 1kg', '7897042007226', 0, 11.9, '33059000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897042007226' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'CREME SKALA GLICOLICO 1000G', '7897042016907', 0, 9.9, '33059000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897042016907' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Creme de pentear Skala Ceramidas 1kg', '7897042004904', 13, 9.9, '33059000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897042004904' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Creme de pentear Potão do amor Skala 1kg', '7897042010714', 0, 9.9, '33059000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897042010714' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Creme de pentear Babosa Skala 1kg', '7897042005062', 0, 9.9, '33059000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897042005062' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Creme de pentear Skala Mais liso 1kg', '7897042008407', 0, 9.9, '33059000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897042008407' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Creme Skala Amido de milho 1kg', '7897042012732', 0, 9.9, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897042012732' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Creme Skala potão desmaiado 1kg', '7897042012725', 0, 9.9, '33059000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897042012725' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Escova dental Dentrat equilibrio media', '7898395840362', 4.8, 2.49, '96032100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898395840362' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Ketchup Ekma 400g', '7896455001142', 0, 4.59, '21032010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896455001142' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Batata palha amavita 80g', '7898931140512', 5.9, 3.89, '20052000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898931140512' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Rothmans silver global', '78947634', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '78947634' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Crocante chocolate 25g', '7891008124583', 3.5, 2.61, '18069000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891008124583' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'suco marata 200ml sabor pessego', '7898378180188', 2.5, 1.48, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898378180188' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'suco marata 200ml sabor laranja', '7898378180133', 2.5, 1.48, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898378180133' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Suco marata 200ml caju', '7898378180171', 2.5, 1.48, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898378180171' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Suco marata 1 litro maracuja', '7898378180072', 8, 4.4, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898378180072' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'suco marata 1 litro sabor caju', '7898378180058', 8, 4.4, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898378180058' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'suco marata 1 litro sabor pessego', '7898378180065', 8, 4.4, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898378180065' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'suco marata 1 litro sabor uva', '7898378180027', 8, 4.4, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898378180027' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'suco marata 1 litro sabor laranja', '7898378180010', 8, 4.4, '22029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898378180010' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Suco prats uva integral 300ml', '7898953148718', 9.8, 6.55, '20096100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898953148718' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Suco prats uva 900ml', '7898953148220', 25, 17.5, '20096100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898953148220' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Café Pilão Tradicional 500g', '7896089012019', 34, 22.9, '09012100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896089012019' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Café Pilão Tradicional 250g', '7896089011982', 17.99, 11.45, '09012100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896089011982' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolacha agua e sal vitarella 350g', '7896213006242', 7.99, 5.39, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896213006242' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Maionese Quero 200g', '7896102509434', 5.75, 3.79, '21039011', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896102509434' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Óleo composto Cebola e alho Maria 500ml', '7896036096451', 19.99, 12.96, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896036096451' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Achocolatado Toddy 370g', '7892840819507', 14.99, 9.96, '18069000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7892840819507' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Achocolatado em pó Nescau 200g', '7891000379585', 9.5, 6.96, '18069000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000379585' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Maione Quero 495g', '7896102584998', 10.5, 6.65, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896102584998' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Maionese Vigor 200g', '7891999948908', 4.99, 3.29, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891999948908' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Tapioca da Terrinha 1kg', '7898994081630', 12, 7.98, '19030000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898994081630' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolacha maizena Marilan 300g', '7896003740226', 6.99, 4.29, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896003740226' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Molho de tomate fugini 300g', '7897517206086', 3.5, 1.79, '21032010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897517206086' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Guaraviton sabor açai 500ml', '7896326100219', 5, 1.69, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896326100219' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'hamburguer texas seara 56gr', '7894904500383', 2.5, 0.9, '16029000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894904500383' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Velho barreiro Dose', '417', 3.5, 0, '22084000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Velho barreiro Dose' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'CHOCOTONE', '520', 15, 0, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'CHOCOTONE' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'pastelao', '626', 12, 0, '21069090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'pastelao' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Pastel de frango', '1014', 8, 0, '19022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Pastel de frango' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'COSTELA DE ADÃO', '8100', 12, 0, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'COSTELA DE ADÃO' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cerveja Antarctica 600ml', '78905276', 12, 4.08, '22030000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '78905276' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'SBP Multinseticida 380ml', '7891035618567', 21.75, 12.39, '38089119', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891035618567' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'trakinas chocolate 126gr', '7622210592750', 5, 2.11, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210592750' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'trakinas morango 126gr', '7622210592781', 5, 2.11, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210592781' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Babbaloo uva unidade', '7895800002933', 0.5, 0.26, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7895800002933' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Barra chocolate laka Lacta 80g', '7622210674319', 12, 8.13, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210674319' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Barra chocolate ao leite Lacta 80g', '7622210673831', 12, 8.13, '18063210', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210673831' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Biscoito pao de mel 130g', '7898070347834', 8.5, 5.98, '20052000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898070347834' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Biscoito Juju 170g', '7898070347841', 8.5, 5.98, '16010000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898070347841' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Biscoito bolinha com goiabada 160g', '7898070347865', 8, 5.75, '19023000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898070347865' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Biscoito casadinho de goiabada 160g', '7898070347872', 8, 5.75, '16010000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898070347872' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Biscoito palito de chocolate 170g', '7898070347858', 8, 5.75, '20052000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898070347858' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Vela c/8 n*8 Paraná', '7896080901114', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896080901114' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Vela c/8 n*6 Luz do senhor', '7897935400509', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897935400509' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Velas c/6 n*9 Paraná', '7896080901145', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896080901145' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Miojo galinha caipira Maratá', '7898617581769', 2, 0, '19023000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898617581769' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Esfiha Aberta', '1012', 8, 0, '19022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Esfiha Aberta' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Farinha de trigo Dona Laura 1kg', '7897932900040', 0, 2.79, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897932900040' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabonete em barra lavanda Francis intenso 85g', '7891176117516', 0, 1.48, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891176117516' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabonete em barra jasmim Francis intenso 85g', '7891176117349', 0, 1.48, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891176117349' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabonete em barra rosas Francis intenso 85g', '7891176117462', 0, 1.48, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891176117462' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Papel higienico Primavera 4 rolos', '7896075301103', 0, 2.89, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896075301103' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Papel higienico BestLite folha dupla 4 rolos', '7896053470166', 0, 3.59, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896053470166' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Papel higienico fofinho 12 rolos', '7896053411220', 0, 9.34, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896053411220' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Papel higienico fofinho 4 rolos', '7896053410025', 0, 3.39, '48181000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896053410025' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Goiabada Xavante 200g', '7896235800279', 0, 2.49, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896235800279' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'ChocoStick avelã Nestlé 26g', '7891000477410', 0, 2.3, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000477410' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolacha de leite Marilan 300g', '7896003740240', 0, 4.39, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896003740240' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Alcool tauipe 92º 500ml', '7898969948067', 7.96, 6.07, '22071090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898969948067' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabão liquido maximo 2 litros', '7898944352445', 10, 8.89, '34012090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352445' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Farinha de trigo Nita 1kg', '7898234850576', 6, 4.29, '11010010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898234850576' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coco ralado DuCoco 100g', '7896016601217', 0, 3.99, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896016601217' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Achocolatado nescau 350g', '7891000412855', 13.5, 8.9, '18069000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000412855' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cloro hipoclorito 1L', '7898944352100', 4.35, 4.24, '28289011', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352100' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cloro hipoclorito 2L', '7898944352117', 8.5, 7.95, '28289011', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352117' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cookies MELFI', '6026', 12, 8, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Cookies MELFI' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Agua sanitaria maximo 1L', '7898944352018', 3.5, 2.8, '28289011', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352018' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Pão de batata', '3099', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Pão de batata' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Havaiana Branca lisa 37/38', '7891109714485', 30, 21.76, '64022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891109714485' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'havaianas 27/28 branca', '7891109714430', 26, 0, '64022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891109714430' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'HAVAIANAS BRANCO 31/32', '7891109714454', 21.65, 0, '64022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891109714454' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'havaianas 29/30 preto', '7891109635209', 26, 0, '64022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891109635209' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'havaianas 27/28 azul', '7890557722189', 26, 0, '64022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7890557722189' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Havaianas Azul naval 35/36', '7890557722226', 0, 21.76, '64022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7890557722226' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Havaianas preto 35/36', '7891109486207', 30, 21.76, '64022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891109486207' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'havaianas 37/38 azul', '7890541601889', 30, 0, '64022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7890541601889' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Suco del valle pêssego 200ml', '7894900660425', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900660425' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'bis  branco 100,8gr', '7622210575999', 9.99, 0, '19053200', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210575999' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'bis lacta original 100,8gr', '7622210575975', 9.99, 6.19, '19053200', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210575975' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Amaciante brisa de verão Downy 350ml', '7500435252942', 0, 7.59, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7500435252942' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bombril 6 unid 45g', '7891022868036', 0, 1.75, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891022868036' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite em pó integral 200g', '7898080640376', 12, 6.99, '04022110', 'pc', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898080640376' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Milho de pipoca Sinha 400g', '7892300030107', 0, 3.79, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7892300030107' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Massa de lasanha tradicional Petybon 200g', '7896005271377', 4.5, 2.89, '19021900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896005271377' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Molho Shoyu Tradicional Arrifana 150ml', '7896056101234', 0, 3.39, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896056101234' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Molho shoyu Sakura 150ml', '7896007811007', 0, 3.7, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896007811007' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Refrigerante Guaraná Antarctica 2,5L', '7891991008655', 9.99, 6.94, '22021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891991008655' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Biscoito maizena leite vitarella 350g', '7896213006426', 0, 6.3, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896213006426' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Absorvente Ladysoft noturno', '7896061980060', 9.9, 3.99, '96190000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896061980060' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cafe extra forte Melitta 500g', '7891021005067', 0, 27.9, '09012100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891021005067' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Café tradicional Melitta 250g', '7891021006071', 23.5, 13.95, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891021006071' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite condensado Piracanjuba 395g', '7898215152002', 9.9, 6.29, '04029900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898215152002' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Trakinas sabor meio a meio 120g', '7622210592637', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622210592637' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Suco del valle uva 200ml', '7894900660432', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894900660432' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Fermento quimico em po Apti 100g', '7896327512967', 4, 2.79, '21023000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896327512967' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Ketchup picante Predilecta 400g', '7896292360464', 8.75, 5.85, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896292360464' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Naftalina mil aromas 20g', '7898907542036', 3.5, 2.26, '29029020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898907542036' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Limpa aluminio maximo 500ml', '7898944352285', 4, 3.47, '34025000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352285' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Desinfetante maximo talco mandarim 2L', '7898944352391', 6, 4.19, '38089419', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352391' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Desinfetante maximo primavera 2L', '7898944352384', 6, 4.19, '38089419', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352384' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Desinfetante maximo max clean 2L', '7898944352209', 6, 4.19, '38089419', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352209' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Desinfetante maximo jasmin 2L', '7898944352186', 6, 4.19, '38089419', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352186' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Desinfetante maximo floral 2L', '7898944352292', 6, 4.19, '38089419', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352292' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Desinfetante maximo eucalipito 2L', '7898944352315', 6, 4.19, '38089419', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352315' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Desinfetante maximo citrus 2L', '7898944352179', 6, 4.19, '38089419', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352179' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Desinfetante maximo baby clean 2L', '7898944352193', 0, 4.19, '38089419', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898944352193' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Requeijão qualy 200gr com queijos', '7891515557454', 10, 6.03, '04061090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891515557454' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Margarina gourmet c/sal Becel 250g', '7891515644499', 7.6, 4.87, '15171000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891515644499' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Red bull 473ml', '9002490214166', 16, 10.72, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '9002490214166' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Pipoca doce Emilia 80g', '7898667960125', 0, 2.5, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898667960125' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Empadinha de palmito', '6222', 12, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Empadinha de palmito' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Ana Maria Morango 70g', '7896002311823', 4.25, 2.99, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002311823' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Ana Maria baunilha 70g', '7896002362412', 4.25, 2.99, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002362412' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Ana Maria triplo chocolate 70g', '7896002311830', 4.25, 2.99, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002311830' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Caldo de galinha Maggi 57g', '7891000250174', 0, 1.95, '21041011', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000250174' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Biscoito 7 capas  Sao Benedito 300g', '7897053100077', 11.5, 8.5, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897053100077' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cup Noodles costela c/ churrasco 68g', '7891079013083', 0, 5.29, '19023000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891079013083' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Miojo Cup noodles Galinha picante Nissin 68g', '7891079013069', 0, 5.29, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891079013069' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Miojo Cup noodles Bolonhesa nissin 72g', '7891079013120', 0, 5.29, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891079013120' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Miojo Cup noodles galinha caipira 69g', '7891079013038', 6.5, 5.29, '19023000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891079013038' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'MAIONESE HELLMAN´NS 500GR', '7894000050034', 13.5, 8.6, '21039011', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7894000050034' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Molho inglês Campo Belo 150ml', '7898075643948', 0, 2.39, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898075643948' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chá leão camomila c/ 15 sachê 15g', '7891098010575', 12, 7.98, '21012010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891098010575' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Flocão maratá 500g', '7898932426042', 3.5, 1.99, '11041900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898932426042' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolacha Cream cracker Marilan 140g', '7896003740318', 0, 1.99, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896003740318' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Molho Shoyu sakura 150ml', '7896007800056', 4.5, 3.7, '21031010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896007800056' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolacha Cream Cracker Marilan 300g', '7896003738612', 0, 4.39, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896003738612' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolacha de agua e sal Marilan 300g', '7896003740189', 0, 5.98, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896003740189' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolacha de Água e sal Mabel 300g', '7896071030069', 0, 4.39, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896071030069' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Farinha de trigo Rosa Branca 1kg', '7892020200194', 7, 4.39, '11010010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7892020200194' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Molho de alho Campo belo 150ml', '7898075643917', 2.7, 2.39, '21039091', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898075643917' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Detergente liquido coco Bulnez 500g', '7896105510796', 0, 1.85, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896105510796' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Mistura para bolo chocolate c/ avelã Fleischmann 390g', '7898331013331', 0, 6.98, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898331013331' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Mistura para bolo Chocolate cremoso Dr. Oetker 300g', '7891048061794', 0, 5.28, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891048061794' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Mistura para bolo brigadeiro Dr. Oetker 300g', '7891048061824', 0, 5.28, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891048061824' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'PAO DE FORMA integrl pullman', '7896002300148', 0, 5.89, '19059010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002300148' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Torta liquidificador de Carne seca', '4040', 12, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Torta liquidificador de Carne seca' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'torta de carne', '1139', 12, 0, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'torta de carne' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'torta de frango', '1140', 12, 0, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'torta de frango' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Prestobarba gilette ultra azul un', '7500435154420', 5, 2.28, '82121020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7500435154420' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Filtro de papel café103 3 corações', '7896005803721', 5.99, 2.99, '48232099', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896005803721' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Prestorbarba bic amarelo', '070330703629', 3.5, 1.04, '82121020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '070330703629' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chocolate Prestigio frutas vermelhas 33g', '7891000454589', 3.5, 2.29, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000454589' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Guaraná Antarctica Zero 350ml', '7891991000727', 6, 0, '02071419', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891991000727' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chocotrio barra sabor avelã Nestle 90g', '7891000422083', 12, 7.68, '18063210', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000422083' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cookies Nescau duo 60g', '7891000339558', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000339558' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'COOKIES NESTLE SABORES 60G', '7891000339596', 0, 0, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000339596' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cookies prestigio nestle 60g', '7891000339237', 3.6, 1.98, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000339237' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cookie negresco nestlé 90g', '7891000247624', 3.6, 1.98, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000247624' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Cookies caribe', '7891000402894', 3.6, 0, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000402894' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'carolina', '461', 55, 0, '19019090', 'kg', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'carolina' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'ROCAMBOLE DE CHOCOLATE', '531', 45, 0, '19059090', 'kg', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'ROCAMBOLE DE CHOCOLATE' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'ROCAMBOLE DE DOCE DE LEITE', '478', 40, 0, '19059090', 'kg', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'ROCAMBOLE DE DOCE DE LEITE' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'ROCAMBOLE DE GOIABADA', '477', 40, 0, '19059090', 'kg', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'ROCAMBOLE DE GOIABADA' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Mostarda Predilecta 180g', '7896292300477', 5.5, 3.65, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896292300477' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'salgadinho fofura presunto 60gr', '7892840823207', 3.5, 1.55, '19041000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7892840823207' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'pão francês', '224', 17.5, 0, '21069090', 'kg', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'pão francês' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabão em pó Tixan Ype Primavera 1,6KG', '7896098909768', 0, 15.89, '34025000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896098909768' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabão em pó Tixan ype 1,6kg', '7896098909775', 0, 15.89, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896098909775' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'secar lavanda de paris', '7896013404682', 0, 0, '33074900', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896013404682' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Iogurte frutap desnatado 150g', '7896862002763', 4, 2.55, '04032000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896862002763' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Gelatina Colorida 200g', '5039', 6, 0, '19052090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Gelatina Colorida 200g' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'SURPRESA DE UVA', '327', 10, 0, '19019090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'SURPRESA DE UVA' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'PAVE C/ CREME DE AVELA', '3042', 10, 0, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'PAVE C/ CREME DE AVELA' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Pudim pequeno', '979', 6, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Pudim pequeno' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Inseticida Mat inset 360ml', '7897664170766', 0, 13.79, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897664170766' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Amaciante Fofo azul 500ml', '7891150092716', 0, 9.29, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891150092716' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Amaciante glicerina e camomila Vida macia 500ml', '7896040705318', 0, 6.99, '38099190', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896040705318' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'INSETICIDAS pro insect 250ml', '7899674039514', 0, 4.5, '38089119', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7899674039514' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Amaciante glicerina e amendoas Vida macia 500g', '7896040705325', 0, 6.99, '38099190', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896040705325' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Amaciante concentrado blue Ype 500ML', '7896098900390', 10.75, 8.9, '38099190', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896098900390' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'AMACIANTE  ypê delicado 500ml', '7896098903049', 0, 8.9, '38099190', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896098903049' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'RISOLE DE CARNE', '238', 9, 0, '19023000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'RISOLE DE CARNE' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'COXINHA DE COSTELA', '3068', 14, 0, '19022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'COXINHA DE COSTELA' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Macarrão parafuso Dona Benta 500g', '7896005286593', 5.6, 3.09, '19021100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896005286593' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Crepioca simples', '8007', 15, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Crepioca simples' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'pão c/ 1 salsicha', '178', 5, 0, '09011110', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'pão c/ 1 salsicha' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'pão c/ 2 salsicha', '179', 7, 0, '19023000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'pão c/ 2 salsicha' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'CHOCOLATE COM TODDY M', '198', 8, 0, '09011110', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'CHOCOLATE COM TODDY M' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Coxinha', '40', 9, 0, '02071300', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Coxinha' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'KIBE', '263', 9, 0, '16025000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'KIBE' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'RISOLE DE CARNE SECA', '239', 12, 0, '19023000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'RISOLE DE CARNE SECA' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'LEITE QUENTE G', '197', 6.5, 0, '09011110', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'LEITE QUENTE G' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'LEITE QUENTE P', '196', 5, 0, '09011110', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'LEITE QUENTE P' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'IOGURTE BATIDO', '200', 10, 0, '04032000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'IOGURTE BATIDO' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'CHÁ', '195', 5, 0, '09021000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'CHÁ' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabonete Albany perfumes da natureza 80g', '7908324404012', 0, 1.39, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7908324404012' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sabonete Albany hidratação intensiva 80g', '7897664171701', 0, 1.39, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897664171701' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolacha plugados rodonda sabor chocolate 120g', '7896085087417', 0, 2.29, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896085087417' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolacha plugados rodonda sabor morango 120g', '7896085087424', 0, 2.15, '19053100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896085087424' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'ChocoStick Baton e Caribe 24g', '7891000476475', 0, 2.3, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000476475' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Aveia em flocos finos apti 150g', '7896327501879', 0, 2.28, '11041200', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896327501879' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Aveia em flocos Apti 150g', '7896327501855', 0, 2.28, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896327501855' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'molho de tomate predilecta 300g', '7896292333000', 3.5, 1.49, '21032010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896292333000' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Amaciante Explosão de perfume Mon bijou 500ml', '7891022860566', 0, 8.9, '38099190', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891022860566' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Amaciante concentrado Mon Bijou 500ml', '7891022867374', 0, 8.9, '38099190', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891022867374' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Molho de tomate bolonhesa Bonare 300g', '7899659901058', 0, 2.69, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7899659901058' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Detergente Minuano Coco 500ml', '7897664130302', 3.75, 2.25, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897664130302' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Detergente Minuano Limão 500ml', '7897664130029', 3.75, 2.25, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7897664130029' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Absorvente Always super proteção suave c/8 un', '7500435127240', 5.85, 3.9, '96190000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7500435127240' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Absorvente suave c/ abas Sempre livre', '7891010035631', 14, 11.9, '96190000', 'pc', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891010035631' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Absorvente seca c/ abas Sempre livre', '7891010694593', 13.5, 11.9, '96190000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891010694593' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Oleo composto Olivia 500ml', '7896036098325', 16.5, 10.48, '15179010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896036098325' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Sardinha c/ oleo Robinson crusoe 75g', '7898943163011', 7.99, 5.29, '16041310', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898943163011' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Queijo ralado Kaman 40g', '7898071653309', 4.5, 2.99, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898071653309' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Raçao para cachorro CHAMP 1k', '1136', 8.5, 5.44, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Raçao para cachorro CHAMP 1k' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Raçao para cachorro adulto CHAMP 500g', '1137', 4.8, 2.72, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Raçao para cachorro adulto CHAMP 500g' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Ração BONZO para cães 500g', '1134', 5.99, 3.99, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Ração BONZO para cães 500g' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Ração BONZO para cães 1 kg', '1133', 11.99, 7.99, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Ração BONZO para cães 1 kg' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Pão Semi Italiano', '1013', 10, 0, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'Pão Semi Italiano' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Café com leite 3 corações sachê 20gr', '7896005807521', 2.5, 1.5, '21011200', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896005807521' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Café cappuccino chocolate sachet 20gr', '7896005802397', 0, 1.5, '21011200', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896005802397' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Café cappuccino 3 corações sachê 20gr', '7896005802373', 3, 1.5, '21011200', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896005802373' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Café 3 Fazendas 250g', '7891018002000', 8, 10.39, '09012100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891018002000' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Café Brasileiro tradicional 250g', '7891018427582', 19.5, 11.03, '09012100', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891018427582' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Milho predilecta lata 280g', '7896292340503', 6, 3.09, '20058000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896292340503' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite em pó Italac 400g', '7898080640369', 20.5, 14.29, '04022110', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898080640369' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Batata Plha Extrafina 100g', '7891095031122', 12.99, 9.75, '02071412', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891095031122' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'BOLO FATIA', '1001', 0, 0, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'BOLO FATIA' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite integral Parmalat 1L', '7896034610017', 7, 4.89, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896034610017' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chocolate Charge 40g', '7891000464908', 3.3, 2.2, '18069000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000464908' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chocolate shot branco Lacta 50,1g', '7622202303579', 0, 4.75, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622202303579' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Chocolate branco laka Lacta 50,1g', '7622202274619', 0, 4.75, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7622202274619' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bolacha Passatempo sabor chocolate 130g', '7891000457368', 0, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891000457368' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite integral italac 1 litro', '7898080640611', 7.5, 4.65, '04012010', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898080640611' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Ana Maria Napolitano 42g', '7896002368230', 3.25, 1.99, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002368230' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Ana Maria gotas de chocolate 70gr', '7896002363259', 4.25, 2.99, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002363259' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Bisnaguinha Pullman 300g', '7896002360234', 10.5, 6.49, '19059090', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896002360234' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'salgadinho fofura requeijão 60gr', '7892840823221', 3.5, 1.55, '19041000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7892840823221' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'salgadinho fofura churrasco 60gr', '7892840823191', 3.5, 1.55, '19041000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7892840823191' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'salgadinho fofura queijo 60gr', '7892840823214', 3.5, 1.55, '19041000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7892840823214' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Havaiana preta 43/44', '7891109486245', 30, 21.76, '64022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891109486245' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Havaiana Branca lisa 43/44', '7891109714515', 0, 21.76, '64022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891109714515' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Havaianas Branca lisa 39/40', '7891109714492', 30, 21.76, '64022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7891109714492' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Havaiana Azul naval 43/44', '7890557722264', 0, 21.76, '64022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7890557722264' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Havaiana Azul naval 41/42', '7890557722257', 0, 21.76, '64022000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7890557722257' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite em pó integral Piracanjuba 400g', '7898215152439', 0, 15.9, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898215152439' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite em pó integral Italac 200g', '7898080641687', 0, 8.2, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7898080641687' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'pastel de carne', '8080', 8, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'pastel de carne' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'pastel de calabresa', '8081', 8, 0, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'pastel de calabresa' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'pão sovado', '401', 10, 0, '16010000', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE nome = 'pão sovado' AND padaria_id = 3);

INSERT INTO produtos (padaria_id, nome, codigo_barras, preco_venda, custo_unitario, ncm, unidade, ativo)
SELECT 3, 'Leite de coco Mais coco 200ml', '7896004400297', 0, 5.39, '02012020', 'un', 1
WHERE NOT EXISTS (SELECT 1 FROM produtos WHERE codigo_barras = '7896004400297' AND padaria_id = 3);

