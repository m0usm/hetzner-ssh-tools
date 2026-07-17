@echo off
setlocal

echo.
echo ============================================
echo    Hetzner SSH-Key Setup ^& Auto-Connect
echo ============================================
echo.

REM --------------------------------
REM 0) Server-IP, User und Alias abfragen
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
echo Bitte gib einen kurzen Alias fuer den Server ein (z.B. hetzner-web).
echo Damit kannst du dich spaeter einfach per "ssh ALIAS" verbinden.
set /p HOSTALIAS=Alias (Enter fuer 'hetzner'): 
if "%HOSTALIAS%"=="" set "HOSTALIAS=hetzner"

echo.
echo Verwende folgende Daten:
echo    Server: %SERVER%
echo    User:   %USER%
echo    Alias:  %HOSTALIAS%
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
set "SSH_CONFIG=%KEY_DIR%\config"

echo.
echo === Konfiguration ===
echo    Key-Datei:  %KEY_DIR%\%KEY_NAME%
echo    SSH-Config: %SSH_CONFIG%
echo.

REM --------------------------------
REM 2) Pruefen, ob ssh / ssh-keygen vorhanden sind
REM --------------------------------
where ssh >nul 2>&1
if errorlevel 1 (
    echo [FEHLER] "ssh" wurde nicht gefunden.
    echo Installiere unter Windows:
    echo    Einstellungen ^> Apps ^> Optionale Features ^> OpenSSH-Client
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
    echo [HINWEIS] Der Key wird OHNE Passphrase erstellt (Komfort-Entscheidung).
    echo           Wer den Key zusaetzlich schuetzen will, kann spaeter mit
    echo           "ssh-keygen -p -f %KEY_PATH%" eine Passphrase setzen.
    ssh-keygen -t ed25519 -f "%KEY_PATH%" -N "" -C "%USERNAME%@%COMPUTERNAME%"
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
REM 5) Public Key auf Server kopieren (ohne Duplikate)
REM --------------------------------
echo.
echo === Public Key auf den Server kopieren ===
echo Es kann sein, dass du JETZT EIN LETZTES MAL das Passwort eingeben musst.
echo.

type "%PUB_KEY_PATH%" | ssh -o StrictHostKeyChecking=accept-new %USER%@%SERVER% "mkdir -p ~/.ssh && chmod 700 ~/.ssh && KEY=$(cat) && { grep -qxF \"$KEY\" ~/.ssh/authorized_keys 2>/dev/null || echo \"$KEY\" >> ~/.ssh/authorized_keys; } && chmod 600 ~/.ssh/authorized_keys"
if errorlevel 1 (
    echo [FEHLER] Konnte Public Key nicht auf den Server kopieren.
    goto END
)

echo.
echo [OK] Public Key wurde erfolgreich auf dem Server hinterlegt.
echo      (Bereits vorhandene Keys werden nicht doppelt eingetragen.)
echo.

REM --------------------------------
REM 6) Eintrag in ~/.ssh/config schreiben
REM --------------------------------
set "ALIAS_EXISTS="
if exist "%SSH_CONFIG%" (
    findstr /R /C:"^Host  *%HOSTALIAS%$" /C:"^Host %HOSTALIAS%$" "%SSH_CONFIG%" >nul 2>&1
    if not errorlevel 1 set "ALIAS_EXISTS=1"
)

if defined ALIAS_EXISTS (
    echo [INFO] Alias "%HOSTALIAS%" existiert bereits in %SSH_CONFIG%.
    echo        Es wird kein neuer Eintrag geschrieben.
) else (
    (
        echo.
        echo Host %HOSTALIAS%
        echo     HostName %SERVER%
        echo     User %USER%
        echo     IdentityFile ~/.ssh/%KEY_NAME%
    ) >> "%SSH_CONFIG%"
    echo [OK] Alias "%HOSTALIAS%" wurde in %SSH_CONFIG% eingetragen.
    echo      Ab jetzt reicht ueberall:  ssh %HOSTALIAS%
    echo      (funktioniert auch mit scp, rsync, VS Code Remote-SSH usw.)
)
echo.

REM --------------------------------
REM 7) Hinweise fuer sichere SSH-Konfiguration
REM --------------------------------
echo ============================================
echo    EMPFOHLENE SERVER-KONFIGURATION
echo ============================================
echo Melde dich per SSH an und bearbeite die Datei:
echo    /etc/ssh/sshd_config
echo.
echo Wichtige Optionen:
echo    PasswordAuthentication no
echo    PermitRootLogin prohibit-password   ^(oder no, wenn du einen separaten User nutzt^)
echo.
echo Danach auf dem Server ausfuehren:
echo    systemctl reload sshd
echo.
pause

REM --------------------------------
REM 8) Mit Key verbinden
REM --------------------------------
echo.
echo === Verbinde jetzt per SSH ===
echo.
choice /C JN /M "Im Windows Terminal (wt) oeffnen, falls vorhanden? (J/N)"
if errorlevel 2 (
    ssh %HOSTALIAS%
    goto END
)

where wt >nul 2>&1
if errorlevel 1 (
    echo [WARNUNG] Windows Terminal ^(wt.exe^) nicht gefunden. Starte normale SSH-Verbindung:
    ssh %HOSTALIAS%
) else (
    start "" wt.exe ssh %HOSTALIAS%
)

:END
echo.
echo Fertig. Fenster kann geschlossen werden.
echo.
endlocal
