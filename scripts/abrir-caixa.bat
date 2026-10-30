@echo off
rem Abre a tela do caixa so quando o PanificaPro ja estiver respondendo.
rem Bug real (Jota 2, 30/10): com espera fixa de 1 min depois do login, o Chrome
rem abria antes do servidor subir e mostrava ERR_CONNECTION_REFUSED.
rem Uso: abrir-caixa.bat [endereco]   (padrao: http://localhost:3000)
rem Tenta por ate ~5 min; depois abre mesmo assim (F5 resolve).
set "URL=%~1"
if "%URL%"=="" set "URL=http://localhost:3000"
set /a TENTATIVAS=0
:espera
curl -s -o nul --max-time 3 "%URL%/api/health" && goto abrir
set /a TENTATIVAS+=1
if %TENTATIVAS% GEQ 60 goto abrir
timeout /t 5 /nobreak >nul
goto espera
:abrir
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" --kiosk-printing --start-fullscreen --app=%URL%
