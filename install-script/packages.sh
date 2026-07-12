#!/usr/bin/env bash
# install-packages.sh
# Installs all required packages for the Hyprland setup

# ── Colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Package lists ─────────────────────────────────────────────────────────────
PACMAN_PACKAGES=(
    awww
    hyprlock
    wlogout
    xdg-desktop-portal-gnome
    matugen
    cava
    rofi
    flatpak
    yazi
    htop
    nwg-look
    zsh
    waybar
)

AUR_PACKAGES=(
    helium-browser-bin
    lutgen-studio-bin
    peaclock
    bluetuith
    adw-gtk-theme-git
)

# ── Helpers ───────────────────────────────────────────────────────────────────
print_header() {
    echo -e "\n${BOLD}${BLUE}==> $1${RESET}"
}

is_installed() {
    pacman -Qi "$1" &>/dev/null
}

install_pacman() {
    local pkg="$1"
    if is_installed "$pkg"; then
        echo -e "  ${YELLOW}[SKIP]${RESET}  $pkg (already installed)"
    else
        echo -e "  ${BLUE}[INSTALLING]${RESET}  $pkg"
        sudo pacman -S --noconfirm "$pkg"
        if is_installed "$pkg"; then
            echo -e "  ${GREEN}[OK]${RESET}  $pkg"
        else
            echo -e "  ${RED}[FAILED]${RESET}  $pkg"
        fi
    fi
}

install_aur() {
    local pkg="$1"
    if is_installed "$pkg"; then
        echo -e "  ${YELLOW}[SKIP]${RESET}  $pkg (already installed)"
    else
        echo -e "  ${BLUE}[INSTALLING]${RESET}  $pkg"
        yay -S --noconfirm "$pkg"
        if is_installed "$pkg"; then
            echo -e "  ${GREEN}[OK]${RESET}  $pkg"
        else
            echo -e "  ${RED}[FAILED]${RESET}  $pkg"
        fi
    fi
}

# ── Preflight ─────────────────────────────────────────────────────────────────
echo -e "${BOLD}${BLUE}"
echo "  ╔══════════════════════════════════════╗"
echo "  ║           FLOW-OS Installer          ║"
echo "  ║          Package Installation        ║"
echo "  ╚══════════════════════════════════════╝"
echo -e "${RESET}"

# Check yay is available
if ! command -v yay &>/dev/null; then
    echo -e "${RED}[ERROR]${RESET} yay not found. Please install yay first."
    exit 1
fi

# ── Install ───────────────────────────────────────────────────────────────────
print_header "Installing pacman packages"
for pkg in "${PACMAN_PACKAGES[@]}"; do
    install_pacman "$pkg"
done

print_header "Installing AUR packages"
for pkg in "${AUR_PACKAGES[@]}"; do
    install_aur "$pkg"
done

# ── Summary ───────────────────────────────────────────────────────────────────
echo -e "\n${BOLD}${GREEN}==> All done!${RESET}"
