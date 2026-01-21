#!/bin/bash
while true; do
    hora=$(date +%H)
    minuto=$(date +%M)
    
    # Determinar AM/PM manualmente
    if [ $hora -ge 12 ]; then
        periodo="pm"
    else
        periodo="am"
    fi
    
    # Convertir a formato 12h
    if [ $hora -eq 0 ]; then
        hora12=12
    elif [ $hora -gt 12 ]; then
        hora12=$((hora - 12))
    else
        hora12=$hora
    fi
    
    # Obtener fecha en español capitalizada
    fecha=$(LC_TIME=es_ES.UTF-8 date "+%A, %d %B," | sed 's/\b\(.\)/\u\1/g')
    
    echo "󰅐 $fecha $hora12:$minuto $periodo"  # ← ESPACIO aquí
    sleep 1
done