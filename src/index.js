require('dotenv').config();
const express     = require('express');
const cors        = require('cors');
const helmet      = require('helmet');
const compression = require('compression');
const rateLimit    = require('express-rate-limit');
const path        = require('path');
const fs          = require('fs');

const app  = express();
const PORT = process.env.PORT || 3000;

// Necessário no Render (e qualquer proxy reverso) para o rate limit funcionar corretamente
app.set('trust proxy', 1);

// Comprime as respostas (JS, CSS, JSON da API) antes de mandar — o app.js sozinho
// tem ~350KB, isso reduz bastante o que trafega pela rede, sobretudo no 3G/4G da loja.
app.use(compression());

// Garante pasta de upload
fs.mkdirSync('/tmp/panificapro', { recursive: true });

// Segurança: cabeçalhos HTTP
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", "'unsafe-inline'", 'https://unpkg.com', 'https://cdn.jsdelivr.net', 'https://static.cloudflareinsights.com'],
      scriptSrcAttr: ["'unsafe-inline'"],
      styleSrc: ["'self'", "'unsafe-inline'", 'https://fonts.googleapis.com'],
      fontSrc: ["'self'", 'https://fonts.gstatic.com'],
      imgSrc: ["'self'", 'data:', 'blob:'],
      connectSrc: ["'self'", 'https://cdn.jsdelivr.net', 'https://static.cloudflareinsights.com'],
      frameSrc: ["'none'"],
      objectSrc: ["'none'"],
    },
  },
}));

// Permissões de navegador: só câmera (scanner de código de barras / foto da maquininha),
// nada mais — bloqueia geolocalização, microfone, pagamento, USB, etc.
app.use((req, res, next) => {
  res.setHeader('Permissions-Policy',
    'camera=(self), microphone=(), geolocation=(), payment=(), usb=(), magnetometer=(), gyroscope=(), interest-cohort=()');
  next();
});

// CORS restrito ao domínio de produção
const ALLOWED_ORIGINS = (process.env.ALLOWED_ORIGINS || 'https://panificapro-erp.onrender.com')
  .split(',').map(o => o.trim());
app.use(cors({
  origin: (origin, cb) => {
    // Bloqueia requisições sem origin (exceto webhooks da Hotmart que têm rota própria)
    if (!origin) return cb(null, false);
    if (ALLOWED_ORIGINS.includes(origin)) return cb(null, true);
    cb(null, false);
  },
  credentials: true
}));

// A API é toda dinâmica (dados mudam a cada request) — sem isso, algum cache no meio
// do caminho (proxy, CDN tipo Cloudflare, ou até o próprio navegador) podia guardar uma
// resposta antiga e servir ela de novo depois, mesmo com os dados já tendo mudado no
// banco. Bug real: notas fiscais já corrigidas continuavam aparecendo como pendentes.
app.use('/api', (req, res, next) => {
  res.setHeader('Cache-Control', 'no-store, no-cache, must-revalidate');
  next();
});

// Rate limiting geral — 200 req/min por IP
app.use('/api', rateLimit({
  windowMs: 60 * 1000,
  max: 200,
  standardHeaders: true,
  legacyHeaders: false,
  message: { erro: 'Muitas requisições. Tente novamente em alguns segundos.' }
}));

// Rate limiting no cadastro — 5 tentativas/hora por IP
app.use('/api/auth/registrar', rateLimit({
  windowMs: 60 * 60 * 1000,
  max: 5,
  standardHeaders: true,
  legacyHeaders: false,
  message: { erro: 'Muitos cadastros. Tente novamente em 1 hora.' }
}));

// Rate limiting na verificação de código — 20 tentativas/hora por IP
app.use('/api/auth/verificar-codigo', rateLimit({
  windowMs: 60 * 60 * 1000,
  max: 20,
  standardHeaders: true,
  legacyHeaders: false,
  message: { erro: 'Muitas tentativas. Tente novamente em 1 hora.' }
}));

// Rate limiting rigoroso no login — 10 tentativas/15min por IP
app.use('/api/auth/login', rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 10,
  standardHeaders: true,
  legacyHeaders: false,
  message: { erro: 'Muitas tentativas de login. Aguarde 15 minutos.' }
}));

