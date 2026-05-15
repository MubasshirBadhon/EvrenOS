#!/bin/bash

set -ouex pipefail

# Core packages layered into the immutable image
CORE_PACKAGES=(
    git
    curl
    wget
    tmux
    zsh
    neovim
    podman
    distrobox
    wine
    winetricks
    lutris
    waydroid
    gamescope
)

dnf5 install -y "${CORE_PACKAGES[@]}"

# Keep podman available for tooling workflows
systemctl enable podman.socket

# Set default shell for newly created users
if [[ -f /etc/default/useradd ]]; then
    sed -i 's|^SHELL=.*|SHELL=/bin/zsh|' /etc/default/useradd
fi

# Install helper scripts
install -Dm755 /ctx/scripts/evrenos-firstboot.sh /usr/local/bin/evrenos-firstboot
install -Dm755 /ctx/scripts/evrenos-install-flatpaks.sh /usr/local/bin/evrenos-install-flatpaks
install -Dm755 /ctx/scripts/evrenos-waydroid-init.sh /usr/local/bin/evrenos-waydroid-init

# Install systemd units
install -Dm644 /ctx/systemd/evrenos-firstboot.service /usr/lib/systemd/system/evrenos-firstboot.service
install -Dm644 /ctx/systemd/evrenos-waydroid-firstboot.service /usr/lib/systemd/system/evrenos-waydroid-firstboot.service
systemctl enable evrenos-firstboot.service
systemctl enable evrenos-waydroid-firstboot.service

# Add desktop launchers for Waydroid setup shortcuts
install -Dm644 /ctx/desktop/evrenos-waydroid-setup.desktop /usr/share/applications/evrenos-waydroid-setup.desktop
install -Dm644 /ctx/desktop/evrenos-waydroid-gapps.desktop /usr/share/applications/evrenos-waydroid-gapps.desktop
