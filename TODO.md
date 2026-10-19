# Pendências / projetos futuros

Itens discutidos e aprovados pelo Estefano pra fazer depois, sem pressa.

## ✅ Modo de contingência fiscal (NFC-e) — feito em 2026-10-09

Implementado: se a Sefaz não responder na emissão, sai um XML em
contingência (tpEmis=9), o DANFe já imprime pro cliente na hora, e um job
(a cada 5min) retransmite sozinho assim que a Sefaz voltar.

Ainda não testado num caso real de queda da Sefaz em produção — só
validado via código/sanidade. Se acontecer uma queda de verdade, vale
conferir se o fluxo todo funcionou como esperado.

## Fechamento de caixa às vezes ainda não imprime (investigar com calma)

Relatado em 2026-10-19 pelo Estefano: caixa 1 da Jota 3 não imprimiu o
comprovante de fechamento, teve que reimprimir pelo Financeiro. Ele não
tem certeza se foi antes ou depois do fix de `abrirJanelaImpressaoTermica`
(commit "Corrige impressões que às vezes não saem", 5e13f32/a3832aa já
aplicado nas duas lojas).

Hipóteses já descartadas: confirm() nativo (trocado por confirmarBonito),
onload não disparando em janela reaproveitada (corrigido). Se continuar
acontecendo mesmo depois do fix, pode ser outra causa (ex: popup
bloqueado de vez em quando, impressora/driver, ou algo na própria tela
de fechamento). Próxima vez que acontecer, pegar a hora exata pra cruzar
com os logs do PM2.
