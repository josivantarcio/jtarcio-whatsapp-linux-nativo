# WhatsApp Ubuntu (Nativo via Waydroid)

Projeto que integra o WhatsApp oficial para Android rodando em Waydroid (Android em container), com launcher, atalho .desktop e GUI GTK opcional. Não usa WebView.

• Autor: Josivan Tarcío — 2025

## Pré-requisitos

- Ubuntu 22.04/24.04
- Waydroid instalado e inicializado (requer sudo e módulos binder/ashmem)
- WhatsApp (Android) instalado no Waydroid (Aurora Store/Play Store ou via APK)

### Instalar Waydroid

```bash
cd scripts
./setup-waydroid.sh
```

Se houver mensagens sobre LXD, binder/ashmem ou permissões, consulte: https://docs.waydro.id/

## Uso rápido

- Launcher:
  ```bash
  ~/.local/bin/whatsapp-waydroid
  ```

- GUI GTK (opcional):
  ```bash
  python3 app.py
  ```

- Instalar APK manualmente:
  ```bash
  ./scripts/install-apk.sh /caminho/para/WhatsApp.apk
  ```

- Reinstalar/atualizar atalho (ícone SVG/PNG):
  ```bash
  ./install.sh
  ```

## Pacote .deb simples

Um .deb do launcher pode ser gerado em `whatsapp-waydroid_1.0.0_amd64.deb` para instalação do binário e do .desktop em `/usr/local/bin` e `/usr/share/applications`.

## Releases automáticas (CI)

Ao criar uma tag `vX.Y.Z`, o GitHub Actions builda e publica o `.deb` nos Releases.

## Contribuições e Issues

Issues são bem-vindas. Use a aba de Issues do GitHub para reportar bugs e sugestões. Templates de Issue estão disponíveis (bug/feature).

## Licença e Autoria

Open Source sob MIT. Mantém autoria e direitos de replicação de Josivan Tarcío. Veja `LICENSE` e `NOTICE`.

Este projeto não é afiliado ao WhatsApp/Meta. "WhatsApp" é marca registrada de seu respectivo titular.
