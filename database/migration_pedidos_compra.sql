-- Migration: adiciona status 'pendente' ao ENUM de pedidos_compra
ALTER TABLE pedidos_compra
  MODIFY COLUMN status ENUM('rascunho','enviado','pendente','recebido','cancelado') DEFAULT 'pendente';
