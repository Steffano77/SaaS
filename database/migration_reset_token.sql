-- Migration: adiciona colunas de token de reset de senha
-- Execute UMA VEZ no banco de produção (estef511_panificapro)

ALTER TABLE padarias
  ADD COLUMN reset_token   TEXT     DEFAULT NULL,
  ADD COLUMN reset_expires DATETIME DEFAULT NULL;
