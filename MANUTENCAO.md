# PanificaPro — Guia de Manutenção

Este documento existe para que qualquer desenvolvedor (não só quem já trabalhou no
projeto) consiga entender a arquitetura, rodar o sistema localmente, fazer deploy
e dar manutenção sem depender de contexto que só existe na cabeça de quem construiu.

Não contém nenhuma senha ou token — só indica onde cada credencial está guardada.

---

## 1. Visão geral

PanificaPro é um ERP SaaS multi-tenant para padarias (controle de estoque,
compras, fornecedores, fichas técnicas, produção, financeiro e relatórios).

- **Backend:** Node.js + Express (API REST)
- **Banco de dados:** MySQL 8
- **Frontend:** HTML/CSS/JS puro (SPA sem framework), servido como arquivos estáticos
  pelo próprio Express
- **Autenticação:** JWT + bcrypt
- **Hospedagem:** VPS com Nginx (proxy reverso + SSL) e PM2 (gerenciador de processo)
- **E-mails transacionais:** Resend
- **Pagamentos:** Hotmart (única forma de venda hoje, via webhook)

Cada padaria cadastrada é uma linha na tabela `padarias` — o `padaria_id` é o
identificador de tenant usado em quase todas as tabelas para isolar os dados
de cada cliente.

---

## 2. Estrutura de pastas

```
src/
  index.js                 → bootstrap do Express, CSP/Helmet, migrações automáticas
  database/connection.js   → pool de conexão MySQL
  middleware/
    auth.js                → valida o JWT, carrega req.padaria
    authAdmin.js            → exige role = admin
  controllers/              → lógica de negócio, um arquivo por domínio
  routes/
    index.js                → ⚠️ ÚNICO arquivo de rotas realmente montado (ver §5)

public/
  index.html                → app inteiro (SPA) — todas as "páginas" são <section> escondidas/mostradas via JS
  js/app.js                 → toda a lógica de frontend (~4.100 linhas, um arquivo só)
  css/app.css
  site/index.html           → site institucional (landing page), separado do app
```

---

## 3. Rodando localmente

```bash
git clone <repo>
cd SaaS
npm install
cp .env.example .env    # depois preencher com valores reais (ver §7)
npm run dev              # nodemon, reinicia sozinho a cada mudança
```

Acesse `http://localhost:3000`. Não precisa de build step no frontend — os
arquivos em `public/` são servidos diretamente.

Banco: precisa de um MySQL acessível (local ou remoto) com as credenciais do
`.env`. **Não é necessário criar as tabelas manualmente** — `src/index.js` roda
uma lista de migrações (`CREATE TABLE IF NOT EXISTS` / `ALTER TABLE ... ADD COLUMN`)
toda vez que o servidor sobe. Isso inclui criar o schema do zero num banco vazio.

---

## 4. Deploy (produção)

O deploy é manual, sem CI/CD:

```bash
ssh root@<ip-do-vps> -p <porta>   # credenciais: ver §7
cd /var/www/panificapro
git pull origin main
pm2 restart panificapro --update-env
```

- `git pull` traz o código novo
- `pm2 restart ... --update-env` reinicia o processo Node e recarrega o `.env`
  (o `--update-env` é importante sempre que uma variável de ambiente mudar)
- As migrações de banco rodam sozinhas no boot (ver §3) — normalmente não é
  preciso alterar o banco manualmente antes do deploy

**Atenção:** as migrações em `src/index.js` engolem erro silenciosamente
(`.catch(() => {})`), de propósito, para uma coluna já existente não derrubar
o boot. Isso também significa que um erro de sintaxe numa migração nova passa
batido sem aviso — depois de mexer nas migrações, sempre confirme manualmente
que a alteração foi aplicada (`SHOW COLUMNS FROM tabela`) antes de dar como
concluído.

Verificar se o app subiu:
```bash
pm2 list                 # status "online"
pm2 logs panificapro      # ver logs em tempo real / erros
```

### Cache do frontend

`public/index.html` referencia `app.js` com uma query string de versão fixa
(`/js/app.js?v=YYYYMMDDx`). **Essa versão não muda sozinha.** Sempre que
`app.js` for alterado, é preciso bumpar esse valor manualmente no `index.html`
— senão navegadores (e possíveis CDNs) continuam servindo a versão em cache e
a alteração "não aparece" mesmo com o deploy feito corretamente.

---

## 5. Pegadinha importante: rotas mortas

