#!/usr/bin/env bash
set -euo pipefail

# Instala o launcher e o atalho de desktop no escopo do usuário
PREFIX_BIN="$HOME/.local/bin"
PREFIX_APPS="$HOME/.local/share/applications"
PREFIX_ICONS="$HOME/.local/share/icons/hicolor/512x512/apps"

mkdir -p "$PREFIX_BIN" "$PREFIX_APPS" "$PREFIX_ICONS"

# Copiar launcher
install -m 0755 "$(dirname "$0")/bin/whatsapp-waydroid" "$PREFIX_BIN/whatsapp-waydroid"

# Preparar .desktop com caminhos corrigidos
DESKTOP_TMP="/tmp/WhatsApp-Waydroid.desktop"
cp "$(dirname "$0")/WhatsApp-Waydroid.desktop" "$DESKTOP_TMP"

# Atualizar Exec para apontar ao launcher instalado
sed -i "s|^Exec=.*$|Exec=$PREFIX_BIN/whatsapp-waydroid|" "$DESKTOP_TMP"

# Se existir ícone local, instalar e apontar o caminho padrão
ICON_PNG="$(dirname "$0")/assets/icon.png"
ICON_SVG="$(dirname "$0")/assets/icon.svg"
if [ -f "$ICON_PNG" ]; then
  install -m 0644 "$ICON_PNG" "$PREFIX_ICONS/whatsapp-waydroid.png"
  sed -i "s|^Icon=.*$|Icon=whatsapp-waydroid|" "$DESKTOP_TMP"
elif [ -f "$ICON_SVG" ]; then
  # Alguns desktops suportam SVG por nome se instalado em hicolor
  mkdir -p "$HOME/.local/share/icons/hicolor/scalable/apps"
  install -m 0644 "$ICON_SVG" "$HOME/.local/share/icons/hicolor/scalable/apps/whatsapp-waydroid.svg"
  sed -i "s|^Icon=.*$|Icon=whatsapp-waydroid|" "$DESKTOP_TMP"
fi

# Instalar .desktop
install -m 0644 "$DESKTOP_TMP" "$PREFIX_APPS/WhatsApp-Waydroid.desktop"
update-desktop-database "$HOME/.local/share/applications" >/dev/null 2>&1 || true

echo "Instalação concluída. Procure por 'WhatsApp (Waydroid)' no menu de aplicativos."
