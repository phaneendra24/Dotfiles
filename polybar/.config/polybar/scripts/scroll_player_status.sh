#!/usr/bin/env bash
# ==============================================================================
# scroll_player_status.sh — Polybar Media Player Status (zscroll + playerctl)
# ==============================================================================
# Displays currently playing media track information:
#   - Exits cleanly (exit 0) if playerctl is missing or no player is active
#   - If zscroll is installed: scrolls active tracks smoothly (length 25, delay 0.3)
#   - If zscroll is unavailable: static fallback formatted as "artist — title"
#     truncated to 30 characters with '...' suffix.
# ==============================================================================

set -u

# Require playerctl
if ! command -v playerctl >/dev/null 2>&1; then
  exit 0
fi

# Exit if no player is active or running
if ! playerctl status >/dev/null 2>&1; then
  exit 0
fi

if command -v zscroll >/dev/null 2>&1; then
  zscroll -l 25 \
    --delay 0.3 \
    --scroll-padding "   ·   " \
    --match-command "playerctl status 2>/dev/null" \
    --match-text "Playing" "--scroll 1" \
    --match-text "Paused" "--scroll 0" \
    --update-check true \
    "playerctl metadata --format '{{ artist }} — {{ title }}' 2>/dev/null" &
  wait
else
  # Static fallback
  artist="$(playerctl metadata artist 2>/dev/null || true)"
  title="$(playerctl metadata title 2>/dev/null || true)"

  if [ -n "$artist" ] && [ -n "$title" ]; then
    text="${artist} — ${title}"
  elif [ -n "$title" ]; then
    text="${title}"
  elif [ -n "$artist" ]; then
    text="${artist}"
  else
    text="$(playerctl metadata --format '{{ artist }} — {{ title }}' 2>/dev/null || true)"
  fi

  if [ -z "$text" ] || [ "$text" = " — " ]; then
    exit 0
  fi

  if [ "${#text}" -gt 30 ]; then
    printf '%s...\n' "${text:0:27}"
  else
    printf '%s\n' "$text"
  fi
fi
