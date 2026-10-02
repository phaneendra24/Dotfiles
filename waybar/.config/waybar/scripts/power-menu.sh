#!/usr/bin/env bash
# Power menu using rofi for Hyprland

entries="⏻ Shutdown\n⏼ Suspend\n Reboot\n󰍃 Logout\n Lock"

selected=$(echo -e "$entries" | rofi -dmenu -p "Power" -theme-str 'window {width: 200px;}' 2>/dev/null)

case "$selected" in
    "⏻ Shutdown")  systemctl poweroff ;;
    "⏼ Suspend")   systemctl suspend ;;
    " Reboot")    systemctl reboot ;;
    "󰍃 Logout")    hyprctl dispatch exit ;;
    " Lock")      hyprlock 2>/dev/null || swaylock 2>/dev/null ;;
esac
