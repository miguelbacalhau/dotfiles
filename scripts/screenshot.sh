#!/bin/sh

DIR="$HOME/screenshots"
TS="$(date +%F_%T)"
EXT="$TS.png"
FILE="$DIR/$EXT"

case "$1" in
  area)
    GEOM="$(slurp)" || exit 1
    grim -g "$GEOM" "$FILE" || exit 1
    ;;
  full|"")
    grim "$FILE" || exit 1
    ;;
  *)
    echo "Usage: screenshot [area|full]"
    exit 1
    ;;
esac

notify-send -t 2000 "Screenshot saved" "$EXT"
