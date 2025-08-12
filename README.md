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

### Instalação via .deb (recomendado)

```bash
sudo apt install ./whatsapp-waydroid_1.0.0_amd64.deb
```

O script de pós-instalação atualiza caches de ícones e desktop. Após instalar:

- Inicialize o Waydroid (se ainda não feito):
  ```bash
  sudo waydroid init
  ```
- Inicie a sessão:
  ```bash
  waydroid session start
  ```
- Instale o WhatsApp no Waydroid (UI ou APK) e abra “WhatsApp (Waydroid)” no menu.

## Instalação rápida (passo a passo)

1) Instale o pacote .deb (registra atalho/ícone e binário):
```bash
sudo apt install ./whatsapp-waydroid_1.0.0_amd64.deb
```

2) Inicialize o Waydroid (necessário apenas na primeira vez):
```bash
sudo waydroid init
```

3) Inicie a sessão e abra o app:
```bash
waydroid session start &
whatsapp-waydroid
```

4) Se o WhatsApp Android não estiver instalado no Waydroid, instale via Play/Aurora ou APK:
```bash
./scripts/install-apk.sh /caminho/para/WhatsApp.apk
```

Pronto. A partir daí, use o atalho “WhatsApp (Waydroid)” no menu do sistema.

### Passos opcionais

- Serviço de usuário para iniciar Waydroid na sessão (opcional):
  Crie `~/.config/systemd/user/waydroid-session.service` com:
  ```ini
  [Unit]
  Description=Waydroid session
  After=graphical-session.target

  [Service]
  ExecStart=/usr/bin/waydroid session start
  Restart=on-failure

  [Install]
  WantedBy=default.target
  ```
  E ative:
  ```bash
  systemctl --user daemon-reload
  systemctl --user enable --now waydroid-session.service
  ```

## Diagnóstico e resolução de problemas

Se o comando `whatsapp-waydroid` falhar, rode o diagnóstico:

```bash
./scripts/diagnose.sh
```

Erros comuns e soluções:
- “Waydroid não instalado” ou `waydroid` ausente no PATH:
  ```bash
  sudo apt install waydroid
  ```
- “Sessão do Waydroid não iniciou” ou não está RUNNING:
  ```bash
  sudo waydroid init
  waydroid session start
  ```
  Consulte também módulos do kernel (binder/ashmem) em https://docs.waydro.id/
- “Pacote com.whatsapp não encontrado”: instale via UI do Waydroid (Play/Aurora) ou APK:
  ```bash
  ./scripts/install-apk.sh /caminho/para/WhatsApp.apk
  ```

## Desinstalação

Para remover o launcher instalado via .deb:
```bash
sudo apt remove whatsapp-waydroid
```

Isso removerá o binário, o .desktop e os ícones. As configurações do Waydroid permanecem no sistema.

## Releases automáticas (CI)

Ao criar uma tag `vX.Y.Z`, o GitHub Actions builda e publica o `.deb` nos Releases.

## Contribuições e Issues

Issues são bem-vindas. Use a aba de Issues do GitHub para reportar bugs e sugestões. Templates de Issue estão disponíveis (bug/feature).

## Licença e Autoria

Open Source sob MIT. Mantém autoria e direitos de replicação de Josivan Tarcío. Veja `LICENSE` e `NOTICE`.

Este projeto não é afiliado ao WhatsApp/Meta. "WhatsApp" é marca registrada de seu respectivo titular.
