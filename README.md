# Hetzner SSH Tools (Windows)

Simple Windows batch scripts to automate SSH key setup and passwordless SSH login for Hetzner servers.  
Einfache Windows-Batch-Skripte zum automatischen Einrichten von SSH-Keys und passwortlosem SSH-Login auf Hetzner-Servern.

---

## Features / Funktionen

### Setup & Connect Script
- Generates an SSH key (`ed25519`) if none exists  
- Erstellt automatisch einen SSH-Key (`ed25519`), falls keiner existiert  

- Uploads the public key to the server (`~/.ssh/authorized_keys`)  
- Überträgt den Public Key auf den Server (`~/.ssh/authorized_keys`)  

- Fixes permissions and provides recommended SSH settings  
- Korrigiert Berechtigungen und zeigt empfohlene SSH-Sicherheitsoptionen  

- Opens an SSH session using Windows Terminal (optional)  
- Öffnet eine SSH-Verbindung über Windows Terminal (optional)  

---

### Connect Script
- Uses your existing SSH key  
- Verwendet deinen vorhandenen SSH-Key  

- Quick passwordless SSH connection  
- Schneller SSH-Login ohne Passwort  

---

## Requirements / Voraussetzungen

- Windows 10 / 11  
- OpenSSH Client installed  
  (*Windows Settings → Optional features*)  
- OpenSSH-Client installiert  
  (*Windows Einstellungen → Optionale Features*)  

- Optional: Windows Terminal  
- Optional: Windows Terminal  

---

## Usage / Verwendung

### Setup Script
1. Run the script  
   Skript starten  
2. Enter server IP / hostname  
   Server-IP oder Hostname eingeben  
3. Enter SSH user (default: `root`)  
   Benutzer eingeben (Standard: `root`)  
4. Enter your password once (key upload)  
   Passwort **ein einziges Mal** eingeben (Key wird übertragen)  
5. Future logins are passwordless  
   Zukünftige Logins sind passwortlos  

---

### Connect Script
1. Run the script  
   Skript starten  
2. Enter server IP & user  
   IP & Benutzer eingeben  
3. SSH session opens immediately  
   SSH startet sofort  

---

## Security / Sicherheit
- Private keys stay on your machine  
- Private Keys bleiben lokal  

- Only the public key is uploaded  
- Nur der Public Key wird übertragen  

- Uses secure `ed25519` keys  
- Nutzt sichere `ed25519`-Schlüssel  

---

## License / Lizenz
MIT License – see `LICENSE`.  
MIT-Lizenz – siehe `LICENSE`.

---

## Support
If this project helps you, consider starring it ⭐  
Wenn dir das Projekt hilft, freue ich mich über einen Stern ⭐
