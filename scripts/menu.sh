#!/usr/bin/env bash

STATE="$1"

launch() {
  "$@" >/dev/null 2>&1 & disown
}

case "$STATE" in

  # Main menu
  "")
    echo -e " Capture\0icon\x1fcapture"
    echo -e " Network\0icon\x1fcapture"
    echo -e "⏻ Power\0icon\x1fpower"
    ;;

  # Power submenu
  " Capture")
    echo -e " Screenshot\n Screenshot area\n Screenrecord\n Color"
    ;;
  
  # Power actions
  " Screenshot") launch "$HOME/.config/scripts/screenshot.sh" full ;;
  " Screenshot area") launch "$HOME/.config/scripts/screenshot.sh" area ;;
  " Screenrecord") launch obs ;;
  " Color") launch hyprpicker ;;

  " Network") launch "$HOME/.config/scripts/wifi.sh" ;;

  # Power submenu
  "⏻ Power")
    echo -e " Lock\n󰑓 Reboot\n⏻ Shutdown"
    ;;

  # Power actions
  " Lock")     launch hyprlock ;;
  "󰑓 Reboot")   systemctl reboot >/dev/null 2>&1 & ;;
  "⏻ Shutdown") systemctl poweroff >/dev/null 2>&1 & ;;

esac
