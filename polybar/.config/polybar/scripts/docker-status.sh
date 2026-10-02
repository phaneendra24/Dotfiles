#!/usr/bin/env bash
# ==============================================================================
# docker-status.sh — Polybar Docker Status Module
# ==============================================================================
# Shows the count of currently running Docker containers:
#   - If docker command missing: exits cleanly (exit 0)
#   - If daemon not running: %{F#5a4f42}󰡨 off%{F-}
#   - If running containers > 0: %{F#8fbfc1}󰡨 N%{F-}
#   - If 0 containers: 󰡨 0
# ==============================================================================

set -u

# Check if docker command exists
if ! command -v docker >/dev/null 2>&1; then
  exit 0
fi

# Verify docker daemon is running and reachable
if ! docker info >/dev/null 2>&1; then
  printf '%%{F#5a4f42}󰡨 off%%{F-}\n'
  exit 0
fi

# Count running containers
running_count="$(docker ps -q 2>/dev/null | grep -c . || true)"

if [ "$running_count" -gt 0 ]; then
  printf '%%{F#8fbfc1}󰡨 %d%%{F-}\n' "$running_count"
else
  printf '󰡨 0\n'
fi
