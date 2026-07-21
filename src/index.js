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
app.use(helmet({ contentSecurityPolicy: false }));

// CORS restrito ao domínio de produção
const ALLOWED_ORIGINS = (process.env.ALLOWED_ORIGINS || 'https://panificapro-erp.onrender.com')
  .split(',').map(o => o.trim());
app.use(cors({
  origin: (origin, cb) => {
    // Permite requisições sem origin (apps nativos, curl, Postman)
    if (!origin || ALLOWED_ORIGINS.includes(origin)) return cb(null, true);
    cb(new Error('Origem não permitida pelo CORS'));
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

app.use(express.json({ limit: '5mb' }));
app.use(express.static(path.join(__dirname, '../public')));

// Auto-migrate: adiciona colunas novas sem quebrar instâncias existentes
(async () => {
  try {
    const db = require('./database/connection');
    // Cada coluna individualmente — ignora erro se já existir
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
        usado TINYINT(1) NOT NULL DEFAULT 0,
        padaria_id INT NULL,
        criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        usado_em DATETIME NULL
      )`,
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
      // Expande ENUM de planos para incluir essencial e premium (Hotmart)
      "ALTER TABLE padarias MODIFY COLUMN plano ENUM('trial','basico','essencial','pro','premium') DEFAULT 'trial'",
      `CREATE TABLE IF NOT EXISTS fichas_tecnicas (
        id INT AUTO_INCREMENT PRIMARY KEY,
        padaria_id INT NOT NULL,
        nome VARCHAR(200) NOT NULL,
        descricao TEXT NULL,
        rendimento FLOAT NOT NULL DEFAULT 1,
        unidade_rendimento VARCHAR(30) NOT NULL DEFAULT 'unidades',
        preco_venda FLOAT NULL,
        ativo TINYINT(1) NOT NULL DEFAULT 1,
        criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
      )`,
      `CREATE TABLE IF NOT EXISTS itens_ficha (
        id INT AUTO_INCREMENT PRIMARY KEY,
        ficha_id INT NOT NULL,
        produto_id INT NOT NULL,
        quantidade FLOAT NOT NULL,
        unidade VARCHAR(30) NOT NULL DEFAULT 'un'
      )`,
      'ALTER TABLE fichas_tecnicas ADD COLUMN descricao TEXT NULL',
      `CREATE TABLE IF NOT EXISTS config_precificacao (
        id INT AUTO_INCREMENT PRIMARY KEY,
        padaria_id INT NOT NULL UNIQUE,
        faturamento_medio FLOAT NOT NULL DEFAULT 0,
        imposto_pct FLOAT NOT NULL DEFAULT 5,
        perda_pct FLOAT NOT NULL DEFAULT 2,
        lucro_desejado_pct FLOAT NOT NULL DEFAULT 10
      )`,
      `CREATE TABLE IF NOT EXISTS despesas_fixas_config (
        id INT AUTO_INCREMENT PRIMARY KEY,
        padaria_id INT NOT NULL,
        nome VARCHAR(100) NOT NULL,
        valor FLOAT NOT NULL DEFAULT 0,
        ordem INT NOT NULL DEFAULT 0
      )`,
      `CREATE TABLE IF NOT EXISTS modalidades_pagamento (
        id INT AUTO_INCREMENT PRIMARY KEY,
        padaria_id INT NOT NULL,
        nome VARCHAR(50) NOT NULL,
        taxa_pct FLOAT NOT NULL DEFAULT 0,
        participacao_pct FLOAT NOT NULL DEFAULT 0
      )`,
      `CREATE TABLE IF NOT EXISTS producao_diaria (
        id INT AUTO_INCREMENT PRIMARY KEY,
        padaria_id INT NOT NULL,
        data DATE NOT NULL,
        observacao TEXT NULL,
        criado_em DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
      )`,
      `CREATE TABLE IF NOT EXISTS itens_producao (
        id INT AUTO_INCREMENT PRIMARY KEY,
        producao_id INT NOT NULL,
        ficha_id INT NOT NULL,
        quantidade FLOAT NOT NULL DEFAULT 1,
        descontou_estoque TINYINT(1) NOT NULL DEFAULT 0
      )`,
    ];
    await Promise.all(migrations.map(sql => db.query(sql).catch(() => {})));

    // Remove categorias padrão indesejadas (criadas automaticamente)
    await db.query(`
      DELETE FROM categorias
      WHERE nome IN ('Gorduras','Farinhas','Ovos','Açúcares','Acucares')
        AND id NOT IN (SELECT DISTINCT categoria_id FROM produtos WHERE categoria_id IS NOT NULL)
    `).catch(() => {});

    // Remove produtos inativos sem movimentações (duplicatas de teste)
    await db.query(`
      DELETE FROM produtos
      WHERE ativo = 0
        AND id NOT IN (SELECT DISTINCT produto_id FROM movimentacoes WHERE produto_id IS NOT NULL)
        AND id NOT IN (SELECT DISTINCT produto_id FROM itens_pedido WHERE produto_id IS NOT NULL)
    `).catch(() => {});

    // Remove pedidos cancelados sem itens (pedidos de teste vazios)
    await db.query(`
      DELETE FROM pedidos_compra
      WHERE status = 'cancelado'
        AND id NOT IN (SELECT DISTINCT pedido_id FROM itens_pedido)
    `).catch(() => {});

    // Cria conta admin automaticamente se não existir
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

app.use('/api', require('./routes'));

app.get('/api/health', (_, res) => res.json({ ok: true, versao: '1.0.0' }));

// SPA fallback
app.get('*', (_, res) => res.sendFile(path.join(__dirname, '../public/index.html')));

// Tratamento global de erros — nunca vaza stack trace para o cliente
app.use((err, req, res, _next) => {
  console.error(err);
  res.status(500).json({ erro: 'Erro interno do servidor.' });
});

app.listen(PORT, () => console.log(`🥖 PanificaPro rodando em http://localhost:${PORT}`));
