#!/bin/bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
THUMB_DIR="$SCRIPT_DIR/thumbnails"
mkdir -p "$THUMB_DIR"

wid=${1:-$(bspc query -N -n focused)}
[ -z "$wid" ] && exit 1

# Obtener geometría de la ventana
geom=$(xwininfo -id "$wid" 2>/dev/null | awk '/Absolute upper-left X:/ {x=$4} /Absolute upper-left Y:/ {y=$4} /Width:/ {w=$2} /Height:/ {h=$2} END {print x","y","w","h}')

if [ -z "$geom" ]; then
    echo "No se pudo obtener geometría de la ventana $wid"
    exit 1
fi

x=$(echo "$geom" | cut -d, -f1)
y=$(echo "$geom" | cut -d, -f2)
w=$(echo "$geom" | cut -d, -f3)
h=$(echo "$geom" | cut -d, -f4)

# Capturar miniatura de la ventana
import -window root -crop "${w}x${h}+${x}+${y}" "$THUMB_DIR/$wid.png"

# Ocultar ventana
bspc node "$wid" -g hidden=on
