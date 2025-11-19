# Hetzner SSH Tools (Windows)

Zwei kleine Batch-Skripte, um unter Windows schnell und komfortabel per SSH auf einen Hetzner-Server zuzugreifen.

## Voraussetzungen

- Windows 10/11
- OpenSSH-Client installiert  
  (Einstellungen → Apps → Optionale Features → „OpenSSH-Client“)
- Optional: Windows Terminal (`wt.exe`)

## Skripte

### 1. Hetzner-Setup-And-Connect.bat

- Fragt Server-IP/Hostname und SSH-User ab
- Erstellt bei Bedarf automatisch einen SSH-Key (`ed25519`)
- Kopiert den Public Key auf den Server (`~/.ssh/authorized_keys`)
- Gibt Hinweise für sichere SSH-Konfiguration
- Baut danach direkt eine SSH-Verbindung mit Key auf

Verwendung:

1. Skript per Doppelklick starten
2. IP/Hostname eingeben
3. Benutzer eingeben (oder Enter für `root`)
4. Beim ersten Mal einmalig das Passwort eingeben
5. Danach erfolgt der Login passwortlos per Key

### 2. Hetzner-Connect.bat

- Fragt Server-IP/Hostname und SSH-User ab
- Verwendet vorhandenen Key unter  
  `%USERPROFILE%\.ssh\id_ed25519`
- Baut eine SSH-Verbindung auf

Geeignet für den täglichen Login, wenn der Key schon eingerichtet ist.

## Hinweise

- Die Skripte sind generisch und können auch für andere Server (nicht nur Hetzner) verwendet werden.
- Wer möchte, kann den Key-Namen oder Pfad in den Skripten anpassen.