// Rate limiting na recuperação de senha — 20 tentativas/hora por IP
app.use('/api/auth/esqueci-senha', rateLimit({
  windowMs: 60 * 60 * 1000,
  max: 20,
  standardHeaders: true,
  legacyHeaders: false,
  message: { erro: 'Muitas solicitações de recuperação. Aguarde 1 hora.' }
}));

// Rate limiting em conferência de PIN (4 dígitos = só 10.000 combinações) — Financeiro, Caixa e Atendente
const limitePin = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 15,
  standardHeaders: true,
  legacyHeaders: false,
  message: { erro: 'Muitas tentativas de PIN. Aguarde 15 minutos.' }
});
app.use('/api/financeiro/pin', limitePin);
app.use('/api/caixa/abrir', limitePin);
app.use(/^\/api\/atendentes\/\d+\/verificar-pin$/, limitePin);
// Login do aparelho fixado (nome + PIN de 4 dígitos) — mesma trava, senão dá pra
// tentar as 10.000 combinações usando só o limite geral da API.
app.use('/api/auth/login-caixa', limitePin);

app.use(express.json({ limit: '512kb' }));
// O sw.js (service worker) é notoriamente teimoso pra cache — navegadores (principalmente
// no celular, quando o app é "adicionado à tela inicial") podem segurar uma versão antiga
// por muito tempo mesmo fechando/reabrindo. Isso força ele a sempre checar de novo.
app.get('/sw.js', (req, res) => {
  res.set('Cache-Control', 'no-cache, no-store, must-revalidate');
  res.sendFile(path.join(__dirname, '../public/sw.js'));
});
app.use(express.static(path.join(__dirname, '../public'), {
  // Cache forte nos arquivos estáticos — como o app.js/app.css já usam ?v=... pra
  // invalidar o cache manualmente a cada deploy, pode deixar o navegador guardar
  // por bastante tempo sem medo de servir versão velha.
  maxAge: '7d',
  // MAS o index.html (e qualquer outro .html) precisa ficar de fora dessa regra —
  // é ele quem contém o "?v=..." que aponta pra versão certa do app.js/app.css.
  // Se ele mesmo ficasse em cache por dias, os deploys de frontend não apareceriam
  // pra ninguém até o cache expirar sozinho (bug real, introduzido junto com o
  // cache forte — corrigido antes de virar um problema de verdade em produção).
  setHeaders: (res, filePath) => {
    if (filePath.endsWith('.html')) {
      res.setHeader('Cache-Control', 'no-cache, must-revalidate');
    }
  },
}));

