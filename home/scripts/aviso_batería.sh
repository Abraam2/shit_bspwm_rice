#!/bin/bash
set -euo pipefail

BATTERY_LEVEL_20=20
BATTERY_LEVEL_10=10

declare -A CHECK_INTERVALS=(
    [100]=1500
    [50]=300
    [30]=60
    [15]=30
)

ALERT_SOUND="$HOME/Scripts/b.mp3"

NOTIFIED_20=false
NOTIFIED_10=false
PREVIOUS_LEVEL=100

# ⚡ Salir si no hay batería física detectada y poner fondo animado (provisional)
if ! ls /sys/class/power_supply/ | grep -q '^BAT'; then
    #fondo_hidamari &
    exit 0
fi

get_check_interval() {
    local level=$1
    if [[ $level -gt 50 ]]; then
        echo ${CHECK_INTERVALS[100]}
    elif [[ $level -gt 30 ]]; then
        echo ${CHECK_INTERVALS[50]}
    elif [[ $level -gt 15 ]]; then
        echo ${CHECK_INTERVALS[30]}
    else
        echo ${CHECK_INTERVALS[15]}
    fi
}

log() {
    echo "[$(date)] Nivel: $1% - Intervalo: $(get_check_interval $1)s - Notificado20: $NOTIFIED_20 - Notificado10: $NOTIFIED_10" >> "$HOME/Scripts/battery_debug.log"
}

while true; do
    BATTERY_INFO=$(acpi -b 2>/dev/null) || true

    if [[ -n "$BATTERY_INFO" ]]; then
        BATTERY_LEVEL=$(echo "$BATTERY_INFO" | grep -oP '[0-9]+(?=%)')
        CURRENT_INTERVAL=$(get_check_interval $BATTERY_LEVEL)
        IS_DISCHARGING=$(echo "$BATTERY_INFO" | grep -q "Discharging" && echo true || echo false)

        log "$BATTERY_LEVEL"

        if [[ "$IS_DISCHARGING" == "true" ]]; then
            if [[ "$BATTERY_LEVEL" -le "$BATTERY_LEVEL_20" && "$PREVIOUS_LEVEL" -gt "$BATTERY_LEVEL_20" && "$NOTIFIED_20" == "false" ]]; then
                notify-send -u critical "🔋 Batería crítica (${BATTERY_LEVEL}%)" "¡Conecta el cargador YA!"
                pw-play "$ALERT_SOUND"
                NOTIFIED_20=true
                CURRENT_INTERVAL=${CHECK_INTERVALS[15]}
            elif [[ "$BATTERY_LEVEL" -le "$BATTERY_LEVEL_10" && "$PREVIOUS_LEVEL" -gt "$BATTERY_LEVEL_10" && "$NOTIFIED_10" == "false" ]]; then
                notify-send -u critical "🛑 Batería extremadamente baja (${BATTERY_LEVEL}%)" "¡Conecta el cargador YA!"
                pw-play "$ALERT_SOUND"
                NOTIFIED_10=true
                CURRENT_INTERVAL=${CHECK_INTERVALS[15]}
            fi
        else
            NOTIFIED_20=false
            NOTIFIED_10=false
        fi

        PREVIOUS_LEVEL=$BATTERY_LEVEL
    fi

    sleep "$CURRENT_INTERVAL"
done
