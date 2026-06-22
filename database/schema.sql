-- ============================================================
--  PanificaPro ERP — Schema MySQL
--  Importe este arquivo com o banco estef511_panificapro já selecionado
-- ============================================================

-- ── Padarias (tenants) ──────────────────────────────────────
CREATE TABLE padarias (
  id            INT AUTO_INCREMENT PRIMARY KEY,
  nome          VARCHAR(120) NOT NULL,
  email         VARCHAR(120) NOT NULL UNIQUE,
  senha_hash    VARCHAR(255) NOT NULL,
  plano         ENUM('trial','basico','pro') DEFAULT 'trial',
  ativo         BOOLEAN DEFAULT TRUE,
  criado_em     DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ── Categorias de produto ───────────────────────────────────
CREATE TABLE categorias (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  padaria_id INT NOT NULL,
  nome       VARCHAR(80) NOT NULL,
  FOREIGN KEY (padaria_id) REFERENCES padarias(id) ON DELETE CASCADE
);

-- ── Fornecedores ────────────────────────────────────────────
CREATE TABLE fornecedores (
  id         INT AUTO_INCREMENT PRIMARY KEY,
  padaria_id INT NOT NULL,
  nome       VARCHAR(120) NOT NULL,
  contato    VARCHAR(80),
  telefone   VARCHAR(20),
  email      VARCHAR(120),
  ativo      BOOLEAN DEFAULT TRUE,
  FOREIGN KEY (padaria_id) REFERENCES padarias(id) ON DELETE CASCADE
);

-- ── Produtos / insumos ──────────────────────────────────────
CREATE TABLE produtos (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  padaria_id      INT NOT NULL,
  categoria_id    INT,
  codigo_barras   VARCHAR(20),
  nome            VARCHAR(150) NOT NULL,
  unidade         VARCHAR(20) DEFAULT 'UNIDADE',
  custo_unitario  DECIMAL(10,4) DEFAULT 0,
  preco_venda     DECIMAL(10,2) DEFAULT 0,
  estoque_atual   DECIMAL(10,3) DEFAULT 0,
  estoque_minimo  DECIMAL(10,3) DEFAULT 0,
  validade        DATE,
  ativo           BOOLEAN DEFAULT TRUE,
  criado_em       DATETIME DEFAULT CURRENT_TIMESTAMP,
  atualizado_em   DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (padaria_id) REFERENCES padarias(id) ON DELETE CASCADE,
  FOREIGN KEY (categoria_id) REFERENCES categorias(id) ON DELETE SET NULL
);

-- ── Movimentações de estoque ────────────────────────────────
CREATE TABLE movimentacoes (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  padaria_id   INT NOT NULL,
  produto_id   INT NOT NULL,
  tipo         ENUM('entrada','saida','ajuste','sync_saurus') NOT NULL,
  quantidade   DECIMAL(10,3) NOT NULL,
  custo_unit   DECIMAL(10,4) DEFAULT 0,
  valor_total  DECIMAL(10,2) GENERATED ALWAYS AS (quantidade * custo_unit) STORED,
  observacao   VARCHAR(255),
  data         DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (padaria_id) REFERENCES padarias(id) ON DELETE CASCADE,
  FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
);

-- ── Pedidos de compra ───────────────────────────────────────
CREATE TABLE pedidos_compra (
  id             INT AUTO_INCREMENT PRIMARY KEY,
  padaria_id     INT NOT NULL,
  fornecedor_id  INT,
  status         ENUM('rascunho','enviado','recebido','cancelado') DEFAULT 'rascunho',
  total          DECIMAL(10,2) DEFAULT 0,
  observacao     TEXT,
  criado_em      DATETIME DEFAULT CURRENT_TIMESTAMP,
  recebido_em    DATETIME,
  FOREIGN KEY (padaria_id) REFERENCES padarias(id) ON DELETE CASCADE,
  FOREIGN KEY (fornecedor_id) REFERENCES fornecedores(id) ON DELETE SET NULL
);

CREATE TABLE itens_pedido (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  pedido_id       INT NOT NULL,
  produto_id      INT NOT NULL,
  quantidade      DECIMAL(10,3) NOT NULL,
  custo_unitario  DECIMAL(10,4) DEFAULT 0,
  total           DECIMAL(10,2) GENERATED ALWAYS AS (quantidade * custo_unitario) STORED,
  FOREIGN KEY (pedido_id) REFERENCES pedidos_compra(id) ON DELETE CASCADE,
  FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
);

-- ── Fichas técnicas (receitas) ──────────────────────────────
CREATE TABLE fichas_tecnicas (
  id           INT AUTO_INCREMENT PRIMARY KEY,
  padaria_id   INT NOT NULL,
  nome         VARCHAR(150) NOT NULL,
  rendimento   DECIMAL(10,3) DEFAULT 1,
  unidade      VARCHAR(20) DEFAULT 'unidade',
  ativo        BOOLEAN DEFAULT TRUE,
  criado_em    DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (padaria_id) REFERENCES padarias(id) ON DELETE CASCADE
);

CREATE TABLE itens_ficha (
  id              INT AUTO_INCREMENT PRIMARY KEY,
  ficha_id        INT NOT NULL,
  produto_id      INT NOT NULL,
  quantidade      DECIMAL(10,4) NOT NULL,
  FOREIGN KEY (ficha_id) REFERENCES fichas_tecnicas(id) ON DELETE CASCADE,
  FOREIGN KEY (produto_id) REFERENCES produtos(id) ON DELETE CASCADE
);

-- ── Índices ─────────────────────────────────────────────────
CREATE INDEX idx_produtos_padaria    ON produtos(padaria_id);
CREATE INDEX idx_produtos_barcode    ON produtos(codigo_barras);
CREATE INDEX idx_movimentacoes_prod  ON movimentacoes(produto_id, data);
CREATE INDEX idx_pedidos_padaria     ON pedidos_compra(padaria_id, status);
