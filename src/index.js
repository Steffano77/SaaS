require('dotenv').config();
const express   = require('express');
const cors      = require('cors');
const helmet    = require('helmet');
const rateLimit = require('express-rate-limit');
const path      = require('path');
const fs        = require('fs');

const app  = express();
const PORT = process.env.PORT || 3000;

// Garante pasta de upload
fs.mkdirSync('/tmp/panificapro', { recursive: true });

// Segurança: cabeçalhos HTTP
app.use(helmet({ contentSecurityPolicy: false }));

// CORS restrito
app.use(cors({ origin: true, credentials: true }));

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

app.use(express.json({ limit: '5mb' }));
app.use(express.static(path.join(__dirname, '../public')));

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
