#!/usr/bin/env bash
# ==============================================================================
# Storm Forge Polybar — Dependency Installer
# ==============================================================================
#
# DEPENDENCY OVERVIEW
# -------------------
# 1. Core (required):
#    - polybar: Fast, customizable desktop status bar
#    - i3-wm / i3-gaps: Tiling window manager
#    - picom: Compositor providing rounded corners, blur, and opacity
#    - rofi: Application launcher and power menu selector
#    - dunst: Lightweight desktop notification daemon
#    - alacritty: GPU-accelerated terminal emulator
#
# 2. Polybar Modules (required for script features):
#    - playerctl: Media player control and metadata querying
#    - jq: Lightweight JSON parser for GitHub API & Tailscale
#    - brightnessctl: Screen backlight brightness control
#    - networkmanager: Network status and nmcli tool
#    - pulseaudio (or pipewire-pulse): Volume and audio sink management
#    - xdotool: X11 window inspector for git-status focused terminal PID
#
# 3. Optional utilities:
#    - zscroll-git: Smooth text scrolling for media player status
#    - lazygit: Terminal UI for git
#    - lazydocker: Terminal UI for Docker containers
#    - flameshot: Screen capture utility
#    - nitrogen: Fast wallpaper setter
#    - redshift: Screen color temperature adjuster
#
# 4. Fonts:
#    - JetBrainsMono Nerd Font: Primary monospace font with icons
#    - Symbols Nerd Font Mono: Dedicated icon glyphs
#    - Font Awesome 6 Free: Standard icon set
#
# ==============================================================================

set -euo pipefail

# ANSI color codes for rich CLI presentation
BOLD='\033[1m'
GOLD='\033[38;2;244;208;111m'
CYAN='\033[38;2;143;191;193m'
GREEN='\033[38;2;158;208;114m'
RED='\033[38;2;255;107;107m'
RESET='\033[0m'

print_banner() {
  printf "${GOLD}${BOLD}"
  printf "╔════════════════════════════════════════════════════════════════════╗\n"
  printf "║            Storm Forge Polybar — Dependency Installer              ║\n"
  printf "╚════════════════════════════════════════════════════════════════════╝\n"
  printf "${RESET}\n"
}

info() {
  printf "${CYAN}[INFO]${RESET} %s\n" "$1"
}

success() {
  printf "${GREEN}[OK]${RESET} %s\n" "$1"
}

warn() {
  printf "${RED}[WARN]${RESET} %s\n" "$1"
}

print_banner

# Detect package manager
info "Detecting system package manager..."

if command -v pacman >/dev/null 2>&1; then
  PKG_MANAGER="pacman"
elif command -v apt-get >/dev/null 2>&1; then
  PKG_MANAGER="apt"
elif command -v dnf >/dev/null 2>&1; then
  PKG_MANAGER="dnf"
else
  warn "Could not automatically identify pacman, apt, or dnf."
  warn "Please install the listed dependencies manually using your distribution's package manager."
  exit 1
fi

success "Detected package manager: ${PKG_MANAGER}"

