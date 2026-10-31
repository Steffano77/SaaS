@echo off
cd /d "%~dp0.."
echo Atualizando sistema...
git pull origin jota2-producao
rem Instala biblioteca nova, se a atualizacao trouxer (bug real 31/10: pdfkit novo e o
rem servidor ficou "stopped" ate rodar npm install na mao). Sem nada novo, e rapido.
echo Conferindo bibliotecas...
call npm install --no-audit --no-fund
echo Reiniciando servidor...
pm2 restart panificapro-local --update-env
echo.
echo Pronto! Servidor atualizado.
pause
