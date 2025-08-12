#!/usr/bin/env bash
set -euo pipefail

if ! command -v sudo >/dev/null 2>&1; then
  echo "[erro] sudo não encontrado. Instale sudo ou execute como root." >&2
  exit 1
fi

echo "[1/3] Instalando Waydroid..."
sudo apt update
sudo apt install -y waydroid

echo "[2/3] Inicializando Waydroid..."
sudo waydroid init || true

cat <<EOF
[info] Se houver mensagens sobre LXD, binder/ashmem ou permissões, siga:
https://docs.waydro.id/
EOF

echo "[3/3] Iniciando sessão do Waydroid..."
nohup waydroid session start >/dev/null 2>&1 &

echo "[ok] Waydroid instalado/inicializado. Abra a UI do Waydroid e instale o WhatsApp (Play/Aurora) ou use APK."
