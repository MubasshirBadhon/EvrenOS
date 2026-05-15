#!/usr/bin/env bash

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    echo "Please run as root (sudo)."
    exit 1
fi

if [[ -f /var/lib/waydroid/images/system.img ]]; then
    echo "Waydroid is already initialized."
    exit 0
fi

CHANNEL="vanilla"
if [[ "${1:-}" == "--gapps" ]]; then
    CHANNEL="gapps"
elif [[ "${1:-}" == "--microg" ]]; then
    CHANNEL="microg"
fi

case "${CHANNEL}" in
    gapps)
        waydroid init -s GAPPS
        ;;
    microg)
        waydroid init
        echo "Waydroid initialized in vanilla mode. Install microG inside Waydroid after first launch if desired."
        ;;
    *)
        waydroid init
        ;;
esac
