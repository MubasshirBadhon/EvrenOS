#!/usr/bin/env bash

set -euo pipefail

STATE_FILE="/var/lib/evrenos/.firstboot-complete"
mkdir -p /var/lib/evrenos

if [[ -f "${STATE_FILE}" ]]; then
    exit 0
fi

echo "Welcome to EvrenOS — immutable, gaming-ready, and Android-capable." | systemd-cat -t evrenos-firstboot

/usr/local/bin/evrenos-install-flatpaks || true

touch "${STATE_FILE}"
