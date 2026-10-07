# Pendências / projetos futuros

Itens discutidos e aprovados pelo Estefano pra fazer depois, sem pressa.

## Modo de contingência fiscal (NFC-e)

Hoje, se a Sefaz-SP cair, a venda continua normal (comanda fecha, pagamento
registrado), mas a nota fica marcada como "erro" e só pode ser reemitida
manualmente depois — não existe o modo de contingência oficial (emitir um
documento provisório na hora, pro cliente, e transmitir pra Sefaz depois
que ela voltar).

Implementar isso envolve:
- Gerar um documento provisório (com aviso de contingência) quando a Sefaz
  não responder, pra entregar pro cliente na hora.
- Guardar o XML com `tpEmi=9` (contingência offline) ou similar.
- Job/rotina que detecta quando a Sefaz volta e reenvia automaticamente as
  notas pendentes de contingência.
- Atualizar a tela de pendentes/reenvio pra deixar claro quais notas estão
  em contingência vs erro de verdade.

Combinado em 2026-10-07: baixa prioridade, fazer num dia com mais tempo.
