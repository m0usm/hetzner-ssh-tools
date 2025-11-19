<p align="center">
  <img src="images/banner.png" alt="Hetzner SSH Tools Banner" width="60%">
</p>

# Hetzner SSH Tools (Windows)

Leichte Windows-Batch-Skripte, die das Einrichten von SSH-Schlüsseln und einen sicheren, passwortlosen Zugriff auf Hetzner-Server automatisieren.

---

# Deutsch

## Überblick

Die Hetzner SSH Tools ermöglichen ein schnelles und komfortables Setup für sichere SSH-Logins unter Windows.  
Das Setup-Skript erstellt automatisch einen SSH-Key, kopiert den Public Key auf den Server und öffnet direkt eine SSH-Verbindung.  
Das zweite Skript dient als schneller „Daily Login“-Connector.

## Enthaltene Skripte

### 1. Hetzner-Setup-And-Connect.bat
- Fragt Server-IP/Hostname und Benutzer ab  
- Erstellt automatisch einen SSH-Key (`ed25519`), falls keiner existiert  
- Überträgt den Public Key auf den Server (`~/.ssh/authorized_keys`)  
- Setzt automatisch die korrekten SSH-Berechtigungen  
- Zeigt empfohlene Sicherheitseinstellungen an  
- Startet direkt eine SSH-Verbindung  
- Optional: nutzt Windows Terminal (`wt.exe`)

### 2. Hetzner-Connect.bat
- Fragt Server-IP/Hostname und Benutzer ab  
- Verwendet vorhandenen SSH-Key unter `%USERPROFILE%\.ssh\id_ed25519`  
- Baut sofort eine SSH-Verbindung auf  
- Ideal für den täglichen Login

---

## Voraussetzungen
- Windows 10 oder 11  
- OpenSSH-Client installiert  
  *(Einstellungen → Apps → Optionale Features → OpenSSH-Client)*  
- Optional: Windows Terminal (`wt.exe`)

---

## Installation
1. `.bat`-Dateien herunterladen  
2. An beliebiger Stelle speichern  
3. Mit Doppelklick ausführen

---

## Verwendung

### Setup-Skript
1. Skript starten  
2. IP/Hostname eingeben  
3. Benutzer eingeben (Standard: `root`)  
4. Passwort einmalig eingeben (für Public Key Deployment)  
5. Danach erfolgt jeder Login passwortlos

### Connect-Skript
1. Skript starten  
2. IP eingeben  
3. Benutzer eingeben  
4. Sofort verbunden

---

## Sicherheit
- Private SSH-Keys bleiben **immer lokal**  
- Nur der Public Key wird übertragen  
- `.ssh`-Berechtigungen werden automatisch korrigiert  
- Verwendet sichere `ed25519`-Schlüssel

---

## Lizenz
MIT-Lizenz — siehe `LICENSE`.

---

# English

## Overview

Hetzner SSH Tools provide a quick and convenient way to set up secure SSH access on Windows.  
The setup script automatically generates an SSH key, deploys the public key to the server, and opens a secure SSH session.  
The second script serves as a fast daily-connect tool.

## Included Scripts

### 1. Hetzner-Setup-And-Connect.bat
- Prompts for server IP/hostname and SSH user  
- Automatically generates an `ed25519` SSH key if missing  
- Uploads the public key to `~/.ssh/authorized_keys`  
- Fixes SSH file permissions automatically  
- Displays recommended SSH security settings  
- Opens an SSH session immediately  
- Optional: uses Windows Terminal (`wt.exe`)

### 2. Hetzner-Connect.bat
- Prompts for server IP/hostname and user  
- Uses the existing SSH key at `%USERPROFILE%\.ssh\id_ed25519`  
- Opens an SSH connection instantly  
- Ideal for daily login

---

## Requirements
- Windows 10 or 11  
- OpenSSH Client installed  
  *(Settings → Apps → Optional features → OpenSSH Client)*  
- Optional: Windows Terminal (`wt.exe`)

---

## Installation
1. Download the `.bat` files  
2. Save them anywhere  
3. Run via double-click

---

## Usage

### Setup Script
1. Run the script  
2. Enter IP/hostname  
3. Enter user (default: `root`)  
4. Enter your password once (public key upload)  
5. All future logins are passwordless

### Connect Script
1. Run the script  
2. Enter IP  
3. Enter user  
4. Instant SSH connection

---

## Security
- Private SSH keys **always stay on your machine**  
- Only the public key is uploaded  
- Permissions are automatically fixed  
- Uses secure `ed25519` keys

---

## License
MIT License — see `LICENSE`.

---

## Support
If this project helps you, please consider leaving a ⭐  
Wenn dir dieses Projekt hilft, freue ich mich über einen ⭐
