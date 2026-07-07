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
    await db.query(`
      ALTER TABLE produtos
        ADD COLUMN IF NOT EXISTS fornecedor_id INT NULL,
        ADD COLUMN IF NOT EXISTS reset_token VARCHAR(512) NULL,
        ADD COLUMN IF NOT EXISTS reset_expires DATETIME NULL
    `).catch(() => {
      // MySQL < 8 não suporta IF NOT EXISTS no ALTER — tenta coluna por coluna
      const cols = [
        'ALTER TABLE produtos ADD COLUMN fornecedor_id INT NULL',
        'ALTER TABLE padarias ADD COLUMN reset_token VARCHAR(512) NULL',
        'ALTER TABLE padarias ADD COLUMN reset_expires DATETIME NULL',
        "ALTER TABLE padarias ADD COLUMN role VARCHAR(20) NOT NULL DEFAULT 'user'",
      ];
      return Promise.all(cols.map(sql => db.query(sql).catch(() => {})));
    });
    // Define admin pelo email configurado
    const adminEmail = process.env.ADMIN_EMAIL;
    if (adminEmail) {
      await db.query("UPDATE padarias SET role = 'admin' WHERE email = ?", [adminEmail]).catch(() => {});
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
