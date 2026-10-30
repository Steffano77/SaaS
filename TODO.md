# Pendências / projetos futuros

Itens discutidos e aprovados pelo Estefano pra fazer depois, sem pressa.

## Servidor da Jota 2: Windows Update pendente (fazer com a loja fechada)

Conferido em 29/10: backup local a cada 6h funcionando (salva em C:\panificapro\backups
e manda por e-mail). O "mysql.exe quebrado" era só não estar no PATH — não precisa
consertar, consultas manuais vão por `node -e` com src/database/connection.
Windows Update feito em 29/10 à noite. Depois do reinício o PM2 NÃO subiu sozinho
(lista vazia) — resolvido na hora com `pm2 resurrect`. Pra não repetir:
- `pm2 save` feito (C:\Users\Home\.pm2\dump.pm2);
- tarefa agendada "PanificaPro - iniciar": no login do Home, espera 30s e roda
  C:\Users\Home\AppData\Roaming\npm\pm2.cmd resurrect;
- login automático do Home pelo netplwiz (precisou do reg PasswordLess\Device
  DevicePasswordLessBuildVersion=0 pra caixinha aparecer);
- HopToDesk instalado como serviço AUTO_START (volta antes do login).
Testado em 30/10: reiniciou, entrou sozinho e o panificapro-local subiu online sem ninguém mexer.
Tarefa "PanificaPro - abrir caixa" (Chrome --kiosk-printing --app, 1 min depois do login;
no Caixa 1, 2 min com /ru "Jota 2") pra tela do caixa abrir sozinha.
Fazer o mesmo no servidor da Jota 3.

## Pontos de referência (versões aprovadas pelas operadoras)

Ver no servidor: `git tag -l "*estavel*"`. As etiquetas ficam só no servidor de
cada loja (o GitHub desta sessão não aceita etiqueta); esta lista é a cópia que
não se perde se o PC for formatado.

| Loja   | Etiqueta no servidor       | Commit  | Data       |
|--------|----------------------------|---------|------------|
| Jota 2 | jota2-estavel-2026-10-29   | aae52ff | 29/10/2026 |
| Jota 3 | jota3-estavel-2026-10-29   | b0bceb8 | 29/10/2026 |

Jota 3 (pasta C:\Users\Jota\Documents\panificapro\SaaS-claude-affectionate-galileo-fot0op):
mesmo procedimento de emergência abaixo, com a etiqueta jota3-estavel-2026-10-29.

### Jota 2 estável em 29/10/2026 = commit aae52ff

Operadora confirmou "perfeito": nota imprime direto pela janela (--kiosk-printing),
gaveta só no Dinheiro, Caixa 1 com SSD novo, tablet da copa só com comandas
numeradas, busca "saídas" no Financeiro. No servidor da Jota 2 existe a etiqueta
local `jota2-estavel-2026-10-29` (criada lá, não no GitHub).
Voltar pra esse ponto numa emergência (servidor da Jota 2):
  cd C:\panificapro
  git reset --hard jota2-estavel-2026-10-29
  pm2 restart panificapro-local --update-env
O próximo atualizar_local.bat volta pra versão mais nova da jota2-producao.

## Portal do Funcionário (intranet) — ideia, esperando o patrão (2026-10-29)

Portal pras 3 lojas (hoje 2), ~70 funcionários: mural de avisos (por loja ou
todas, com "quem leu"), holerites em PDF (cada um vê só o seu), documentos.
Desenho combinado: roda na VPS (acesso de casa), endereço da padaria e não do
PanificaPro (ex: portal.padariadojota.com.br, domínio ainda a registrar no
registro.br), login CPF + senha (cadastro separado do PIN do caixa), papel "RH"
que publica avisos/holerites sem ver vendas/caixa/financeiro. LGPD: HTTPS,
registro de quem abriu cada holerite, desligar acesso de quem sair.
Falta: conversar com o patrão; contador dizer se manda 1 PDF por funcionário
ou 1 PDF com todos; confirmar se o CPF aparece no holerite.

## Nota 6116 (Balcão C91 06:35, caixa 91, Jota 2) — conferir com a atendente

