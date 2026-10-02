#!/usr/bin/env bash
# ==============================================================================
# github-notifications.sh — Polybar GitHub Notification Count
# ==============================================================================
# Queries GitHub API for unread notifications:
#   - Reads API token from ~/.config/polybar/scripts/.github_token
#   - Exits silently (exit 0) if token file does not exist
#   - Requires jq and curl
#   - Output formats:
#       count > 0: %{F#ff6b6b} N%{F-}
#       count = 0:  0
#       error:      ?
# ==============================================================================

set -u

TOKEN_FILE="${HOME}/.config/polybar/scripts/.github_token"

# Exit silently if token file does not exist
if [ ! -f "$TOKEN_FILE" ]; then
  exit 0
fi

# Trim whitespace from token
token="$(tr -d '[:space:]' < "$TOKEN_FILE" 2>/dev/null || true)"
if [ -z "$token" ]; then
  exit 0
fi

# Require jq and curl
if ! command -v jq >/dev/null 2>&1 || ! command -v curl >/dev/null 2>&1; then
  exit 0
fi

# Query GitHub notifications API
response="$(curl -s --max-time 10 \
  -H "Authorization: token ${token}" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/notifications 2>/dev/null || true)"

# Parse array length with jq; returns empty if not a JSON array
count="$(printf '%s' "$response" | jq 'if type=="array" then length else empty end' 2>/dev/null || true)"

if [ -z "$count" ]; then
  printf ' ?\n'
  exit 0
fi

if [ "$count" -gt 0 ]; then
  printf '%%{F#ff6b6b} %d%%{F-}\n' "$count"
else
  printf ' 0\n'
fi
