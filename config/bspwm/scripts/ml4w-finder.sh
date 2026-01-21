#!/usr/bin/env bash

# --- 1. Generar lista (Sin romper los nombres con espacios) ---
# Usamos sed para cambiar solo la primera letra por el icono
LIST=$(find -L . -maxdepth 4 -printf "%y %p\n" 2>/dev/null | sed \
    -e 's/^d / /' \
    -e 's/^f /󰈚 /' \
    -e 's/^l / /' \
    | grep -v " \./$")

# --- 2. Selección en la interfaz ---
# He añadido el símbolo ~ en height para que la ventana se ajuste a los resultados
SELECTED_RAW=$(echo "$LIST" | fzf \
    --style full \
    --height ~50% \
    --layout reverse \
    --border \
    --prompt "🔍 Finder: ")

[ -z "$SELECTED_RAW" ] && exit 0

# --- 3. Lógica de salida ---
# Separamos el icono de la ruta correctamente
TYPE_ICON=$(echo "$SELECTED_RAW" | cut -d' ' -f1)
PATH_VAL=$(echo "$SELECTED_RAW" | cut -d' ' -f2-)

if [ "$TYPE_ICON" == "" ]; then
    echo "TYPE_DIR:$PATH_VAL"
else
    echo "TYPE_FILE:$PATH_VAL"
    ${EDITOR:-nano} "$PATH_VAL"
fi