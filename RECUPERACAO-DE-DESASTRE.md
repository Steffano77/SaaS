# Se o PC local queimar ou quebrar — passo a passo

O sistema manda um backup completo do banco por e-mail a cada 6 horas. Se o PC queimar, siga
isso numa máquina nova (mesmo um notebook qualquer) pra voltar a vender o quanto antes.

## O que você precisa ter em mãos

- O e-mail mais recente com assunto "💾 Backup PanificaPro" (veja a caixa de entrada configurada
  em `BACKUP_EMAIL`) — baixe o arquivo `.sql.gz` anexado.
- O arquivo `.env` do sistema (se tiver uma cópia salva à parte; senão, peça pra mim recriar com
  as configurações de certificado fiscal, etc.)

## Passo a passo

1. Instale o [Node.js](https://nodejs.org) (versão LTS) e o [MySQL Community Server](https://dev.mysql.com/downloads/mysql/) na máquina nova.
2. Clone o sistema:
   ```
   git clone <url-do-repositorio> panificapro
   cd panificapro
   npm install
   ```
3. Copie o `.env` pra dentro da pasta (ou recrie com as mesmas configurações de antes).
4. Restaure o backup:
   ```
   node scripts/restaurar-backup.js caminho\para\backup_baixado.sql.gz
   ```
5. Suba o sistema:
   ```
   npm install -g pm2
   pm2 start src/index.js --name panificapro-local
   ```
6. Pronto — o sistema volta a rodar com os dados de até 6h antes do problema.

## Dúvida rápida

Se algo travar nesse processo, chama o Claude numa sessão nova explicando o que aconteceu — ele
te guia comando por comando igual sempre fizemos.
