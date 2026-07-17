@echo off
setlocal

echo.
echo ===== Hetzner SSH Connect =====
echo.

set "SSH_CONFIG=%USERPROFILE%\.ssh\config"

REM Konfigurierte Aliasse anzeigen, falls vorhanden
if exist "%SSH_CONFIG%" (
    echo Konfigurierte Server-Aliasse:
    findstr /R /B /C:"Host " "%SSH_CONFIG%" 2>nul
    echo.
) else (
    echo [HINWEIS] Keine SSH-Config gefunden ^(%SSH_CONFIG%^).
    echo Fuehre zuerst das Setup-Skript aus, oder gib IP/Hostname direkt ein.
    echo.
)

echo Bitte gib den Alias, die Server-IP oder den Hostnamen ein:
set /p TARGET=Ziel: 

if "%TARGET%"=="" (
    echo Keine Eingabe, breche ab.
    goto END
)

echo.
echo Verbinde zu: %TARGET%
echo.

ssh %TARGET%

:END
echo.
endlocal
