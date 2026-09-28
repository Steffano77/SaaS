#!/bin/bash
# Prepara o banco de testes (usuário + banco + schema base) antes de rodar "npm test".
# Idempotente — pode rodar de novo sem problema (schema.sql cria as tabelas do zero,
# então só funciona num banco vazio; se já rodou antes, dropa e recria).
set -e
mysql -u root -e "
DROP DATABASE IF EXISTS panificapro_test;
CREATE DATABASE panificapro_test;
CREATE USER IF NOT EXISTS 'panificapro_test'@'localhost' IDENTIFIED BY 'test_pw_123';
GRANT ALL PRIVILEGES ON panificapro_test.* TO 'panificapro_test'@'localhost';
FLUSH PRIVILEGES;
"
mysql -u panificapro_test -ptest_pw_123 panificapro_test < "$(dirname "$0")/../database/schema.sql"
echo "Banco de teste pronto (panificapro_test)."
