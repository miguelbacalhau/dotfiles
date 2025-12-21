#!/usr/bin/env bash

DEVICE="${1:-wlan0}"

# Scan for networks
iwctl station "$DEVICE" scan 2>/dev/null
sleep 1

# Get networks, strip ANSI codes, extract SSID and signal
networks=$(iwctl station "$DEVICE" get-networks 2>/dev/null \
  | sed 's/\x1b\[[0-9;]*m//g' \
  | grep -E '^\s*(>)?\s+\S+.*\*+' \
  | sed 's/^[[:space:]>]*//' \
  | awk '{signal=$NF; $NF=""; $(NF-1)=""; gsub(/^[[:space:]]+|[[:space:]]+$/, ""); print $0 "  (" signal ")"}')

# Show in rofi
chosen=$(echo "$networks" | rofi -dmenu -i -p "WiFi")

# Exit if nothing selected
[[ -z "$chosen" ]] && exit 0

# Extract SSID (remove signal suffix)
ssid="${chosen%  (*)}"

# Try connecting (works for known networks)
if timeout 3 iwctl station "$DEVICE" connect "$ssid" 2>/dev/null; then
  notify-send "WiFi" "Connected to $ssid"
else
  # Prompt for password
  password=$(rofi -dmenu -p "Password")
  [[ -z "$password" ]] && exit 0

  if iwctl --passphrase "$password" station "$DEVICE" connect "$ssid" 2>/dev/null; then
    notify-send "WiFi" "Connected to $ssid"
  else
    notify-send "WiFi" "Failed to connect to $ssid"
  fi
fi
