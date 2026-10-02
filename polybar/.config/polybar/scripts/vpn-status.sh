#!/usr/bin/env bash
# ==============================================================================
# vpn-status.sh — Polybar VPN / WireGuard / Tailscale Connection Status
# ==============================================================================
# Checks active VPN connections in the following priority order:
#   1. Tailscale: if active ("Running"), outputs %{F#9ed072}󰖂 TS%{F-}
#   2. WireGuard: if active interfaces found, outputs %{F#9ed072}󰖂 WG%{F-}
#   3. NetworkManager VPN: if active VPN/WireGuard profile found,
#      outputs %{F#9ed072}󰖂 name%{F-} (name truncated to 8 chars)
#   4. Inactive: outputs %{F#5a4f42}󰖂%{F-}
# ==============================================================================

set -u

# 1. Check Tailscale
if command -v tailscale >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
  ts_state="$(tailscale status --json 2>/dev/null | jq -r '.BackendState // empty' 2>/dev/null || true)"
  if [ "$ts_state" = "Running" ]; then
    printf '%%{F#9ed072}󰖂 TS%%{F-}\n'
    exit 0
  fi
fi

# 2. Check WireGuard
if command -v wg >/dev/null 2>&1; then
  wg_interfaces="$(sudo -n wg show interfaces 2>/dev/null || wg show interfaces 2>/dev/null || true)"
  if [ -n "$wg_interfaces" ]; then
    printf '%%{F#9ed072}󰖂 WG%%{F-}\n'
    exit 0
  fi
fi

# 3. Check NetworkManager VPN / WireGuard connections
if command -v nmcli >/dev/null 2>&1; then
  active_vpn="$(nmcli -t -f NAME,TYPE,STATE connection show --active 2>/dev/null | awk -F: '($2=="vpn" || $2=="wireguard") && $3=="activated"{print $1; exit}' || true)"
  if [ -n "$active_vpn" ]; then
    # Truncate connection name to 8 characters
    if [ "${#active_vpn}" -gt 8 ]; then
      short_vpn="${active_vpn:0:8}"
    else
      short_vpn="$active_vpn"
    fi
    printf '%%{F#9ed072}󰖂 %s%%{F-}\n' "$short_vpn"
    exit 0
  fi
fi

# 4. Nothing active
printf '%%{F#5a4f42}󰖂%%{F-}\n'
