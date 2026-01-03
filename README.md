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

### Utilities

```bash
# Ubuntu/Debian
sudo apt install brightnessctl flameshot dunst nitrogen network-manager i3lock xss-lock dex

# Arch
sudo pacman -S brightnessctl flameshot dunst nitrogen networkmanager i3lock xss-lock dex
```

| Package                   | Description                     |
| ------------------------- | ------------------------------- |
| `brightnessctl`           | Screen brightness control       |
| `flameshot`               | Screenshot tool                 |
| `dunst`                   | Notification daemon             |
| `nitrogen`                | Wallpaper manager               |
| `network-manager`         | Network management              |
| `nm-applet`               | NetworkManager tray icon        |
| `i3lock`                  | Screen locker                   |
| `xss-lock`                | Auto-lock on suspend            |
| `dex`                     | XDG autostart                   |
| `pulseaudio` / `pipewire` | Audio (+ `pavucontrol` for GUI) |

### Fonts

```bash
# Ubuntu/Debian - Install Nerd Font for polybar icons
sudo apt install fonts-jetbrains-mono

# Or download JetBrainsMono Nerd Font from:
# https://www.nerdfonts.com/font-downloads
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
├── picom/         # Compositor (rounded corners)
├── polybar/       # Status bar (Catppuccin theme)
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

- **Color Scheme**: Catppuccin Mocha
- **Gaps**: Inner 8px, Outer 4px
- **Corners**: 10px radius (picom)
- **Bar**: Polybar with developer modules
