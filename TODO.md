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

## Duas rejeições de NFC-e na mesma comanda (Balcão C57, 2026-10-21) — investigar com calma

Reportado pelo Estefano, caixas em operação então não mexi na hora:

- Erro 704: "NFC-e ou NF-e com DANFE Simplificado Tipo 2 com Data-Hora de
  emissão atrasada" — nota reenviada com dhEmi velho demais.
- Erro 865: "Total dos pagamentos menor que o total da nota" — na tentativa
  de "Reemitir corrigida", os pagamentos da nota corrigida ficaram com total
  menor que o da nota.

Conferir `src/controllers/nfceController.js` (`reenviar`, reemissão
corrigida) e `src/fiscal/xmlNFCe.js` (geração do `dhEmi`). Comanda específica
(Balcão C57) — conferir se precisa agir nela além do código.
