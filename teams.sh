#!/usr/bin/env bash
set -e

# RUN as standar user not as sudo!
APP_ID="com.github.IsmaelMartinez.teams_for_linux"
FLATHUB_REPO="https://dl.flathub.org/repo/flathub.flatpakrepo"

# Sprawdzenie czy flatpak jest zainstalowany
if ! command -v flatpak >/dev/null 2>&1; then
    echo "❌ Flatpak nie jest zainstalowany. Zainstaluj flatpak i spróbuj ponownie."
    exit 1
fi

# Sprawdzenie czy aplikacja jest już zainstalowana
if flatpak info "$APP_ID" >/dev/null 2>&1; then
    echo "✅ Teams for Linux jest już zainstalowany."
    exit 0
fi

echo "ℹ️ Teams for Linux nie jest zainstalowany. Rozpoczynam instalację..."

# Dodanie Flathub jeśli nie istnieje
if ! flatpak remotes | grep -q flathub; then
    echo "➕ Dodawanie repozytorium Flathub..."
    flatpak remote-add --if-not-exists flathub "$FLATHUB_REPO"
fi

# Instalacja aplikacji
flatpak install -y flathub "$APP_ID"

echo "✅ Teams for Linux został pomyślnie zainstalowany."
echo "---------------------------------------------------" &&
echo "Uruchamiam Teamsy...."
sleep 5
clear
flatpak run com.github.IsmaelMartinez.teams_for_linux
