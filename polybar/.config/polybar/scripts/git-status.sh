#!/usr/bin/env bash
# ==============================================================================
# git-status.sh — Polybar Git Status for Active Terminal
# ==============================================================================
# Detects the focused terminal emulator's working directory via xdotool and /proc,
# inspects child shell processes, and displays:
#   - Current git branch (with  icon, Unicode E0A0)
#   - Dirty working tree indicator (*)
#   - Upstream sync status (↑N ahead, ↓N behind)
# Exits cleanly with no output if not in a git repository or tools are missing.
# ==============================================================================

set -u

# Require git and xdotool
if ! command -v git >/dev/null 2>&1 || ! command -v xdotool >/dev/null 2>&1; then
  exit 0
fi

# Obtain the active window ID and its root PID
active_win="$(xdotool getactivewindow 2>/dev/null || true)"
if [ -z "$active_win" ]; then
  exit 0
fi

window_pid="$(xdotool getwindowpid "$active_win" 2>/dev/null || true)"
if [ -z "$window_pid" ]; then
  exit 0
fi

# Resolve the working directory of the focused terminal or its child shell process
resolve_cwd() {
  local pid="$1"
  local current_pid="$pid"

  # Traverse down child processes to find the foreground shell or active command
  while true; do
    local child_pid
    child_pid="$(pgrep -P "$current_pid" 2>/dev/null | tail -n 1 || true)"
    if [ -n "$child_pid" ] && [ -d "/proc/$child_pid" ]; then
      current_pid="$child_pid"
    else
      break
    fi
  done

  # Try the child's cwd, fallback to window PID's cwd
  if [ -e "/proc/$current_pid/cwd" ]; then
    readlink -f "/proc/$current_pid/cwd" 2>/dev/null || true
  elif [ -e "/proc/$pid/cwd" ]; then
    readlink -f "/proc/$pid/cwd" 2>/dev/null || true
  fi
}

cwd="$(resolve_cwd "$window_pid")"
if [ -z "$cwd" ] || [ ! -d "$cwd" ]; then
  exit 0
fi

# Verify directory is inside a git working tree
is_git="$(git -C "$cwd" rev-parse --is-inside-work-tree 2>/dev/null || true)"
if [ "$is_git" != "true" ]; then
  exit 0
fi

# Get branch name or short commit hash for detached HEAD
branch="$(git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null || true)"
if [ -z "$branch" ]; then
  branch="$(git -C "$cwd" rev-parse --short HEAD 2>/dev/null || true)"
fi

if [ -z "$branch" ]; then
  exit 0
fi

# Check for uncommitted / dirty changes
dirty=""
if [ -n "$(git -C "$cwd" status --porcelain 2>/dev/null || true)" ]; then
  dirty="*"
fi

# Check upstream ahead/behind counts
ahead_str=""
behind_str=""
counts="$(git -C "$cwd" rev-list --left-right --count @{upstream}...HEAD 2>/dev/null || true)"
if [ -n "$counts" ]; then
  behind="$(printf '%s' "$counts" | awk '{print $1}')"
  ahead="$(printf '%s' "$counts" | awk '{print $2}')"

  if [ -n "$ahead" ] && [ "$ahead" -gt 0 ]; then
    ahead_str="↑${ahead}"
  fi
  if [ -n "$behind" ] && [ "$behind" -gt 0 ]; then
    behind_str="↓${behind}"
  fi
fi

# Build formatted Polybar output
output="󰊢 ${branch}"

if [ -n "$dirty" ]; then
  output="${output}%{F#ff6b6b}${dirty}%{F-}"
fi

if [ -n "$ahead_str" ]; then
  output="${output} %{F#9ed072}${ahead_str}%{F-}"
fi

if [ -n "$behind_str" ]; then
  output="${output} %{F#ffb454}${behind_str}%{F-}"
fi

printf '%s\n' "$output"
