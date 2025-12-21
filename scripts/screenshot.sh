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

ICON_THEME=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")
ICON="/usr/share/icons/$ICON_THEME/16x16/mimetypes/image-x-generic.png"
[ -f "$ICON" ] || ICON="/usr/share/icons/hicolor/16x16/mimetypes/image-x-generic.png"

notify-send -t 2000 -i "$ICON" "Screenshot saved" "$EXT"
