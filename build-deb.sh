#!/usr/bin/env bash
set -euo pipefail

APP=whatsapp-waydroid
VER=$(cat VERSION)
PKGDIR=pkg-full

rm -rf "$PKGDIR"
mkdir -p "$PKGDIR/DEBIAN" \
         "$PKGDIR/usr/bin" \
         "$PKGDIR/usr/share/applications" \
         "$PKGDIR/usr/share/icons/hicolor/scalable/apps"

# Control
cat > "$PKGDIR/DEBIAN/control" <<EOF
Package: $APP
Version: $VER
Section: utils
Priority: optional
Architecture: amd64
Maintainer: Josivan Tarcío <dev@example.com>
Depends: bash, waydroid
Description: Launcher nativo do WhatsApp via Waydroid
 Integra o WhatsApp oficial (Android) em container Waydroid, com atalho desktop.
EOF

# Scripts maintainer
install -m 0755 debian/scripts/postinst "$PKGDIR/DEBIAN/postinst"
install -m 0755 debian/scripts/postrm "$PKGDIR/DEBIAN/postrm"

# Bin, desktop, ícone
install -m 0755 bin/whatsapp-waydroid "$PKGDIR/usr/bin/whatsapp-waydroid"
install -m 0644 WhatsApp-Waydroid.desktop "$PKGDIR/usr/share/applications/WhatsApp-Waydroid.desktop"
if [ -f assets/icon.svg ]; then
  install -m 0644 assets/icon.svg "$PKGDIR/usr/share/icons/hicolor/scalable/apps/whatsapp-waydroid.svg"
fi

fakeroot dpkg-deb --build "$PKGDIR" ${APP}_${VER}_amd64.deb
