# PanificaPro — Guia de Manutenção

Este documento existe para que qualquer desenvolvedor (não só quem já trabalhou no
projeto) consiga entender a arquitetura, rodar o sistema localmente, fazer deploy
e dar manutenção sem depender de contexto que só existe na cabeça de quem construiu.

Não contém nenhuma senha ou token — só indica onde cada credencial está guardada.

---

## 1. Visão geral

PanificaPro é um ERP SaaS multi-tenant para padarias: controle de estoque,
compras, fornecedores, fichas técnicas, produção, financeiro, relatórios,
**PDV/comandas com caixa**, **sistema de cargos com PIN** (atendente/caixa/
gerente) e **emissão de Nota Fiscal de Consumidor Eletrônica (NFC-e)** de
verdade, integrada à Sefaz-SP.

- **Backend:** Node.js + Express (API REST)
- **Banco de dados:** MySQL 8
- **Frontend:** HTML/CSS/JS puro (SPA sem framework), servido como arquivos estáticos
  pelo próprio Express
- **Autenticação:** JWT + bcrypt (login de dono da padaria) + um segundo
  esquema de JWT próprio pra PIN de funcionário (ver §7)
- **Hospedagem:** VPS Hostgator, Nginx (proxy reverso + SSL) e PM2
  (gerenciador de processo). App em produção: `app.panificapro.com.br`.
  Existe também um site institucional separado em `panificapro.com.br`.
- **E-mails transacionais:** Resend
- **Pagamentos (assinatura do SaaS):** Hotmart (única forma de venda hoje, via webhook)
- **Nota fiscal:** assinatura XML própria (`xml-crypto`), certificado A1
  (`node-forge`), envio direto pro webservice da Sefaz-SP (ver §8)

Cada padaria cadastrada é uma linha na tabela `padarias` — o `padaria_id` é o
identificador de tenant usado em quase todas as tabelas para isolar os dados
de cada cliente.

**Branch de trabalho:** o desenvolvimento recente rodou na branch
`claude/affectionate-galileo-fot0op`, não em `main` — confirme qual branch
está de fato em produção antes de assumir (`git -C /var/www/panificapro branch --show-current`
no servidor).

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
cp .env.example .env    # depois preencher com valores reais (ver §10)
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
ssh root@<ip-do-vps> -p <porta>   # credenciais: ver §10
cd /var/www/panificapro
git pull origin claude/affectionate-galileo-fot0op   # confirme a branch certa antes (ver §1)
npm install                        # só é preciso quando package.json mudou
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

## 7. PDV: Comandas, Caixa e Cargos (Equipe)

Módulo de ponto de venda usado no balcão da padaria. Telas principais em
`public/index.html` (`#pg-comandas`) e lógica em `public/js/app.js`
(procure por `comandaAtualId`, `caixaAtualCache`).

- **Comanda** (`comandas` + `itens_comanda`) — pode ser aberta por número
  (mesa/comanda física) ou direto como "venda de balcão" (invisível pro
  operador, criada na hora). Fecha com `POST /comandas/:id/fechar`, que
  roda tudo dentro de uma **transação de banco** (pagamentos + baixa de
  estoque + lançamento no financeiro + status da comanda) — não tirar essa
  transação; sem ela, um erro no meio do processo já causou duplicação real
  de dados em produção antes (`comandaController.fechar`).
- **Formas de pagamento**: Dinheiro, Crédito, Débito, Pix, Voucher, e duas
  formas especiais:
  - **Faturado** (fiado) — conta como venda normal, mas o lançamento no
    financeiro fica marcado com categoria `Fiado (a receber)` em vez de
    `Vendas`, pra não se misturar com dinheiro que já entrou de fato. Não
    existe hoje uma tela de controle de "quem deve quanto" — só essa
    marcação no financeiro.
  - **Padaria** (consumo interno/produção) — desconta estoque normalmente,
    mas **não gera lançamento nenhum no financeiro** (não é receita) e o
    sistema **não oferece a opção de emitir nota fiscal** nesse caso (não
    houve venda de verdade).
- **Caixa** (`caixas` + `caixa_movimentos`) — pode haver mais de um caixa
  aberto ao mesmo tempo na mesma padaria (um por aparelho/tablet), todos
  puxando do mesmo estoque/comandas. Fechamento gera um comprovante
  impresso no formato "relatório completo de sessão" (`imprimirFechamentoCaixa`
  em `app.js`), no mesmo padrão que sistemas de balcão tipo Saurus usam —
  forma de pagamento com contagem, resumo de movimentação, comparação
  "em caixa vs fechado vs diferença". Só Dinheiro tem contagem física real;
  as outras formas usam o valor do sistema como "fechado" (diferença sempre 0).
- **Cargos / PIN de funcionário**: tabela `atendentes` tem uma coluna
  `role` (`atendente` / `caixa` / `gerente`). Login de funcionário é
  **separado** do login de dono de padaria — `POST /atendentes/login` emite
  um JWT próprio (`tipo: 'atendente'`, 12h) guardado em `sessionStorage`
  (`func_token`), verificado pelo middleware `exigirFuncionario([...papeis])`.
  Usado pra travar ações sensíveis (excluir comanda, ver relatório de vendas,
  cancelar item) atrás de PIN de gerente. Por padrão o token é esquecido
  logo depois da ação (`comLoginAtendente(fn, limparDepois=true)`); telas
  que fazem várias ações seguidas (Histórico, Relatório) passam
  `limparDepois=false` pra não pedir PIN de novo a cada clique dentro da
  mesma tela — **isso já causou um bug real** (trocar de período no
  relatório silenciosamente não atualizava nada, porque o token já tinha
  sido apagado); se telas parecidas passarem a fazer requisição sob
  demanda depois da autenticação inicial, confirme que `limparDepois:false`
  está sendo usado.

