#!/usr/bin/env bash
# Power menu using rofi for Hyprland with Tokyo Night styling

if pgrep -x rofi >/dev/null; then
    killall rofi
    exit 0
fi

entries="⏻ Shutdown\n⏼ Suspend\n Reboot\n󰍃 Logout\n Lock"

theme='
* {
    font: "FiraCode Nerd Font 11";
    background-color: transparent;
    text-color: #c0caf5;
}
window {
    width: 240px;
    border: 1px;
    border-radius: 16px;
    border-color: rgba(122, 162, 247, 0.35);
    background-color: rgba(15, 17, 26, 0.82);
    padding: 16px;
}
mainbox {
    children: [ "listview" ];
}
listview {
    columns: 1;
    lines: 5;
    spacing: 6px;
    scrollbar: false;
}
element {
    padding: 10px 14px;
    border-radius: 10px;
    text-color: #a9b1d6;
}
element selected.normal {
    background-color: rgba(247, 118, 142, 0.20);
    text-color: #ff9e9e;
    border: 1px;
    border-color: rgba(247, 118, 142, 0.45);
}
element-text {
    vertical-align: 0.5;
}
'

selected=$(echo -e "$entries" | rofi -dmenu -p "Power" -theme-str "$theme" 2>/dev/null)

case "$selected" in
    "⏻ Shutdown")  systemctl poweroff ;;
    "⏼ Suspend")   systemctl suspend ;;
    " Reboot")    systemctl reboot ;;
    "󰍃 Logout")    hyprctl dispatch exit ;;
    " Lock")      hyprlock ;;
esac
