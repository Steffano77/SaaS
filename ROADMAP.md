# Roadmap PanificaPro

Registro de próximos passos combinados com o Estefano, pra não perder o fio entre sessões.

## Pendente

### Modo offline
Hoje o PanificaPro exige internet — sem conexão, os tablets/PCs não conseguem abrir comanda,
adicionar item nem cobrar, porque cada ação depende do servidor.

Combinado por enquanto: usar **internet 4G de backup** (roteador com chip ou hotspot do celular)
como plano B, e manter um talão de papel só pra emergência de verdade.

Quando fizer sentido investir: construir um modo offline de verdade — o app guarda tudo local no
tablet (IndexedDB/service worker) enquanto não tem internet, e sincroniza sozinho quando a conexão
volta. É trabalho grande (fila de sincronização, resolução de conflito se duas comandas usarem o
mesmo número offline, etc.), não é uma tarde de trabalho.

### Nota Fiscal (NFC-e)
Emitir cupom fiscal de verdade nas Comandas. Precisa escolher um gateway pago primeiro
(Nuvem Fiscal, Focus NFe, eNotas são os cotados). As padarias já têm certificado digital pelo
sistema antigo (Saurus), então esse pré-requisito já está resolvido — falta só a integração.

## Concluído (contexto, não mexer sem necessidade)

- Módulo de Comandas completo: abrir/buscar/fechar, itens (produto cadastrado ou avulso),
  pagamento dividido entre formas, desconto/acréscimo
- Caixa: múltiplos caixas simultâneos (um por tablet/PC), abertura/fechamento com sangria/suprimento,
  resumo com esperado em dinheiro x recebido fora da gaveta
- Atendente com PIN de 4 dígitos, vinculado ao caixa (não mais por comanda)
- Modo Balcão (`?balcao=1`) — trava a tela só em Comandas
- Modo Lançamento (`?lancamento=1`) — tablets do salão só lançam pedido, sem botão de cobrança;
  cobrança só é permitida em aparelho com caixa aberto (pensado pros PCs do caixa)
- Toque rápido: produtos marcados como "venda rápida" no Estoque viram botão grande na comanda
- Impressão térmica (80mm): ficha pra cozinha + recibo do cliente + comprovante de fechamento de caixa
- Importação Saurus: reconhece item de balcão (código curto) x item de mercado (EAN), cria produto
  automaticamente quando não existe. Exportação do Saurus tem limite de ~500 registros por vez —
  pra importar o catálogo inteiro, precisa exportar por categoria