case "$PKG_MANAGER" in
  pacman)
    info "Installing Core packages, Polybar module tools, and Fonts via pacman..."
    PACMAN_PKGS=(
      polybar
      i3-wm
      picom
      rofi
      dunst
      alacritty
      playerctl
      jq
      brightnessctl
      networkmanager
      pulseaudio
      xdotool
      ttf-jetbrains-mono-nerd
      ttf-nerd-fonts-symbols-mono
      otf-font-awesome
    )

    sudo pacman -S --needed --noconfirm "${PACMAN_PKGS[@]}"
    success "Pacman packages installed successfully."

    # Handle AUR packages (zscroll-git)
    info "Checking for AUR helper (yay / paru) for zscroll-git..."
    if command -v yay >/dev/null 2>&1; then
      info "Installing zscroll-git via yay..."
      yay -S --needed --noconfirm zscroll-git || warn "Failed to install zscroll-git via yay"
    elif command -v paru >/dev/null 2>&1; then
      info "Installing zscroll-git via paru..."
      paru -S --needed --noconfirm zscroll-git || warn "Failed to install zscroll-git via paru"
    else
      warn "Neither yay nor paru was found. Install 'zscroll-git' manually from the AUR for scrolling media titles."
    fi

    # Echo optional packages
    printf "\n"
    info "Optional packages available via pacman/AUR:"
    printf "  • lazygit     (Terminal UI for git: 'sudo pacman -S lazygit')\n"
    printf "  • lazydocker  (Terminal UI for docker: 'yay -S lazydocker')\n"
    printf "  • flameshot   (Screenshot tool: 'sudo pacman -S flameshot')\n"
    printf "  • nitrogen    (Wallpaper manager: 'sudo pacman -S nitrogen')\n"
    printf "  • redshift    (Color temperature: 'sudo pacman -S redshift')\n"
    ;;

  apt)
    info "Updating apt package index..."
    sudo apt-get update -y

    info "Installing Core packages and Polybar module tools via apt..."
    APT_PKGS=(
      polybar
      i3
      picom
      rofi
      dunst
      alacritty
      playerctl
      jq
      brightnessctl
      network-manager
      pulseaudio-utils
      xdotool
      fonts-font-awesome
    )

    sudo apt-get install -y "${APT_PKGS[@]}"
    success "Apt packages installed successfully."

    # Manual Nerd Font installation note
    printf "\n"
    info "NOTE: Nerd Fonts are recommended for Polybar icons."
    printf "  To install JetBrainsMono Nerd Font & Symbols Nerd Font Mono:\n"
    printf "  1. Download zip files from: https://github.com/ryanoasis/nerd-fonts/releases/latest\n"
    printf "  2. Extract .ttf files to ~/.local/share/fonts/\n"
    printf "  3. Rebuild font cache: fc-cache -fv\n"

    # zscroll via pip note
    printf "\n"
    info "NOTE: To enable smooth media title scrolling, install zscroll via pip:"
    printf "  pip install --user zscroll\n"

    # Echo optional packages
    printf "\n"
    info "Optional packages available via apt / manual download:"
    printf "  • lazygit     (https://github.com/jesseduffield/lazygit)\n"
    printf "  • lazydocker  (https://github.com/jesseduffield/lazydocker)\n"
    printf "  • flameshot   (sudo apt install flameshot)\n"
    printf "  • nitrogen    (sudo apt install nitrogen)\n"
    printf "  • redshift    (sudo apt install redshift)\n"
    ;;

  dnf)
    info "Installing Core packages and Polybar module tools via dnf..."
    DNF_PKGS=(
      polybar
      i3
      picom
      rofi
      dunst
      alacritty
      playerctl
      jq
      brightnessctl
      NetworkManager
      pulseaudio-utils
      xdotool
      fontawesome-fonts
    )

    sudo dnf install -y "${DNF_PKGS[@]}"
    success "DNF packages installed successfully."

    # Manual Nerd Font installation note
    printf "\n"
    info "NOTE: Manual Nerd Font installation for Fedora/RHEL:"
    printf "  1. Download JetBrainsMono & Symbols font from https://github.com/ryanoasis/nerd-fonts/releases\n"
    printf "  2. Extract fonts into ~/.local/share/fonts/\n"
    printf "  3. Run: fc-cache -fv\n"

    # zscroll note
    printf "\n"
    info "NOTE: Install zscroll via pip for media scrolling:"
    printf "  pip install --user zscroll\n"

    # Echo optional packages
    printf "\n"
    info "Optional packages available via dnf / manual download:"
    printf "  • lazygit     (sudo dnf install lazygit)\n"
    printf "  • lazydocker  (https://github.com/jesseduffield/lazydocker)\n"
    printf "  • flameshot   (sudo dnf install flameshot)\n"
    printf "  • nitrogen    (sudo dnf install nitrogen)\n"
    printf "  • redshift    (sudo dnf install redshift)\n"
    ;;
esac

# Make all Polybar scripts executable
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -d "${SCRIPT_DIR}/scripts" ]; then
  chmod +x "${SCRIPT_DIR}/scripts/"*.sh 2>/dev/null || true
  success "Made all helper scripts in scripts/ executable."
fi

# Print Next Steps
printf "\n"
printf "${GOLD}${BOLD}════════════════════════════════════════════════════════════════════${RESET}\n"
printf "${GOLD}${BOLD}                         NEXT STEPS                                 ${RESET}\n"
printf "${GOLD}${BOLD}════════════════════════════════════════════════════════════════════${RESET}\n"
printf "1. Symlink Polybar configuration with GNU Stow:\n"
printf "   ${CYAN}cd ~/Dotfiles && stow polybar${RESET}\n\n"
printf "2. (Optional) Set up GitHub Notifications token:\n"
printf "   ${CYAN}echo \"ghp_your_token_here\" > ~/.config/polybar/scripts/.github_token${RESET}\n"
printf "   ${CYAN}chmod 600 ~/.config/polybar/scripts/.github_token${RESET}\n\n"
printf "3. Restart i3 window manager and launch Polybar:\n"
printf "   ${CYAN}i3-msg restart${RESET}\n"
printf "   or run directly: ${CYAN}~/.config/polybar/launch.sh${RESET}\n\n"
success "Storm Forge Polybar setup complete!"
