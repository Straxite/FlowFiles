#!/usr/bin/env bash
# deploy-files.sh
# Deploys all dotfiles from ~/FlowFiles to their designated locations

# ── Colors ────────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Paths ─────────────────────────────────────────────────────────────────────
REPO_DIR="$HOME/FlowFiles"
CONFIG_DIR="$HOME/.config"
LOCAL_DIR="$HOME/.local"
HOME_DIR="$HOME"

# ── Helpers ───────────────────────────────────────────────────────────────────
print_header() {
    echo -e "\n${BOLD}${BLUE}==> $1${RESET}"
}

deploy_dir() {
    local src="$1"
    local dest="$2"
    local name="$(basename "$src")"

    if [ ! -d "$src" ]; then
        echo -e "  ${RED}[MISSING]${RESET}  $name (not found in repo, skipping)"
        return
    fi

    mkdir -p "$dest"
    cp -rf "$src/." "$dest/"
    echo -e "  ${GREEN}[OK]${RESET}  $name  →  $dest"
}

deploy_file() {
    local src="$1"
    local dest="$2"
    local name="$(basename "$src")"

    if [ ! -f "$src" ]; then
        echo -e "  ${RED}[MISSING]${RESET}  $name (not found in repo, skipping)"
        return
    fi

    mkdir -p "$(dirname "$dest")"
    cp -f "$src" "$dest"
    echo -e "  ${GREEN}[OK]${RESET}  $name  →  $dest"
}

# ── Preflight ─────────────────────────────────────────────────────────────────
echo -e "${BOLD}${BLUE}"
echo "  ╔══════════════════════════════════════╗"
echo "  ║           FLOW-OS Installer          ║"
echo "  ║          Dotfiles Deployment         ║"
echo "  ╚══════════════════════════════════════╝"
echo -e "${RESET}"

if [ ! -d "$REPO_DIR" ]; then
    echo -e "${RED}[ERROR]${RESET} Repo not found at $REPO_DIR"
    echo -e "        Please clone it first:  git clone <your-repo-url> ~/FlowFiles"
    exit 1
fi

# ── Deploy ~/.config folders ──────────────────────────────────────────────────
print_header "Deploying ~/.config folders"

CONFIG_FOLDERS=(
    backgrounds
    cava
    colorschemes
    gtk-3.0
    gtk-4.0
    hypr
    kitty
    matugen
    nvim
    rofi
    swaync
    waybar
    wlogout
    fastfetch
)

for folder in "${CONFIG_FOLDERS[@]}"; do
    deploy_dir "$REPO_DIR/$folder" "$CONFIG_DIR/$folder"
done

# ── Deploy ~/.local ───────────────────────────────────────────────────────────
print_header "Deploying ~/.local"
deploy_dir "$REPO_DIR/.local" "$LOCAL_DIR"

# ── Deploy home dotfiles ──────────────────────────────────────────────────────
print_header "Deploying home dotfiles"
deploy_file "$REPO_DIR/.p10k.zsh" "$HOME_DIR/.p10k.zsh"
deploy_file "$REPO_DIR/.zshrc"    "$HOME_DIR/.zshrc"

# ── Done ──────────────────────────────────────────────────────────────────────
echo -e "\n${BOLD}${GREEN}==> All files deployed successfully!${RESET}\n"
