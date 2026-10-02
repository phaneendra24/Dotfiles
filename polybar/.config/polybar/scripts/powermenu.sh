#!/usr/bin/env bash
# ==============================================================================
# powermenu.sh — Rofi-Powered Session Power Menu for Polybar
# ==============================================================================
# Presents an interactive power menu using Rofi:
#   - Lock:     i3lock -c 0c1016
#   - Logout:   i3-msg exit
#   - Suspend:  systemctl suspend
#   - Reboot:   systemctl reboot
#   - Shutdown: systemctl poweroff
# ==============================================================================

set -u

# Require rofi
if ! command -v rofi >/dev/null 2>&1; then
  exit 0
fi

# Define power menu options
lock="󰌾  Lock"
logout="󰍃  Logout"
suspend="󰒲  Suspend"
reboot="󰜉  Reboot"
shutdown="󰐥  Shutdown"

# Prompt user via rofi
chosen="$(printf '%s\n%s\n%s\n%s\n%s\n' "$lock" "$logout" "$suspend" "$reboot" "$shutdown" | \
  rofi -dmenu -i -p 'Power' -theme-str 'window {width: 250px;}' -theme-str 'listview {lines: 5;}')"

case "$chosen" in
  *"Lock"*)
    if command -v i3lock >/dev/null 2>&1; then
      i3lock -c 0c1016
    fi
    ;;
  *"Logout"*)
    if command -v i3-msg >/dev/null 2>&1; then
      i3-msg exit
    fi
    ;;
  *"Suspend"*)
    systemctl suspend
    ;;
  *"Reboot"*)
    systemctl reboot
    ;;
  *"Shutdown"*)
    systemctl poweroff
    ;;
  *)
    exit 0
    ;;
esac
