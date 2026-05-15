#!/usr/bin/env bash

set -euo pipefail

if ! command -v flatpak >/dev/null 2>&1; then
    exit 0
fi

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

FLATPAKS=(
    com.visualstudio.code
    com.usebottles.bottles
    net.lutris.Lutris
    com.heroicgameslauncher.hgl
    net.davidotek.pupgui2
)

flatpak install -y --noninteractive flathub "${FLATPAKS[@]}" || true
