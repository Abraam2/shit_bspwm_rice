#!/bin/bash

# Obtiene el volumen actual (en porcentaje)
volumen_actual=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | tr -d '%')

# Si el volumen es menor a 100, sube 5 %
if [ "$volumen_actual" -lt 100 ]; then
    pactl set-sink-volume @DEFAULT_SINK@ +5%
else
    # Asegura que no se pase del 100 %
    pactl set-sink-volume @DEFAULT_SINK@ 100%
fi
