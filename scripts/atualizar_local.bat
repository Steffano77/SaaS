@echo off
cd /d "%~dp0.."
echo Atualizando sistema...
git pull origin claude/affectionate-galileo-fot0op
echo Reiniciando servidor...
pm2 restart panificapro-local --update-env
echo.
echo Pronto! Servidor atualizado.
pause
