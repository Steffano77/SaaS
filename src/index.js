require('dotenv').config();
const express   = require('express');
const cors      = require('cors');
const helmet    = require('helmet');
const rateLimit = require('express-rate-limit');
const path      = require('path');
const fs        = require('fs');

const app  = express();
const PORT = process.env.PORT || 3000;

// Necessário no Render (e qualquer proxy reverso) para o rate limit funcionar corretamente
app.set('trust proxy', 1);

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

app.use(express.json({ limit: '512kb' }));
app.use(express.static(path.join(__dirname, '../public')));

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
