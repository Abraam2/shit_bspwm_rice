#!/usr/bin/env python3
import subprocess

# --- MAPA DE ICONOS ---
icon_map = {
    "thunar": "",
    "pcmanfm": "",
    "nautilus": "",
    "dolphin": "",
    'nemo': "",
    "org.gnome.nautilus": "",
    "brave-browser": "",
    "spotify": ' ',
    "code": "",
    "code-oss": "",
    "vscodium": "",
    # Iconos para VirtualBox (ahora los gestionamos con lógica abajo)
    "virtualbox": "", 
    "kitty": "",
    "keepassxc": "\uf084",
    "firefox": "",
    "xreader": "",
    "default": "" 
}


# --- COLORES ---
COLOR_ACTIVE = "#7aa2f7"    
COLOR_INACTIVE = "#4C566A"  

def get_windows():
    try:
        # wmctrl -lx nos da: ID, Escritorio, Clase, Host, Título
        output = subprocess.check_output(["wmctrl", "-lx"], text=True)
        lines = output.strip().split("\n")
        
        active_id = subprocess.check_output(["xprop", "-root", "_NET_ACTIVE_WINDOW"], text=True).strip().split()[-1]
        if active_id == "0x0": active_id = None
        
        window_list = []
        
        for line in lines:
            parts = line.split()
            if len(parts) < 5: continue # Necesitamos al menos 5 partes para llegar al título
            
            wid = parts[0]
            wclass_full = parts[2].lower()
            wclass = wclass_full.split('.')[-1]
            
            # --- NUEVA LÓGICA DE DETECCIÓN POR PREFIJO ---
            # Unimos las partes de la lista desde el índice 4 en adelante para tener el título completo
            title = " ".join(parts[4:]).lower()
            
            # Buscamos el icono base
            icon = icon_map.get(wclass, icon_map.get(wclass_full, None))

            # Si es VirtualBox, refinamos el icono mirando el título
            if "virtualbox" in wclass:
                if "win_" in title or "windows" in title or "win" in title or "gundos" in title:
                    icon = "" # Icono de Windows
                elif "lnx_" in title or "linux" in title or "lnx" in title or "lin" in title:
                    icon = "" # Icono de Linux (el que ya tenías)
                else:
                    icon = "󰟀" # Icono para el Manager o máquinas sin prefijo

            # Si no hay icono definido y no es VirtualBox, ignoramos
            if icon is None:
                continue

            # --- FORMATEO PARA POLYBAR ---
            click_cmd = f"%{{A1:wmctrl -i -a {wid}:}}%{{A2:wmctrl -i -c {wid}:}}"
            end_click = "%{A}%{A}"
            
            is_active = False
            if active_id:
                try:
                    if int(wid, 16) == int(active_id, 16): is_active = True
                except: pass
            
            color = COLOR_ACTIVE if is_active else COLOR_INACTIVE
            # He añadido un pequeño espacio tras el icono para que no se pegue al siguiente
            item = f"%{{F{color}}}{click_cmd}{icon}{end_click}%{{F-}}"
            window_list.append(item)
        
        print("  ".join(window_list))

    except Exception as e:
        print("")

if __name__ == "__main__":
    get_windows()