No sistema: Pix R$13,00 + Dinheiro R$28,14, recebido R$100, troco R$71,86.
Anotação à mão no papel sugere troco/forma diferentes. Se o pagamento real foi
outro, corrigir comanda_pagamentos (NÃO apagar a nota — está autorizada na Sefaz;
o sistema ainda não cancela NFC-e).

## ✅ Modo de contingência fiscal (NFC-e) — feito em 2026-10-09

Implementado: se a Sefaz não responder na emissão, sai um XML em
contingência (tpEmis=9), o DANFe já imprime pro cliente na hora, e um job
(a cada 5min) retransmite sozinho assim que a Sefaz voltar.

Ainda não testado num caso real de queda da Sefaz em produção — só
validado via código/sanidade. Se acontecer uma queda de verdade, vale
conferir se o fluxo todo funcionou como esperado.

## ✅ Fechamento de caixa não imprimia / janela travava — resolvido em 2026-10-21

Causa raiz real (confirmada com Console/F12 num PC de loja): `window.print()`
trava a aba inteira por alguns segundos em certos PCs/drivers de impressora
(print spooler lento), e o fechamento "de fora" da janela (pela janela
principal) às vezes era bloqueado pelo navegador depois disso. Corrigido
fazendo a janela se fechar sozinha de DENTRO dela mesma (script embutido no
HTML, igual o botão manual "Fechar" que sempre funcionou) + botão manual
Imprimir/Fechar como rede de segurança, caso aconteça de novo.

## ✅ Rejeições 704/865 na Balcão C57 (2026-10-21) — resolvido em 2026-10-22

Causa: item bipado no mesmo segundo da cobrança entrou na comanda já cobrada
(R$16,00 pago de R$19,29) → 865 pra sempre; o 704 veio do "Reenviar" mandando a
nota de 07:15 horas depois. Corrigido: fechar/itens com a comanda travada (FOR
UPDATE) + Reenviar recusa nota normal vencida (commit b63bea1). Comanda 5148:
Pão Francês sem pagar removido e nota reemitida/autorizada.

## ✅ Gaveta só no Dinheiro/G — resolvido em 2026-10-27 (Jota 2 e Jota 3)

Comando ESC/POS direto pelo servidor (gavetaController: grava no compartilhamento
\\PC\nome, PowerShell só de reserva), aberto ao escolher Dinheiro e no G.
.env: Jota 2 GAVETA_CAIXA_1=\\DESKTOP-98CNNAE\imp e GAVETA_CAIXA_2=\\localhost\IMP;
Jota 3 GAVETA_CAIXA_2=\\localhost\imp (o outro caixa da Jota 3 tem gaveta manual).
Driver das impressoras com gaveta em "Não abrir" (Preferências e Padrões de impressão),
então o cartão não abre mais a gaveta.

## Pra fazer em 2026-10-29

1. **Impressão silenciosa (sem janela do Chrome)** em cada PC de caixa, nas duas lojas:
   - Impressora térmica como padrão: `rundll32 printui.dll,PrintUIEntry /y /n "POS-80C"` (Jota 2 Caixa 2)
     ou `"EPSON TM-T20X Receipt"` (Jota 2 Caixa 1 / Jota 3 servidor); desmarcar "Permitir que o
     Windows gerencie minha impressora padrão".
   - Atalho do Chrome do caixa (e o de inicialização, se tiver) com `--kiosk-printing` no fim do
     Destino; fechar todo o Chrome antes. Testar: cupom sai sem janela.
   - Cuidado: tudo vai pra impressora padrão (relatório A4 sai na térmica nesse PC).
2. **Caixa 1 da Jota 2 (DESKTOP-98CNNAE) — 2 telas azuis em 27/10 e sumiu da rede:**
   foto do código de parada; `Get-WinEvent` (Id 1001, 41, 6008) e `wmic diskdrive get model,status`.
3. **Papéis na Equipe (Jota 2 e Jota 3):** todas as operadoras de caixa com papel Caixa/Gerente
   (caixa agora só abre com operador desses papéis + PIN).
4. **Jota 3:** aplicar `a4f7030` e `3e7b8b0` do jota2-producao, se ainda não foram.
