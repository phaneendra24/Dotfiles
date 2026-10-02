#!/usr/bin/env bash
#
# Storm Forge — Polybar Launcher
#

CONFIG="/home/phaneendra/Dotfiles/polybar/.config/polybar/config.ini"

# Terminate already running bar instances
killall -q polybar 2>/dev/null || true
pkill -x polybar 2>/dev/null || true

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do
    sleep 0.2
done

# Launch polybar on all connected monitors
if command -v xrandr >/dev/null 2>&1; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR="$m" polybar --reload --config="$CONFIG" main & disown
    done
else
    polybar --reload --config="$CONFIG" main & disown
fi

echo "Storm Forge polybar launched."
