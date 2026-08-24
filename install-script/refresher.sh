#!/usr/bin/env bash
# refresher.sh
# Refreshes all config files like grub and mkinitcpio etc

# ── Colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Refresh ───────────────────────────────────────────────────────────────

echo -e "${GREEN} reloading mkinitcpio.conf"

sudo mkinitcpio -P

echo -e "${GREEN} reloading grub"

sudo grub-mkconfig -o /boot/grub/grub.cfg

echo "splash" > /etc/kernel/cmdline
