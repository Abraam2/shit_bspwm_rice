#!/usr/bin/env bash

notify="notify-send"
tmp_disturb="/tmp/xmonad/donotdisturb"
tmp_disturb_colorfile="/tmp/xmonad/donotdisturb/color"

mkdir -p "$tmp_disturb"

if [ "$(dunstctl is-paused)" = "true" ]; then
    dunstctl set-paused false
    $notify "Dunst: Active"
    echo "#84afdb" > "$tmp_disturb_colorfile"
else
    $notify "Dunst: Mute Notify"
    echo "#c47eb7" > "$tmp_disturb_colorfile"
    (sleep 3 && dunstctl close && dunstctl set-paused true) &
fi