## 8. Nota Fiscal (NFC-e) — Sefaz-SP

Fica em `src/fiscal/` (montagem/assinatura do XML) e
`src/controllers/nfceController.js` / `fiscalController.js` (fluxo de
emissão, configuração, reimpressão).

- **Ambientes**: `padarias.nfce_ambiente` (2 = homologação/teste,
  1 = produção). **Hoje está em homologação** — notas emitidas não valem
  legalmente, servem só pra validar que o XML está correto perante a
  Sefaz. A troca pra produção é uma decisão de negócio, não técnica —
  depende de aval do contador sobre as regras fiscais e confirmação final
  do dono, não trocar sozinho.
- **CSC (Código de Segurança do Contribuinte)**: homologação e produção
  usam **colunas separadas** no banco (`nfce_csc`/`nfce_id_csc` para
  homologação, `nfce_csc_producao`/`nfce_id_csc_producao` para produção) —
  de propósito, pra configurar um não sobrescrever o outro. Nunca unificar
  essas colunas.
- **CFOP/CSOSN automáticos por produto** (`src/fiscal/xmlNFCe.js`,
  função `definirCfop`/`montarBlocoIcms`): decide o código fiscal certo
  olhando duas colunas do produto — `origem_producao` (`propria`/`revenda`)
  e `situacao_icms` (`normal`/`st`/`isento`):
  - Própria → CFOP 5101, CSOSN 102
  - Revenda normal → CFOP 5102, CSOSN 102
  - Revenda com Substituição Tributária → CFOP 5405, CSOSN 500 (+ CEST)
  - Isento → CSOSN 400 — **atenção**: no schema oficial da Sefaz não existe
    um grupo `<ICMSSN400>` separado; CSOSN 400 reaproveita o grupo
    `<ICMSSN102>`, só troca o número do CSOSN por dentro. Um XML com
    `<ICMSSN400>` inventado já causou rejeição real (cStat 225) — não
    reintroduzir esse erro.
  - Pagamento em cartão (crédito/débito) e Pix **exigem** o bloco `<card>`
    no XML (rejeição real da Sefaz-SP, cStat 391, se faltar) — a condição
    em `xmlNFCe.js` cobre `tPag === '03' || '04' || '17'`.
- **NCM**: coluna `produtos.ncm`, usada no XML com fallback pro código
  genérico `21069090` se o produto não tiver NCM cadastrado.
- **Reimpressão** (`nfceController.imprimirDanfe`) gera o HTML do recibo
  térmico com QR Code (pacote `qrcode`), usando o CSC do ambiente em que a
  nota foi **realmente emitida** (`nota.ambiente`), não o ambiente atual da
  padaria — importante se um dia a padaria migrar pra produção e ainda
  precisar reimprimir notas antigas de teste.

## 9. Exportação de produtos pra balança (Gerenciador de Balanças Triunfo)

Botão "Exportar p/ balança" na tela de Estoque (`exportarParaBalanca` em
`app.js`) gera um arquivo `cadtxt.txt` no formato **"Padrão Smart Filizola"**
— um layout de largura fixa, sem separador, usado por vários fabricantes de
balança no Brasil (não só Triunfo). **Esse layout não está documentado
oficialmente em lugar nenhum acessível** — foi descoberto na prática,
analisando um arquivo real exportado por uma balança Triunfo. Cada linha
tem exatamente 39 caracteres:

```
código(6, zero à esquerda) + tipo(1: P=peso/U=unidade)
  + descrição(22, sem acento, cortada/completada com espaço)
  + preço(7, 2 casas decimais implícitas, zero à esquerda)
  + validade em dias(3, zero à esquerda — sempre "000" hoje)
```

Só entram no arquivo produtos com `codigo_balanca` numérico preenchido **e**
`preco_venda > 0` (produto sem preço fica de fora, com aviso no console, em
vez de exportar como R$ 0,00). O campo `codigo_balanca` pode ser
auto-preenchido (fórmula `código de barras curto × 100`) ao digitar o
código de barras no cadastro do produto — só quando o campo da balança
ainda está vazio, edição manual sempre tem prioridade.

## 10. Onde estão as credenciais

Nenhuma credencial fica neste repositório. Estão guardadas num documento
privado no Google Drive do proprietário (Estefano Mello), acessível somente
por ele. Se for necessário dar acesso a um novo desenvolvedor, é o
proprietário quem compartilha o documento diretamente pelo Google Drive.

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
ADMIN_EMAIL, ADMIN_SENHA, PIN_FINANCEIRO_MASTER, FISCAL_ENC_KEY
```

`ALLOWED_ORIGINS` precisa incluir `https://app.panificapro.com.br` (não só
o domínio institucional sem `app.`) — um valor desatualizado aqui não quebra
nada visivelmente hoje (o app serve frontend e API do mesmo domínio, então
o navegador nem aplica a checagem de CORS pra isso), mas trava qualquer
integração futura vinda de outro domínio.

`FISCAL_ENC_KEY` criptografa (AES-256-GCM) a senha do certificado digital e
o CSC no banco — nunca fica em texto puro em `padarias`. Trocar essa chave
sem migrar os dados já criptografados invalida tudo que foi salvo com a
chave antiga.

---

## 11. Ausência de testes automatizados

Não há suite de testes. Qualquer alteração precisa ser validada manualmente
no navegador (fluxos principais: login, estoque, compras, financeiro,
relatórios) antes do deploy. Ao contratar manutenção, vale considerar pedir
que testes básicos (ao menos smoke tests de rotas críticas) sejam
adicionados com o tempo.
