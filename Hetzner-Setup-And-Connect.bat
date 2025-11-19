@echo off
setlocal ENABLEDELAYEDEXPANSION

echo.
echo ============================================
echo   Hetzner SSH-Key Setup ^& Auto-Connect
echo ============================================
echo.

REM --------------------------------
REM 0) Server-IP und User abfragen
REM --------------------------------
:ASK_SERVER
echo Bitte gib die Server-IP oder den Hostnamen ein (z.B. 192.168.1.10 oder server.example.com):
set /p SERVER=Server-IP/Hostname: 

if "%SERVER%"=="" (
    echo [FEHLER] Keine IP/kein Hostname eingegeben.
    echo.
    goto ASK_SERVER
)

echo.
echo Bitte gib den SSH-Benutzer ein (Enter fuer Standard 'root'):
set /p USER=SSH-User: 
if "%USER%"=="" set "USER=root"

echo.
echo Verwende folgende Daten:
echo   Server: %SERVER%
echo   User:   %USER%
echo.
choice /C JN /M "Stimmen diese Angaben? (J/N)"
if errorlevel 2 (
    echo.
    echo OK, dann nochmal von vorn...
    echo.
    goto ASK_SERVER
)

REM --------------------------------
REM 1) Grundeinstellungen fuer Key
REM --------------------------------
set "KEY_NAME=id_ed25519"
set "KEY_DIR=%USERPROFILE%\.ssh"
set "USE_WT=ja"

echo.
echo === Konfiguration ===
echo Key-Datei:   %KEY_DIR%\%KEY_NAME%
echo Win-Terminal: %USE_WT%
echo.


REM --------------------------------
REM 2) Pruefen, ob ssh / ssh-keygen vorhanden sind
REM --------------------------------
where ssh >nul 2>&1
if errorlevel 1 (
    echo [FEHLER] "ssh" wurde nicht gefunden.
    echo Installiere unter Windows:
    echo   Einstellungen ^> Apps ^> Optionale Features ^> OpenSSH-Client
    goto END
)

where ssh-keygen >nul 2>&1
if errorlevel 1 (
    echo [FEHLER] "ssh-keygen" wurde nicht gefunden.
    echo OpenSSH-Client scheint nicht vollstaendig installiert zu sein.
    goto END
)

REM --------------------------------
REM 3) Key-Verzeichnis anlegen
REM --------------------------------
if not exist "%KEY_DIR%" (
    echo [INFO] Erstelle Key-Verzeichnis: %KEY_DIR%
    mkdir "%KEY_DIR%" 2>nul
    if errorlevel 1 (
        echo [FEHLER] Konnte das Verzeichnis %KEY_DIR% nicht erstellen.
        goto END
    )
)

set "KEY_PATH=%KEY_DIR%\%KEY_NAME%"
set "PUB_KEY_PATH=%KEY_PATH%.pub"

REM --------------------------------
REM 4) SSH-Key erzeugen, falls nicht vorhanden
REM --------------------------------
if exist "%KEY_PATH%" (
    echo [OK] Private Key existiert bereits: %KEY_PATH%
) else (
    echo [INFO] Kein Key gefunden. Erzeuge neuen SSH-Key...
    ssh-keygen -t ed25519 -f "%KEY_PATH%" -N "" -C "%USERNAME%@%COMPUTERNAME%-%SERVER%"
    if errorlevel 1 (
        echo [FEHLER] ssh-keygen ist fehlgeschlagen.
        goto END
    )
    echo [OK] Neuer SSH-Key wurde erstellt: %KEY_PATH%
)

if not exist "%PUB_KEY_PATH%" (
    echo [FEHLER] Public Key fehlt: %PUB_KEY_PATH%
    goto END
)

REM --------------------------------
REM 5) Public Key auf Server kopieren
REM --------------------------------
echo.
echo === Public Key auf den Server kopieren ===
echo Es kann sein, dass du JETZT EIN LETZTES MAL das Passwort eingeben musst.
echo.

type "%PUB_KEY_PATH%" | ssh %USER%@%SERVER% "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat ^>^> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
if errorlevel 1 (
    echo [FEHLER] Konnte Public Key nicht auf den Server kopieren.
    goto END
)

echo.
echo [OK] Public Key wurde erfolgreich auf dem Server hinterlegt.
echo.

REM --------------------------------
REM 6) Hinweise fuer sichere SSH-Konfiguration
REM --------------------------------
echo ============================================
echo   EMPFOHLENE SERVER-KONFIGURATION
echo ============================================
echo Melde dich per SSH an und bearbeite die Datei:
echo   /etc/ssh/sshd_config
echo.
echo Wichtige Optionen:
echo   PasswordAuthentication no
echo   PermitRootLogin prohibit-password ^(oder no, wenn du einen separaten User nutzt^)
echo.
echo Danach auf dem Server ausfuehren:
echo   systemctl reload sshd
echo.
pause


REM --------------------------------
REM 7) Mit Key verbinden
REM --------------------------------
echo.
echo === Verbinde jetzt per SSH mit Key ===
echo.

if /I "%USE_WT%"=="ja" (
    where wt >nul 2>&1
    if errorlevel 1 (
        echo [WARNUNG] Windows Terminal (wt.exe) nicht gefunden. Starte normale SSH Verbindung:
        ssh -i "%KEY_PATH%" %USER%@%SERVER%
    ) else (
        start "" wt.exe ssh -i "%KEY_PATH%" %USER%@%SERVER%
    )
) else (
    ssh -i "%KEY_PATH%" %USER%@%SERVER%
)

:END
echo.
echo Fertig. Fenster kann geschlossen werden.
echo.
endlocal
