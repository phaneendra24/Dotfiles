#!/usr/bin/env bash
# ==============================================================================
# toggle-dnd.sh — Toggle Dunst Do-Not-Disturb with Polybar IPC
# ==============================================================================
# Toggles notification pausing in Dunst and updates the Polybar module hook:
#   - Exits with 1 if dunstctl is not installed
#   - Toggles paused state via dunstctl set-paused toggle
#   - If paused (true): triggers polybar-msg action "#dnd.hook.1"
#   - If not paused (false): triggers polybar-msg action "#dnd.hook.0"
# ==============================================================================

set -u

# Check if dunstctl is installed; exit 1 if missing
if ! command -v dunstctl >/dev/null 2>&1; then
  exit 1
fi

# Toggle paused state
dunstctl set-paused toggle 2>/dev/null || true

# Check new paused state
is_paused="$(dunstctl is-paused 2>/dev/null || true)"

# Update Polybar DND hook via IPC if polybar-msg is available
if command -v polybar-msg >/dev/null 2>&1; then
  if [ "$is_paused" = "true" ]; then
    polybar-msg action "#dnd.hook.1" 2>/dev/null || true
  else
    polybar-msg action "#dnd.hook.0" 2>/dev/null || true
  fi
fi
