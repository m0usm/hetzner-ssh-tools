@echo off
setlocal

echo.
echo ===== Hetzner SSH Connect =====
echo.

echo Bitte gib die Server-IP oder den Hostnamen ein:
set /p SERVER=Server-IP/Hostname: 

if "%SERVER%"=="" (
    echo Keine IP eingegeben, breche ab.
    goto :END
)

echo.
echo Bitte gib den SSH-Benutzer ein (Enter fuer 'root'):
set /p USER=SSH-User: 
if "%USER%"=="" set "USER=root"

set "KEY_PATH=%USERPROFILE%\.ssh\id_ed25519"

if not exist "%KEY_PATH%" (
    echo [FEHLER] Key-Datei wurde nicht gefunden:
    echo   %KEY_PATH%
    echo Fuehre zuerst das Setup-Skript aus.
    goto :END
)

echo.
echo Verbinde zu %USER%@%SERVER% mit Key:
echo   %KEY_PATH%
echo.

ssh -i "%KEY_PATH%" %USER%@%SERVER%

:END
echo.
endlocal
