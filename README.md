# EvrenOS

EvrenOS is a custom immutable Atomic Desktop image based on `ghcr.io/ublue-os/bazzite:stable`, focused on:

- Excellent Windows app/game support
- First-class Waydroid Android app support
- A clean developer + gamer friendly setup
- Reproducible, bootc-native image workflows

## Base Image

- `ghcr.io/ublue-os/bazzite:stable`

## Included Customizations

### Branding
- Image name: `evrenos`
- Friendly boot-time welcome via `evrenos-firstboot.service`

### Windows Compatibility Stack
- Layered tools: `wine`, `winetricks`, `lutris`
- First boot Flatpak provisioning for:
  - Bottles (`com.usebottles.bottles`)
  - Heroic (`com.heroicgameslauncher.hgl`)
  - ProtonUp-Qt (`net.davidotek.pupgui2`)
  - Lutris Flatpak (`net.lutris.Lutris`)

Useful commands:
- `just install-bottles`
- `just configure-wine`

### Android (Waydroid)
- Layered `waydroid`
- Automatic first-boot initialization service
- Optional GApps initialization
- Desktop launchers:
  - **EvrenOS Waydroid Setup**
  - **EvrenOS Waydroid Setup (GApps)**

Useful commands:
- `just setup-waydroid`
- `just waydroid-init-gapps`

### Core Tooling
- CLI: `git`, `curl`, `wget`, `tmux`, `zsh`, `neovim`
- Dev: `podman`, `distrobox`, VS Code Flatpak (`com.visualstudio.code`)
- Gaming: Heroic, Lutris, ProtonUp-Qt, `gamescope`
- Default shell for new users set to Zsh (`/bin/zsh`)

## Build and Publish

Build locally:

```bash
just build localhost/evrenos latest
```

Build disk image locally:

```bash
just build-qcow2 localhost/evrenos latest
```

CI workflows:
- `.github/workflows/build.yml` (container image)
- `.github/workflows/build-disk.yml` (disk artifacts)

## Install / Switch

From an existing bootc-capable system:

```bash
sudo bootc switch ghcr.io/<your-github-user>/evrenos:latest
sudo systemctl reboot
```

On first boot, EvrenOS runs setup services to print a welcome message, install core Flatpaks, and initialize Waydroid defaults.
