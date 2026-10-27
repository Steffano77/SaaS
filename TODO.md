# Pendências / projetos futuros

Itens discutidos e aprovados pelo Estefano pra fazer depois, sem pressa.

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
