#!/usr/bin/env bash
set -euo pipefail

APK_PATH=${1:-}
if [ -z "$APK_PATH" ]; then
  echo "Uso: $0 /caminho/para/WhatsApp.apk" >&2
  exit 1
fi

if ! command -v waydroid >/dev/null 2>&1; then
  echo "[erro] Waydroid não encontrado. Rode scripts/setup-waydroid.sh primeiro." >&2
  exit 1
fi

if ! waydroid status | grep -q "Session: RUNNING"; then
  echo "[info] Iniciando sessão do Waydroid..."
  nohup waydroid session start >/dev/null 2>&1 &
  sleep 3
fi

echo "[info] Instalando APK: $APK_PATH"
waydroid app install "$APK_PATH"

echo "[ok] APK instalado. Para abrir: ~/.local/bin/whatsapp-waydroid"
