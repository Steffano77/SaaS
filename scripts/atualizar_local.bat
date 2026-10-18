@echo off
cd /d "%~dp0.."
echo Atualizando sistema...
git pull origin jota3-producao
echo Reiniciando servidor...
pm2 restart panificapro-local --update-env
echo.
echo Pronto! Servidor atualizado.
pause
