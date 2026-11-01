#!/usr/bin/env bash

## Toggle: if rofi is already running, close it
if pgrep -x rofi >/dev/null; then
    killall rofi
    exit 0
fi

dir="$HOME/.config/rofi/launchers/type-1"
theme='style-16'

## Launch Rofi with modern Tokyo Night glassmorphism theme
exec rofi \
    -no-config \
    -terminal ghostty \
    -show drun \
    -theme "${dir}/${theme}.rasi"
