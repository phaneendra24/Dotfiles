# ⚡ Storm Forge Polybar

A high-performance, developer-centric, aesthetic floating status bar for i3wm. Built with the dark **Storm Forge** palette (`#101016` void background, `#f4d06f` lightning gold accents, `#c54f3b` ember highlights, and `#9ed072` success green).

Designed around a **floating pill architecture** using Powerline rounded glyphs with Dual-Kawase compositor blur for a frosted-glass finish.

---

## 🚀 Quick Setup for New Systems

To set up all dependencies automatically on a new machine, simply run the included installer:

```bash
cd ~/Dotfiles/polybar/.config/polybar
chmod +x setup.sh
./setup.sh
```

The script automatically detects your distribution (`pacman`, `apt`, or `dnf`), installs all required packages and fonts, handles AUR packages (if `yay` or `paru` are present), makes all scripts executable, and guides you through next steps.

---

## 📦 Complete Package Reference

If you prefer to install packages manually or want to understand what each tool does:

### 1. Core Window Manager & Desktop

| Package | Purpose | Arch Linux | Ubuntu / Debian | Fedora |
| :--- | :--- | :--- | :--- | :--- |
| **polybar** | The status bar itself | `sudo pacman -S polybar` | `sudo apt install polybar` | `sudo dnf install polybar` |
| **i3-wm** | Tiling window manager | `sudo pacman -S i3-wm` | `sudo apt install i3` | `sudo dnf install i3` |
| **picom** | Compositor (blur, shadows, rounded corners) | `sudo pacman -S picom` | `sudo apt install picom` | `sudo dnf install picom` |
| **rofi** | Application launcher & power menu | `sudo pacman -S rofi` | `sudo apt install rofi` | `sudo dnf install rofi` |
| **dunst** | Notification daemon (works with DND toggle) | `sudo pacman -S dunst` | `sudo apt install dunst` | `sudo dnf install dunst` |
| **alacritty** | Terminal emulator | `sudo pacman -S alacritty` | `sudo apt install alacritty` | `sudo dnf install alacritty` |

### 2. Polybar Module Utilities (Required for full functionality)

| Package | Used By Module | Purpose | Arch Linux | Ubuntu / Debian | Fedora |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **playerctl** | `media` | Control and query Spotify, browsers, VLC, etc. | `sudo pacman -S playerctl` | `sudo apt install playerctl` | `sudo dnf install playerctl` |
| **jq** | `github`, `vpn` | JSON parsing for API and status payloads | `sudo pacman -S jq` | `sudo apt install jq` | `sudo dnf install jq` |
| **xdotool** | `git` | Detects active terminal window PID and working directory | `sudo pacman -S xdotool` | `sudo apt install xdotool` | `sudo dnf install xdotool` |
| **brightnessctl** | `backlight` | Display backlight level and adjustments | `sudo pacman -S brightnessctl` | `sudo apt install brightnessctl` | `sudo dnf install brightnessctl` |
| **networkmanager** | `wifi`, `vpn` | Wi-Fi status, signal strength, and VPN connections | `sudo pacman -S networkmanager` | `sudo apt install network-manager` | `sudo dnf install NetworkManager` |
| **pulseaudio** / **pipewire** | `pulseaudio` | Audio volume and mute control | `sudo pacman -S pulseaudio` | `sudo apt install pulseaudio-utils` | `sudo dnf install pulseaudio-utils` |

### 3. Fonts (Crucial for icons & pill caps)

Polybar uses a 4-tier font stack:

```ini
font-0 = "JetBrainsMono Nerd Font:style=Medium:size=10;4"  ; Text
font-1 = "JetBrainsMono Nerd Font:size=19;5"               ; Powerline round caps ( / )
font-2 = "Symbols Nerd Font Mono:size=13;4"               ; Primary Nerd Font icons
font-3 = "Font Awesome 6 Free:style=Solid:size=11;4"      ; Fallback icons
```