Existem estes arquivos em `src/routes/` que **não são usados**:
`admin.js`, `auth.js`, `categorias.js`, `compras.js`, `exportar.js`,
`fornecedores.js`, `relatorios.js`, `saidas.js`.

Só `src/routes/index.js` é montado (`app.use('/api', require('./routes'))`
em `src/index.js`). Os outros arquivos têm versões antigas/duplicadas de
rotas que hoje vivem dentro de `routes/index.js` mesmo.

Isso é uma armadilha real: se alguém abrir `src/routes/admin.js` para editar
uma rota de admin, a alteração não terá efeito nenhum, porque o arquivo
nunca é carregado. **Antes de editar qualquer rota, confirme que está mexendo
em `routes/index.js`.**

Recomendação: apagar esses arquivos mortos numa limpeza futura, para eliminar
esse risco de vez.

---

## 6. Conceitos de negócio que não são óbvios lendo o código

- **Planos:** `trial`, `essencial`, `pro`, `premium` (coluna `padarias.plano`).
  Middlewares `authPro` (Pro ou Premium) e `authPremium` (só Premium) protegem
  rotas por plano. Hoje: Relatórios e Fichas Técnicas exigem Pro; Produção e
  Financeiro exigem Premium.
- **Expiração de plano:** `padarias.plano_expira_em`. Verificado no
  `middleware/auth.js` a cada requisição — se a data passou, a conta é bloqueada
  até alguém renovar manualmente pelo painel admin (`/admin/padarias/:id/renovar`).
  **Não existe cobrança recorrente própria** — quem gerencia a renovação
  automática hoje é o webhook da Hotmart (`hotmartController.js`).
- **Códigos de ativação** (`codigos_ativacao`): forma alternativa de criar
  conta sem passar pela Hotmart, usada para trials e vendas manuais. Cada
  código define plano + duração (em dias OU em meses — dias tem prioridade).
  Gerados/gerenciados na aba "Códigos" do painel admin.
- **PIN financeiro:** módulo Financeiro tem um PIN (hash bcrypt em
  `padarias.pin_financeiro`) para acesso extra de segurança. Existe um PIN
  mestre de admin via variável de ambiente `PIN_FINANCEIRO_MASTER` — serve
  para destravar em suporte, sem precisar saber o PIN do cliente.
- **Importação Saurus:** módulo de sincronização de estoque a partir de
  planilha exportada do sistema Saurus Retaguarda. Importante: a lógica
  **nunca zera produtos que não aparecem na planilha** — só atualiza os
  itens explicitamente presentes no arquivo. Isso foi corrigido depois de
  um incidente real de perda de dados de estoque; não reintroduzir uma
  lógica de "zerar ausentes" sem entender esse histórico.

---

## 7. Onde estão as credenciais

Nenhuma credencial fica neste repositório. Local: **[preencher — ex: 1Password / Bitwarden, pasta "PanificaPro"]**.

O que precisa estar guardado lá:

| Credencial | Para que serve |
|---|---|
| Acesso SSH do VPS (IP, usuário, senha/porta) | Deploy e manutenção do servidor |
| Senha root do MySQL | Consultas e correções diretas no banco |
| `.env` de produção completo (todas as chaves abaixo) | Configuração da aplicação |
| Login da Hotmart | Gerenciar produtos, preços, webhook |
| Login do Resend | E-mails transacionais (reset de senha, reset de PIN) |
| Acesso ao domínio/DNS (registrador) | `panificapro.com.br` e `app.panificapro.com.br` |
| Acesso ao GitHub (`Steffano77/SaaS`) | Código-fonte |

Variáveis de ambiente usadas pela aplicação (ver `.env.example` para o
template atualizado):

```
PORT, DB_HOST, DB_PORT, DB_USER, DB_PASS, DB_NAME, JWT_SECRET,
HOTMART_HOTTOK, RESEND_API_KEY, EMAIL_FROM, APP_URL, ALLOWED_ORIGINS,
ADMIN_EMAIL, ADMIN_SENHA, PIN_FINANCEIRO_MASTER
```

---

## 8. Ausência de testes automatizados

Não há suite de testes. Qualquer alteração precisa ser validada manualmente
no navegador (fluxos principais: login, estoque, compras, financeiro,
relatórios) antes do deploy. Ao contratar manutenção, vale considerar pedir
que testes básicos (ao menos smoke tests de rotas críticas) sejam
adicionados com o tempo.
