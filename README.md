# 🎨 Dotfiles

Personal dotfiles for a riced i3 setup with Catppuccin Mocha theme.

![i3wm](https://img.shields.io/badge/WM-i3-blue?style=flat-square)
![Polybar](https://img.shields.io/badge/Bar-Polybar-green?style=flat-square)
![Catppuccin](https://img.shields.io/badge/Theme-Catppuccin%20Mocha-pink?style=flat-square)

## 📦 Required Packages

### Core (Essential)

```bash
# Ubuntu/Debian
sudo apt install i3 polybar picom rofi alacritty neovim tmux zsh stow

# Arch
sudo pacman -S i3-wm polybar picom rofi alacritty neovim tmux zsh stow
```

| Package     | Description                             |
| ----------- | --------------------------------------- |
| `i3`        | Tiling window manager (v4.22+ for gaps) |
| `polybar`   | Status bar                              |
| `picom`     | Compositor (rounded corners, shadows)   |
| `rofi`      | Application launcher                    |
| `alacritty` | GPU-accelerated terminal                |
| `neovim`    | Text editor                             |
| `tmux`      | Terminal multiplexer                    |
| `zsh`       | Shell                                   |
| `stow`      | Symlink manager for dotfiles            |

### Utilities & Polybar Modules

```bash
# Ubuntu/Debian
sudo apt install brightnessctl flameshot dunst nitrogen network-manager i3lock xss-lock dex playerctl jq xdotool fonts-font-awesome

# Arch
sudo pacman -S brightnessctl flameshot dunst nitrogen networkmanager i3lock xss-lock dex playerctl jq xdotool ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols-mono otf-font-awesome
```

> **Tip:** You can also run `./polybar/.config/polybar/setup.sh` to automatically install all dependencies for your system!

| Package                   | Description                                     |
| ------------------------- | ----------------------------------------------- |
| `brightnessctl`           | Screen brightness control                       |
| `flameshot`               | Screenshot tool                                 |
| `dunst`                   | Notification daemon (with Polybar DND toggle)   |
| `nitrogen`                | Wallpaper manager                               |
| `network-manager`         | Network management                              |
| `nm-applet`               | NetworkManager tray icon                        |
| `i3lock`                  | Screen locker                                   |
| `xss-lock`                | Auto-lock on suspend                            |
| `dex`                     | XDG autostart                                   |
| `pulseaudio` / `pipewire` | Audio (+ `pavucontrol` for GUI)                 |
| `playerctl`               | Media player controller (Polybar music module)  |
| `jq`                      | JSON parsing for Polybar GitHub/VPN scripts     |
| `xdotool`                 | Window tracking for Polybar active Git status   |

### Fonts

```bash
# Arch:
sudo pacman -S ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols-mono otf-font-awesome

# Ubuntu/Debian / Manual:
# Download JetBrainsMono Nerd Font & Symbols Nerd Font Mono from:
# https://www.nerdfonts.com/font-downloads
# Extract to ~/.local/share/fonts/ and run fc-cache -fv
```

### Optional

| Package          | Description          |
| ---------------- | -------------------- |
| `kdeconnect`     | Phone integration    |
| `zoxide`         | Smarter cd command   |
| `fzf`            | Fuzzy finder         |
| `bat` / `batcat` | Better cat           |
| `nvm`            | Node version manager |
| `bun`            | JavaScript runtime   |

### Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## 🚀 Installation

```bash
# Clone the repo
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Stow all configs
stow alacritty i3 nvim picom polybar rofi shell tmux

# Reload i3
i3-msg reload
```

## 📁 Structure

```
dotfiles/
├── alacritty/     # Terminal config
├── i3/            # i3wm config (gaps, keybinds)
├── nvim/          # Neovim config
├── picom/         # Compositor (rounded corners, blur)
├── polybar/       # Status bar (Storm Forge floating pill design)
├── rofi/          # App launcher
├── shell/         # .zshrc
└── tmux/          # Tmux config
```

## ⌨️ Key Bindings

| Keybind          | Action                 |
| ---------------- | ---------------------- |
| `$mod + Return`  | Open terminal          |
| `$mod + d`       | Rofi launcher          |
| `$mod + q`       | Lock screen            |
| `$mod + w`       | Kill window            |
| `$mod + Shift+s` | Screenshot (flameshot) |
| `$mod + grave`   | Open Chrome            |
| `$mod + h/j/k/l` | Vim-style focus        |
| `$mod + 1-9`     | Switch workspace       |

## 🎨 Theme

- **Color Scheme**: Storm (void black `#101016`, lightning gold `#f4d06f`, ember `#c54f3b`)
- **Gaps**: Inner 8px, Outer 4px, Top 42px (reserves space for floating bar)
- **Corners**: 18px radius (picom)
- **Bar**: Storm Forge Polybar ([documentation](polybar/README.md)) with floating pill capsules & developer modules