- **Arch Linux:**
  ```bash
  sudo pacman -S ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols-mono otf-font-awesome
  ```
- **Ubuntu / Debian / Fedora:**
  1. Download JetBrainsMono & Symbols from [Nerd Fonts Releases](https://github.com/ryanoasis/nerd-fonts/releases/latest)
  2. Extract `.ttf` / `.otf` files into `~/.local/share/fonts/`
  3. Rebuild font cache: `fc-cache -fv`

### 4. Optional Enhancements

| Tool | Benefit | How to Install |
| :--- | :--- | :--- |
| **zscroll** | Smooth marquee scrolling for media player titles | `yay -S zscroll-git` or `pip install --user zscroll` |
| **lazygit** | Opened on click by the `git` polybar module | `sudo pacman -S lazygit` or from GitHub releases |
| **lazydocker** | Opened on click by the `docker` polybar module | `yay -S lazydocker` or from GitHub releases |
| **pavucontrol** | GUI volume mixer opened on right-click of volume | `sudo pacman -S pavucontrol` or `sudo apt install pavucontrol` |
| **nm-connection-editor** | GUI network config opened on click of Wi-Fi | `sudo pacman -S nm-connection-editor` or `sudo apt install nm-connection-editor` |

---

## 🗂 Configuration Structure

The configuration is modularized for clarity and easy maintenance:

```
polybar/.config/polybar/
├── config.ini         # Main bar geometry, font definitions, and module ordering
├── colors.ini         # Storm Forge palette (single source of truth)
├── modules.ini        # System modules (workspaces, CPU, RAM, disk, battery, audio)
├── user_modules.ini   # Developer modules (git, docker, github, media, dnd, vpn, power)
├── launch.sh          # Multi-monitor detection and launch script
├── setup.sh           # Automated dependency installer for new systems
└── scripts/
    ├── docker-status.sh        # Running container count
    ├── git-status.sh           # Focused terminal's Git branch + dirty status
    ├── github-notifications.sh # Unread GitHub notifications counter
    ├── powermenu.sh            # Rofi session menu (Lock, Logout, Suspend, Reboot, Off)
    ├── scroll_player_status.sh # Scrolling track title with playerctl + zscroll
    ├── toggle-dnd.sh           # Instant Dunst Do-Not-Disturb toggle via IPC
    ├── vpn-status.sh           # Tailscale, WireGuard, and NetworkManager VPN state
    └── wifi-status.sh          # Wi-Fi SSID and signal strength ladder
```

---

## 💡 Developer Module Features & Shortcuts

- **Media Player (`media`)**:
  - `Left Click`: Play / Pause
  - `Right Click`: Next track
  - `Middle Click`: Previous track
- **Git Status (`git`)**:
  - Shows active branch and `*` if working tree is dirty for whichever terminal is focused.
  - `Left Click`: Launches `lazygit` in a terminal.
- **Docker Monitor (`docker`)**:
  - Displays count of active containers (`󰡨 3`) or `󰡨 off` when the daemon is stopped.
  - `Left Click`: Launches `lazydocker` in a terminal.
- **GitHub Notifications (`github`)**:
  - Shows count of unread notifications.
  - To enable, store a personal access token:
    ```bash
    echo "ghp_your_token_here" > ~/.config/polybar/scripts/.github_token
    chmod 600 ~/.config/polybar/scripts/.github_token
    ```
  - `Left Click`: Opens `https://github.com/notifications` in your default browser.
- **Do Not Disturb (`dnd`)**:
  - Instant IPC module. `󰂚` (green) = notifications active; `󰂛` (red) = notifications paused.
  - `Left Click`: Toggles Dunst pause state instantly without waiting for an interval.
- **Power Menu (`powermenu`)**:
  - `Left Click`: Opens a compact Rofi dialog to Lock, Logout, Suspend, Reboot, or Shutdown.
