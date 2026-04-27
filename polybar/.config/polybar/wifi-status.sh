#!/usr/bin/env bash

set -u

max_len=12
NMCLI_BIN="${NMCLI_BIN:-/usr/bin/nmcli}"

truncate_text() {
  local text="$1"
  local limit="$2"

  if [ "${#text}" -le "$limit" ]; then
    printf '%s' "$text"
  else
    printf '%s...' "${text:0:$((limit - 3))}"
  fi
}

if [ ! -x "$NMCLI_BIN" ]; then
  printf '󰤭 No nmcli\n'
  exit 0
fi

active_wifi="$("$NMCLI_BIN" -t -f IN-USE,SSID,SIGNAL dev wifi list 2>/dev/null | awk -F: '$1=="*"{print $2 "|" $3; exit}')"

if [ -n "$active_wifi" ]; then
  ssid="${active_wifi%|*}"
  signal="${active_wifi##*|}"

  if [ -z "$ssid" ]; then
    ssid="Hidden"
  fi

  if [ -z "$signal" ]; then
    icon="󰤯"
  elif [ "$signal" -ge 80 ]; then
    icon="󰤨"
  elif [ "$signal" -ge 60 ]; then
    icon="󰤥"
  elif [ "$signal" -ge 40 ]; then
    icon="󰤢"
  elif [ "$signal" -ge 20 ]; then
    icon="󰤟"
  else
    icon="󰤯"
  fi

  short_ssid="$(truncate_text "$ssid" "$max_len")"
  printf '%s %s %s%%\n' "$icon" "$short_ssid" "$signal"
  exit 0
fi

connected_wifi="$("$NMCLI_BIN" -t -f DEVICE,TYPE,STATE,CONNECTION device status 2>/dev/null | awk -F: '$2=="wifi" && $3=="connected"{print $4; exit}')"

if [ -n "$connected_wifi" ]; then
  short_ssid="$(truncate_text "$connected_wifi" "$max_len")"
  printf '󰤨 %s\n' "$short_ssid"
  exit 0
fi

printf '󰤭 Offline\n'