// Auto-migrate: adiciona colunas novas sem quebrar instâncias existentes
(async () => {
  try {
    const db = require('./database/connection');
    const migrations = [
      'ALTER TABLE produtos ADD COLUMN fornecedor_id INT NULL',
      'ALTER TABLE produtos ADD COLUMN ultima_compra DATE NULL',
      'ALTER TABLE padarias ADD COLUMN reset_token VARCHAR(512) NULL',
      'ALTER TABLE padarias ADD COLUMN reset_expires DATETIME NULL',
      "ALTER TABLE padarias ADD COLUMN role VARCHAR(20) NOT NULL DEFAULT 'user'",
      'ALTER TABLE itens_pedido ADD COLUMN nome_temp VARCHAR(200) NULL',
      'ALTER TABLE itens_pedido ADD COLUMN unidade_temp VARCHAR(20) NULL',
      'ALTER TABLE itens_pedido ADD COLUMN minimo_temp FLOAT NULL',
      'ALTER TABLE itens_pedido ADD COLUMN is_novo TINYINT(1) DEFAULT 0',
      'ALTER TABLE itens_pedido MODIFY COLUMN produto_id INT NULL',
      `CREATE TABLE IF NOT EXISTS codigos_ativacao (
        id INT AUTO_INCREMENT PRIMARY KEY,
        codigo VARCHAR(32) NOT NULL UNIQUE,
        plano VARCHAR(20) NOT NULL DEFAULT 'essencial',
        meses INT NOT NULL DEFAULT 1,
        dias INT NULL,
        usado TINYINT(1) NOT NULL DEFAULT 0,
        padaria_id INT NULL,
        criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        usado_em DATETIME NULL
      )`,
      'ALTER TABLE codigos_ativacao ADD COLUMN meses INT NOT NULL DEFAULT 1',
      'ALTER TABLE codigos_ativacao ADD COLUMN dias INT NULL',
      `CREATE TABLE IF NOT EXISTS usuarios (
        id INT AUTO_INCREMENT PRIMARY KEY,
        padaria_id INT NOT NULL,
        nome VARCHAR(120) NOT NULL,
        email VARCHAR(120) NOT NULL UNIQUE,
        senha_hash VARCHAR(255) NOT NULL,
        role VARCHAR(20) NOT NULL DEFAULT 'membro',
        ativo TINYINT(1) NOT NULL DEFAULT 1,
        criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
      )`,
      'ALTER TABLE padarias ADD COLUMN plano_expira_em DATE NULL',
      'ALTER TABLE padarias ADD COLUMN plano_bloqueado TINYINT(1) NOT NULL DEFAULT 0',
      "ALTER TABLE padarias MODIFY COLUMN plano ENUM('trial','basico','essencial','pro','premium') DEFAULT 'trial'",
      'ALTER TABLE produtos ADD COLUMN embalagem_preco DECIMAL(10,2) NULL',
      'ALTER TABLE produtos ADD COLUMN embalagem_qtd DECIMAL(10,3) NULL',
      'ALTER TABLE itens_ficha MODIFY COLUMN produto_id INT NULL',
      'ALTER TABLE itens_ficha ADD COLUMN nome_livre VARCHAR(120) NULL',
      'ALTER TABLE padarias ADD COLUMN email_relatorio VARCHAR(120) NULL',
      `CREATE TABLE IF NOT EXISTS comandas (
        id           INT AUTO_INCREMENT PRIMARY KEY,
        padaria_id   INT NOT NULL,
        identificador VARCHAR(60) NOT NULL DEFAULT 'Comanda',
        status       ENUM('aberta','fechada','cancelada') NOT NULL DEFAULT 'aberta',
        total        DECIMAL(10,2) NOT NULL DEFAULT 0,
        forma_pagamento VARCHAR(50) NULL,
        aberta_em    DATETIME DEFAULT CURRENT_TIMESTAMP,
        fechada_em   DATETIME NULL,
        INDEX idx_comandas_padaria (padaria_id, status)
      )`,
      `CREATE TABLE IF NOT EXISTS itens_comanda (
        id           INT AUTO_INCREMENT PRIMARY KEY,
        comanda_id   INT NOT NULL,
        produto_id   INT NULL,
        nome_produto VARCHAR(150) NOT NULL,
        unidade      VARCHAR(20) NOT NULL DEFAULT 'un',
        quantidade   DECIMAL(10,3) NOT NULL,
        preco_unitario DECIMAL(10,2) NOT NULL,
        subtotal     DECIMAL(10,2) GENERATED ALWAYS AS (quantidade * preco_unitario) STORED,
        criado_em    DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (comanda_id) REFERENCES comandas(id) ON DELETE CASCADE
      )`,
      // Caixa (sessão de caixa do dia) + sangria/suprimento
      `CREATE TABLE IF NOT EXISTS caixas (
        id             INT AUTO_INCREMENT PRIMARY KEY,
        padaria_id     INT NOT NULL,
        status         ENUM('aberto','fechado') NOT NULL DEFAULT 'aberto',
        atendente      VARCHAR(80) NULL,
        valor_abertura DECIMAL(10,2) NOT NULL DEFAULT 0,
        valor_fechamento DECIMAL(10,2) NULL,
        valor_esperado DECIMAL(10,2) NULL,
        observacao     VARCHAR(255) NULL,
        aberto_em      DATETIME DEFAULT CURRENT_TIMESTAMP,
        fechado_em     DATETIME NULL,
        INDEX idx_caixas_padaria (padaria_id, status)
      )`,
      `CREATE TABLE IF NOT EXISTS caixa_movimentos (
        id          INT AUTO_INCREMENT PRIMARY KEY,
        caixa_id    INT NOT NULL,
        tipo        ENUM('sangria','suprimento') NOT NULL,
        valor       DECIMAL(10,2) NOT NULL,
        observacao  VARCHAR(255) NULL,
        criado_em   DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (caixa_id) REFERENCES caixas(id) ON DELETE CASCADE
      )`,
      // Pagamentos da comanda — permite dividir o valor em mais de uma forma de pagamento
      `CREATE TABLE IF NOT EXISTS comanda_pagamentos (
        id          INT AUTO_INCREMENT PRIMARY KEY,
        comanda_id  INT NOT NULL,
        forma_pagamento VARCHAR(50) NOT NULL,
        valor       DECIMAL(10,2) NOT NULL,
        criado_em   DATETIME DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (comanda_id) REFERENCES comandas(id) ON DELETE CASCADE
      )`,
      `CREATE TABLE IF NOT EXISTS atendentes (
        id          INT AUTO_INCREMENT PRIMARY KEY,
        padaria_id  INT NOT NULL,
        nome        VARCHAR(80) NOT NULL,
        ativo       TINYINT(1) NOT NULL DEFAULT 1,
        criado_em   DATETIME DEFAULT CURRENT_TIMESTAMP,
        INDEX idx_atendentes_padaria (padaria_id, ativo)
      )`,
      'ALTER TABLE comandas ADD COLUMN caixa_id INT NULL',
      'ALTER TABLE comandas ADD COLUMN desconto DECIMAL(10,2) NOT NULL DEFAULT 0',
      'ALTER TABLE comandas ADD COLUMN acrescimo DECIMAL(10,2) NOT NULL DEFAULT 0',
      'ALTER TABLE comandas ADD COLUMN atendente VARCHAR(80) NULL',
      'ALTER TABLE produtos ADD COLUMN venda_rapida TINYINT(1) NOT NULL DEFAULT 0',
      // Múltiplos caixas simultâneos (um por tablet/aparelho) + PIN por atendente
      "ALTER TABLE caixas ADD COLUMN nome VARCHAR(40) NOT NULL DEFAULT 'Caixa 1'",
      'ALTER TABLE atendentes ADD COLUMN pin_hash VARCHAR(255) NULL',
      // Papel do atendente — controla o que ele pode fazer no sistema: 'atendente' só
      // lança comanda; 'caixa' também abre/fecha caixa; 'gerente' também exclui item e
      // cancela comanda. Todo atendente já cadastrado antes disso vira 'atendente' por padrão.
      "ALTER TABLE atendentes ADD COLUMN role VARCHAR(20) NOT NULL DEFAULT 'atendente'",
      // Produtos de balcão (feitos na hora) não entram nos alertas de estoque zerado/reposição
      'ALTER TABLE produtos ADD COLUMN controla_estoque TINYINT(1) NOT NULL DEFAULT 1',
      // Encomendas — pedidos combinados com antecedência (bolo, festa etc.), pra não se perderem
      `CREATE TABLE IF NOT EXISTS encomendas (
        id             INT AUTO_INCREMENT PRIMARY KEY,
        padaria_id     INT NOT NULL,
        cliente_nome   VARCHAR(120) NOT NULL,
        cliente_telefone VARCHAR(30) NULL,
        descricao      TEXT NOT NULL,
        data_entrega   DATE NOT NULL,
        hora_entrega   TIME NULL,
        valor          DECIMAL(10,2) NOT NULL DEFAULT 0,
        sinal_pago     DECIMAL(10,2) NOT NULL DEFAULT 0,
        status         ENUM('pendente','producao','pronta','entregue','cancelada') NOT NULL DEFAULT 'pendente',
        observacao     VARCHAR(255) NULL,
        criado_em      DATETIME DEFAULT CURRENT_TIMESTAMP,
        atualizado_em  DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        INDEX idx_encomendas_padaria (padaria_id, status, data_entrega)
      )`,
      // Código interno da balança (peso variável) — vincula o produto do estoque ao código
      // gravado na etiqueta impressa pela balança (Toledo/Filizola/Urano), pra leitura automática no Comandas.
      'ALTER TABLE produtos ADD COLUMN codigo_balanca VARCHAR(10) NULL',
      'ALTER TABLE produtos ADD INDEX idx_produtos_codigo_balanca (padaria_id, codigo_balanca)',

      // NCM (Nomenclatura Comum do Mercosul) — classificação fiscal do produto, usada
      // na nota fiscal (NFC-e). Sem isso, a nota usa um código genérico como reserva.
      'ALTER TABLE produtos ADD COLUMN ncm VARCHAR(10) NULL',

      // Origem do produto (fabricado na padaria ou comprado pronto pra revender) e
      // situação do ICMS (normal / com Substituição Tributária / isento) — usados
      // pra escolher automaticamente o CFOP e o CSOSN certos na nota fiscal, em vez
      // de usar sempre o mesmo código genérico pra tudo (orientação do contador).
      "ALTER TABLE produtos ADD COLUMN origem_producao ENUM('propria','revenda') NOT NULL DEFAULT 'revenda'",
      "ALTER TABLE produtos ADD COLUMN situacao_icms ENUM('normal','st','isento') NOT NULL DEFAULT 'normal'",
      'ALTER TABLE produtos ADD COLUMN cest VARCHAR(9) NULL',

      // Índice pra acelerar a listagem de produtos (Estoque, busca de item na comanda) —
      // toda tela que carrega produtos filtra por padaria_id + ativo, sem índice o banco
      // teria que varrer a tabela inteira (mais de 1.100 produtos) a cada consulta.
      'ALTER TABLE produtos ADD INDEX idx_produtos_padaria_ativo (padaria_id, ativo)',

      // CSC de produção fica separado do CSC de homologação (teste) — são credenciais
      // diferentes, cada uma só funciona no ambiente Sefaz correspondente. Sem isso,
      // configurar o CSC de produção substituiria o de teste e quebraria os testes.
      'ALTER TABLE padarias ADD COLUMN nfce_csc_producao VARCHAR(255) NULL',
      'ALTER TABLE padarias ADD COLUMN nfce_id_csc_producao INT NULL',

      // Troco dado em pagamento à vista (dinheiro) — guardado por pagamento, pra
      // poder mostrar "Troco: R$ X" no recibo impresso depois.
      'ALTER TABLE comanda_pagamentos ADD COLUMN troco DECIMAL(10,2) NULL DEFAULT 0',

      // Caixa pausado (a pessoa saiu pro intervalo) — continua "aberto" no banco, só
      // trava a venda até alguém (com PIN de caixa/gerente) retomar.
      'ALTER TABLE caixas ADD COLUMN pausado TINYINT(1) NOT NULL DEFAULT 0',
      'ALTER TABLE caixas ADD COLUMN pausado_por VARCHAR(80) NULL',

      // VARCHAR(50) era pequeno demais pra guardar a descrição de venda dividida em
      // várias formas de pagamento (ex: "Dinheiro 3.00 + Crédito 13.00 + Débito 5.00 +
      // Pix 10.00 + Voucher 2.00") — dava erro ao fechar a comanda nesse caso.
      'ALTER TABLE comandas MODIFY COLUMN forma_pagamento VARCHAR(255) NULL',

      // Marca a comanda como "enviada pro caixa" (fechou o lançamento de pedido no tablet
      // do salão) — some da lista de quem tá lançando, mas continua aberta esperando o
      // caixa cobrar. Sem isso não dava pra distinguir "ainda sendo montada" de "pronta".
      'ALTER TABLE comandas ADD COLUMN pronta_pagamento TINYINT(1) NOT NULL DEFAULT 0',

      // Razão social oficial (CNPJ) — pode ser diferente do nome usado no dia a dia
      // do sistema (ex: "Padaria do Jota 3" no app, mas "Padaria do Jota 2 LTDA" no
      // CNPJ). A nota fiscal precisa da razão social oficial, não do apelido interno.
      'ALTER TABLE padarias ADD COLUMN nfce_razao_social VARCHAR(120) NULL',

      // ── NFC-e (Fase 1: cadastro fiscal + estrutura de notas) ──
      // Dados que precisam estar corretos na padaria pra emitir nota — sem isso a Sefaz rejeita.
      "ALTER TABLE padarias ADD COLUMN nfce_inscricao_estadual VARCHAR(20) NULL",
      "ALTER TABLE padarias ADD COLUMN nfce_regime_tributario TINYINT NULL COMMENT '1=Simples Nacional, 3=Regime Normal'",
      "ALTER TABLE padarias ADD COLUMN nfce_logradouro VARCHAR(120) NULL",
      "ALTER TABLE padarias ADD COLUMN nfce_numero VARCHAR(20) NULL",
      "ALTER TABLE padarias ADD COLUMN nfce_bairro VARCHAR(80) NULL",
      "ALTER TABLE padarias ADD COLUMN nfce_municipio VARCHAR(80) NULL",
      "ALTER TABLE padarias ADD COLUMN nfce_codigo_municipio_ibge VARCHAR(10) NULL",
      "ALTER TABLE padarias ADD COLUMN nfce_cep VARCHAR(10) NULL",
      "ALTER TABLE padarias ADD COLUMN nfce_uf VARCHAR(2) NULL",
      "ALTER TABLE padarias ADD COLUMN nfce_serie INT NOT NULL DEFAULT 1",
      "ALTER TABLE padarias ADD COLUMN nfce_proximo_numero INT NOT NULL DEFAULT 1",
      "ALTER TABLE padarias ADD COLUMN nfce_ambiente TINYINT NOT NULL DEFAULT 2 COMMENT '1=Produção, 2=Homologação (teste)'",
      "ALTER TABLE padarias ADD COLUMN nfce_certificado_arquivo VARCHAR(255) NULL COMMENT 'nome do arquivo .pfx dentro da pasta certificados/, nunca o caminho completo nem senha'",
      "ALTER TABLE padarias ADD COLUMN nfce_certificado_senha_criptografada TEXT NULL",
      "ALTER TABLE padarias ADD COLUMN nfce_ativo TINYINT(1) NOT NULL DEFAULT 0",
      // CSC (Código de Segurança do Contribuinte) — token separado do certificado, gerado
      // no Portal da Sefaz-SP, usado só pra montar o QR Code da NFC-e.
      "ALTER TABLE padarias ADD COLUMN nfce_csc VARCHAR(255) NULL", // valor criptografado é maior que o original
      "ALTER TABLE padarias ADD COLUMN nfce_id_csc INT NULL",

      `CREATE TABLE IF NOT EXISTS notas_fiscais (
        id                  INT AUTO_INCREMENT PRIMARY KEY,
        padaria_id          INT NOT NULL,
        comanda_id          INT NULL,
        numero              INT NOT NULL,
        serie               INT NOT NULL,
        chave_acesso        VARCHAR(44) NULL,
        status              ENUM('pendente','autorizada','rejeitada','cancelada','contingencia','erro') NOT NULL DEFAULT 'pendente',
        ambiente            TINYINT NOT NULL COMMENT '1=Produção, 2=Homologação',
        valor_total         DECIMAL(10,2) NOT NULL DEFAULT 0,
        xml_assinado        MEDIUMTEXT NULL,
        protocolo_autorizacao VARCHAR(20) NULL,
        motivo_rejeicao     VARCHAR(255) NULL,
        criado_em           DATETIME DEFAULT CURRENT_TIMESTAMP,
        autorizada_em       DATETIME NULL,
        INDEX idx_notas_padaria (padaria_id, status),
        INDEX idx_notas_comanda (comanda_id)
      )`,

      // "arquivada" — pra "esconder" da lista de notas pendentes uma nota antiga de
      // homologação (teste) que nunca vai valer nada de verdade, sem apagar o histórico.
      "ALTER TABLE notas_fiscais MODIFY COLUMN status ENUM('pendente','autorizada','rejeitada','cancelada','contingencia','erro','arquivada') NOT NULL DEFAULT 'pendente'",

      // Fechamento de caixa por forma de pagamento — antes só conferia o dinheiro
      // da gaveta; agora a atendente digita o que contou/bateu de cada forma
      // (crédito, débito, pix...) e o sistema guarda pra comparar com o que foi
      // lançado nas vendas (JSON: { "Dinheiro": 260.00, "Crédito": 513.50, ... }).
      'ALTER TABLE caixas ADD COLUMN fechamento_formas TEXT NULL',

      // ── Cadastro de funcionário (RH) ──────────────────────────────────
      // "gestor" é um atributo separado do "role" (atendente/caixa/gerente) — o role
      // controla o que a pessoa pode fazer no caixa (cancelar comanda, etc.), o gestor
      // controla quem pode mexer na tela de Equipe (cadastrar gente, ver dado sensível).
      // Uma pessoa pode ser as duas coisas, só uma delas, ou nenhuma.
      'ALTER TABLE atendentes ADD COLUMN gestor TINYINT(1) NOT NULL DEFAULT 0',
      // Dados básicos — qualquer um com acesso à tela de Equipe pode ver.
      'ALTER TABLE atendentes ADD COLUMN telefone VARCHAR(20) NULL',
      'ALTER TABLE atendentes ADD COLUMN email VARCHAR(120) NULL',
      'ALTER TABLE atendentes ADD COLUMN cargo VARCHAR(80) NULL',
      'ALTER TABLE atendentes ADD COLUMN data_admissao DATE NULL',
      // Dados sensíveis (CPF, dado bancário, salário...) — só aparecem pra quem é
      // dono ou gestor; o resto de quem acessa Equipe nem recebe esses campos na API.
      'ALTER TABLE atendentes ADD COLUMN cpf VARCHAR(14) NULL',
      'ALTER TABLE atendentes ADD COLUMN rg VARCHAR(20) NULL',
      'ALTER TABLE atendentes ADD COLUMN data_nascimento DATE NULL',
      'ALTER TABLE atendentes ADD COLUMN endereco VARCHAR(255) NULL',
      'ALTER TABLE atendentes ADD COLUMN pix_chave VARCHAR(120) NULL',
      'ALTER TABLE atendentes ADD COLUMN dados_bancarios VARCHAR(255) NULL',
      'ALTER TABLE atendentes ADD COLUMN salario DECIMAL(10,2) NULL',
      'ALTER TABLE atendentes ADD COLUMN contato_emergencia VARCHAR(150) NULL',
      // Cadastro de clientes faturados (CNPJ/Nome/Endereço/Telefone) — identificado na hora
      // de cobrar em "Faturado", pra imprimir "Cliente:" e "Documento:" no recibo.
      `CREATE TABLE IF NOT EXISTS clientes_faturado (
        id          INT AUTO_INCREMENT PRIMARY KEY,
        padaria_id  INT NOT NULL,
        cnpj        VARCHAR(18) NOT NULL,
        nome        VARCHAR(150) NOT NULL,
        endereco    VARCHAR(255) NULL,
        telefone    VARCHAR(20) NULL,
        criado_em   DATETIME DEFAULT CURRENT_TIMESTAMP,
        UNIQUE KEY uq_cliente_faturado_cnpj (padaria_id, cnpj),
        INDEX idx_clientes_faturado_padaria (padaria_id)
      )`,
      'ALTER TABLE comandas ADD COLUMN cliente_nome VARCHAR(150) NULL',
      'ALTER TABLE comandas ADD COLUMN cliente_documento VARCHAR(18) NULL',
      // Despesas do caixa, lançadas pela atendente na hora de fechar (dinheiro que saiu
      // da gaveta, com o motivo detalhado) — usa a mesma tabela de sangria/suprimento.
      "ALTER TABLE caixa_movimentos MODIFY COLUMN tipo ENUM('sangria','suprimento','despesa') NOT NULL",
      // Clientes faturado agora também podem ser funcionários (CPF, com limite de R$500
      // de saldo) além de empresas (CNPJ, sem limite). "cnpj" guarda CNPJ ou CPF, conforme
      // o tipo — nome mantido por compatibilidade, sem quebrar o que já existia.
      "ALTER TABLE clientes_faturado ADD COLUMN tipo ENUM('empresa','funcionario') NOT NULL DEFAULT 'empresa'",
      'ALTER TABLE clientes_faturado ADD COLUMN limite DECIMAL(10,2) NULL',
      // Cada pagamento em "Faturado" agora carrega o próprio cliente e se já foi quitado —
      // é daqui que sai o saldo devedor (soma dos não quitados) pra travar no limite de R$500.
      'ALTER TABLE comanda_pagamentos ADD COLUMN cliente_documento VARCHAR(18) NULL',
      'ALTER TABLE comanda_pagamentos ADD COLUMN cliente_nome VARCHAR(150) NULL',
      'ALTER TABLE comanda_pagamentos ADD COLUMN quitado_em DATETIME NULL',
      // CPF do cliente na nota fiscal (opcional, digitado na hora, sem cadastro nenhum) —
      // diferente do Faturado, é só informativo pra Sefaz, não tem limite/saldo.
      'ALTER TABLE comandas ADD COLUMN cpf_nota VARCHAR(14) NULL',
      // Email da contabilidade — recebe o zip com os XMLs das NFC-e do mês, enviado
      // automaticamente todo dia 1º. Fica em branco até o dono configurar.
      'ALTER TABLE padarias ADD COLUMN email_contabilidade VARCHAR(120) NULL',
    ];
    await Promise.all(migrations.map(sql => db.query(sql).catch(() => {})));

    await db.query(`
      DELETE FROM categorias
      WHERE nome IN ('Gorduras','Farinhas','Ovos','Açúcares','Acucares')
        AND id NOT IN (SELECT DISTINCT categoria_id FROM produtos WHERE categoria_id IS NOT NULL)
    `).catch(() => {});

    await db.query(`
      DELETE FROM produtos
      WHERE ativo = 0
        AND id NOT IN (SELECT DISTINCT produto_id FROM movimentacoes WHERE produto_id IS NOT NULL)
        AND id NOT IN (SELECT DISTINCT produto_id FROM itens_pedido WHERE produto_id IS NOT NULL)
    `).catch(() => {});

    await db.query(`
      DELETE FROM pedidos_compra
      WHERE status = 'cancelado'
        AND id NOT IN (SELECT DISTINCT pedido_id FROM itens_pedido)
    `).catch(() => {});

    const adminEmail = process.env.ADMIN_EMAIL;
    const adminSenha = process.env.ADMIN_SENHA;
    if (adminEmail && adminSenha) {
      const bcrypt = require('bcryptjs');
      const [existe] = await db.query('SELECT id FROM padarias WHERE email = ?', [adminEmail]).catch(() => [[]]);
      if (!existe.length) {
        const hash = await bcrypt.hash(adminSenha, 10);
        await db.query(
          "INSERT INTO padarias (nome, email, senha_hash, role, plano) VALUES ('Admin PanificaPro', ?, ?, 'admin', 'premium')",
          [adminEmail, hash]
        ).catch(() => {});
        console.log('✅ Conta admin criada.');
      } else {
        await db.query("UPDATE padarias SET role = 'admin' WHERE email = ?", [adminEmail]).catch(() => {});
      }
    }
    console.log('✅ Migrations verificadas.');
  } catch (e) {
    console.error('Erro na migration automática:', e.message);
  }
})();

require('./jobs/relatorioDiario').iniciarJobRelatorioDiario();
require('./jobs/relatorioContabilMensal').iniciarJobRelatorioContabilMensal();

app.use('/api', require('./routes'));

app.get('/api/health', (_, res) => res.json({ ok: true, versao: '1.0.0' }));

// Vue app fallback (hash routing — /app/* serves the Vue index)
app.get('/app', (_, res) => res.sendFile(path.join(__dirname, '../public/app/index.html')));

// Legacy SPA fallback
app.get('*', (_, res) => res.sendFile(path.join(__dirname, '../public/index.html')));

// Tratamento global de erros
app.use((err, req, res, _next) => {
  console.error(err);
  res.status(500).json({ erro: 'Erro interno do servidor.' });
});

app.listen(PORT, () => console.log(`🥖 PanificaPro rodando em http://localhost:${PORT}`));
