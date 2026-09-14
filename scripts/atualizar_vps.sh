#!/bin/bash
# Roda no VPS: cd /var/www/panificapro && bash scripts/atualizar_vps.sh
cd /var/www/panificapro
echo "Atualizando sistema..."
git pull origin claude/affectionate-galileo-fot0op
echo "Reiniciando servidor..."
pm2 restart panificapro
echo ""
echo "Pronto! Servidor atualizado."
