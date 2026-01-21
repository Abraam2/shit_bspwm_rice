function finder --description 'Lanza el buscador difuso de ML4W'
    # Ejecutamos el script de bash y guardamos lo que diga en una variable
    set -l result (bash $HOME/.config/fish/scripts/ml4w-finder.sh)

    # Si hemos cancelado (pulsado ESC), la variable estará vacía, así que salimos
    if test -z "$result"
        return
    end

    # Miramos si el resultado empieza por TYPE_DIR:
    if string match -q "TYPE_DIR:*" "$result"
        # Limpiamos el texto para quedarnos solo con la carpeta
        set -l target_dir (string replace "TYPE_DIR:" "" "$result")
        
        # Cambiamos de carpeta y listamos el contenido
        cd "$target_dir"
        ls
    end
end
