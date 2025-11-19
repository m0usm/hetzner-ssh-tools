Hetzner SSH Tools (Windows)






Zwei Windows-Batch-Skripte, die SSH-Key-Setup und SSH-Verbindungen zu Hetzner-Servern automatisieren.
Two Windows batch scripts that automate SSH key setup and SSH connections to Hetzner servers.

Inhaltsverzeichnis / Table of Contents

Deutsch

English

Deutsch
Funktionen
Hetzner-Setup-And-Connect.bat

Fragt Server-IP/Hostname und Benutzer ab

Erstellt automatisch einen ed25519 SSH-Key, wenn keiner existiert

Überträgt den Public Key zum Server (~/.ssh/authorized_keys)

Empfohlene SSH-Sicherheitsoptionen werden angezeigt

Öffnet automatisch eine SSH-Verbindung mit Key

Optional: Nutzung von Windows Terminal

Hetzner-Connect.bat

Fragt Server-IP/Hostname und Benutzer ab

Verwendet vorhandenen Key unter %USERPROFILE%\.ssh\id_ed25519

Startet direkt eine SSH-Verbindung

Ideal für den täglichen Login

Voraussetzungen

Windows 10/11

OpenSSH-Client installiert

Optional: Windows Terminal

Installation

.bat-Dateien herunterladen

An einen beliebigen Speicherort legen

Mit Doppelklick ausführen

Verwendung
Setup-Skript

Starten

IP/Hostname eingeben

Benutzer eingeben

Einmal Passwort eingeben, damit der Key kopiert werden kann

Danach passwortloser Login möglich

Connect-Skript

Starten

IP/Hostname eingeben

Benutzer eingeben

Sofort verbunden

Sicherheit

Private Keys bleiben immer lokal

Nur Public Key wird übertragen

Rechte an .ssh und authorized_keys werden automatisch korrigiert

Sichere ed25519-Schlüssel

Lizenz

MIT License – siehe LICENSE.

English
Features
Hetzner-Setup-And-Connect.bat

Prompts for server IP/hostname and user

Automatically generates an ed25519 SSH key if missing

Deploys the public key to the server (~/.ssh/authorized_keys)

Displays recommended SSH security settings

Opens an SSH connection automatically

Optional: Uses Windows Terminal

Hetzner-Connect.bat

Prompts for server IP/hostname and user

Uses an existing key at %USERPROFILE%\.ssh\id_ed25519

Opens an SSH connection instantly

Ideal for daily login

Requirements

Windows 10/11

OpenSSH Client installed

Optional: Windows Terminal

Installation

Download the .bat files

Place them anywhere

Run via double-click

Usage
Setup Script

Run

Enter IP/hostname

Enter user

Enter password once (to upload the key)

Afterwards: passwordless SSH login

Connect Script

Run

Enter IP/hostname

Enter user

Connect instantly

Security

Private keys stay on your machine

Only the public key is uploaded

.ssh permissions fixed automatically

Uses secure ed25519 keys

License

MIT License – see LICENSE.

Support

Wenn dir das Projekt gefällt, freue ich mich über einen Stern.
If you like this project, consider giving it a star.
