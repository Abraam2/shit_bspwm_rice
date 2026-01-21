#!/bin/bash
# ==============================================================================
#  PORT DEL INSTALLER DE G0STKZ PARA UBUNTU/DEBIAN
#  Basado en el trabajo de gh0stzk - Adaptado para tus Dotfiles
# ==============================================================================

# Colores (Copiados del script original)
CRE=$(tput setaf 1)    # Rojo
CYE=$(tput setaf 3)    # Amarillo
CGR=$(tput setaf 2)    # Verde
CBL=$(tput setaf 4)    # Azul
BLD=$(tput bold)       # Negrita
CNC=$(tput sgr0)       # Reset

# --- CONFIGURACIÓN ---
# ¡CAMBIA ESTO POR TU URL DE GITHUB!
REPO_URL="https://github.com/Abraam2/shit_bspwm_rice"
REPO_DIR="$HOME/.local/share/mis-dotfiles"

# Logo (Manteniendo la esencia del original)
logo() {
    text="$1"
    printf "%b" "
⣿⣿⣿⠟⢹⣶⣶⣝⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ 
⣿⣿⡟⢰⡌⠿⢿⣿⡾⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿ 
⣿⣿⣿⢸⣿⣤⣒⣶⣾⣳⡻⣿⣿⣿⣿⡿⢛⣯⣭⣭⣭⣽⣻⣿⣿⣿ 
⣿⣿⣿⢸⣿⣿⣿⣿⢿⡇⣶⡽⣿⠟⣡⣶⣾⣯⣭⣽⣟⡻⣿⣷⡽⣿ 
⣿⣿⣿⠸⣿⣿⣿⣿⢇⠃⣟⣷⠃⢸⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽ 
⣿⣿⣿⣇⢻⣿⣿⣯⣕⠧⢿⢿⣇⢯⣝⣒⣛⣯⣭⣛⣛⣣⣿⣿⣿⡇ 
⣿⣿⣿⣿⣌⢿⣿⣿⣿⣿⡘⣞⣿⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇ 
⣿⣿⣿⣿⣿⣦⠻⠿⣿⣿⣷⠈⢞⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇ 
⣿⣿⣿⣿⣿⣿⣗⠄⢿⣿⣿⡆⡈⣽⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢻ 
⣿⣿⣿⣿⡿⣻⣽⣿⣆⠹⣿⡇⠁⣿⡼⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣾ 
⣿⠿⣛⣽⣾⣿⣿⠿⠋⠄⢻⣷⣾⣿⣧⠟⣡⣾⣿⣿⣿⣿⣿⣿⡇⣿ 
⢼⡟⢿⣿⡿⠋⠁⣀⡀⠄⠘⠊⣨⣽⠁⠰⣿⣿⣿⣿⣿⣿⣿⡍⠗⣿ 
⡼⣿⠄⠄⠄⠄⣼⣿⡗⢠⣶⣿⣿⡇⠄⠄⣿⣿⣿⣿⣿⣿⣿⣇⢠⣿ 
⣷⣝⠄⠄⢀⠄⢻⡟⠄⣿⣿⣿⣿⠃⠄⠄⢹⣿⣿⣿⣿⣿⣿⣿⢹⣿ 
⣿⣿⣿⣿⣿⣧⣄⣁⡀⠙⢿⡿⠋⠄⣸⡆⠄⠻⣿⡿⠟⢛⣩⣝⣚⣿ 
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣤⣤⣤⣾⣿⣿⣄⠄⠄⠄⣴⣿⣿⣿⣇⣿ 
⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣄⡀⠛⠿⣿⣫⣾⣿

   ${BLD}${CRE}[ ${CYE}${text} ${CRE}]${CNC}\n\n"
}

initial_checks() {
    # No ejecutar como root
    if [ "$(id -u)" = 0 ]; then
        printf "%b" "${BLD}${CRE}¡ERROR: NO ejecutes este script como root! Hazlo como usuario normal.${CNC}\n"
        exit 1
    fi

    # Verificar directorio HOME
    if [ "$PWD" != "$HOME" ]; then
        printf "%b" "${BLD}${CRE}¡ERROR: Ejecuta el script desde tu carpeta personal ($HOME).${CNC}\n"
        exit 1
    fi
}

welcome() {
    clear
    logo "Bienvenido $USER"

    printf "%b" "${BLD}${CGR}Este script instalará tu RICE en Ubuntu/Debian:${CNC}

  ${BLD}${CGR}[${CYE}i${CGR}]${CNC} Actualizar el sistema e instalar dependencias (APT)
  ${BLD}${CGR}[${CYE}i${CGR}]${CNC} Compilar Picom v12 (Animaciones)
  ${BLD}${CGR}[${CYE}i${CGR}]${CNC} Clonar tus dotfiles y hacer BACKUP
  ${BLD}${CGR}[${CYE}i${CGR}]${CNC} Instalar fuentes, temas y configs
  ${BLD}${CGR}[${CYE}i${CGR}]${CNC} Cambiar Shell a ZSH/Fish

${BLD}${CGR}[${CRE}!${CGR}]${CNC} ${BLD}${CRE}Usa esto bajo tu propia responsabilidad.${CNC}
"

    while :; do
        printf " %b" "${BLD}${CGR}¿Deseas continuar?${CNC} [y/N]: "
        read -r yn
        case "$yn" in
            [Yy]) break ;;
            [Nn]|"") printf "\n%b\n" "${BLD}${CYE}Cancelado.${CNC}"; exit 0 ;;
            *) printf "\n%b\n" "${BLD}${CRE}Error:${CNC} Escribe 'y' o 'n'" ;;
        esac
    done
}

install_dependencies() {
    clear
    logo "Instalando Dependencias (APT)"
    sleep 1

    printf "%b\n" "${BLD}${CYE}Actualizando repositorios...${CNC}"
    sudo apt update && sudo apt upgrade -y

    # Lista de paquetes equivalentes para Ubuntu
    # He intentado buscar los equivalentes a lo que pedía G0stkz
    DEPENDENCIES=(
        "bspwm" "sxhkd" "fish" "polybar" "rofi" "kitty" "feh" "dunst" 
        "fish" "zsh" "thunar" "thunar-archive-plugin" "thunar-volman" 
        "gvfs-backends" "calc" "unzip" "wget" "curl" "git" "jq"
        "build-essential" "autoconf" "automake" "cmake" "meson" "ninja-build"
        "libx11-dev" "libxext-dev" "libxinerama-dev" "libxrandr-dev" 
        "libxrender-dev" "libgl1-mesa-dev" "libdbus-1-dev" "libconfig-dev" 
        "libdrm-dev" "libev-dev" "libpixman-1-dev" "libpcre2-dev" "libepoxy-dev"
        "uthash-dev" "libglib2.0-dev" "imagemagick" "mpd" "ncmpcpp"
        "brightnessctl" "playerctl" "pamixer" "maim" "xclip" "xdotool"
        "python3-pip" "python3-gi" "redshift" "nemo" "flameshot" "brightnessctl" "xdotool"           
        "libxdo-dev" "firejail" "playerctl" "pulseaudio-utils" "fastfetch" "imagemagick" 
    )

    printf "%b\n" "${BLD}${CYE}Instalando lista de paquetes...${CNC}"
    sudo apt install -y "${DEPENDENCIES[@]}"

    if [ $? -eq 0 ]; then
        printf "\n%b\n" "${BLD}${CGR}Dependencias instaladas correctamente.${CNC}"
    else
        printf "\n%b\n" "${BLD}${CRE}Error instalando dependencias.${CNC}"
        exit 1
    fi
    sleep 2
}

install_picom() {
    clear
    logo "Compilando Picom v12"
    sleep 1
    
    printf "%b\n" "${BLD}${CYE}Clonando y compilando Picom desde fuente...${CNC}"
    
    cd /tmp || exit
    if [ -d "picom" ]; then rm -rf picom; fi
    git clone https://github.com/yshui/picom.git
    cd picom
    git submodule update --init --recursive
    meson setup --buildtype=release build
    ninja -C build
    sudo ninja -C build install
    
    printf "\n%b\n" "${BLD}${CGR}Picom instalado.${CNC}"
    sleep 2
    cd "$HOME" || exit
}

install_ohmyposh() {
    clear
    logo "Instalando Oh My Posh"
    sleep 1

    printf "%b\n" "${BLD}${CYE}Descargando el binario desde GitHub...${CNC}"

    # Descargamos el ejecutable oficial a /usr/local/bin para que sea global
    sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh

    if [ $? -eq 0 ]; then
        sudo chmod +x /usr/local/bin/oh-my-posh
        printf "  [OK] Binario instalado en /usr/local/bin/oh-my-posh\n"
    else
        printf "\n%b\n" "${BLD}${CRE}[ERROR] Falló la descarga. Revisa tu internet.${CNC}"
        return 1
    fi

    # Instalamos también los temas estándar (por seguridad)
    printf "%b\n" "${BLD}${CYE}Instalando temas estándar en ~/.poshthemes...${CNC}"
    mkdir -p "$HOME/.poshthemes"
    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O "$HOME/.poshthemes/themes.zip"
    
    # Descomprimimos (requiere unzip, que instalamos en dependencias)
    unzip -o "$HOME/.poshthemes/themes.zip" -d "$HOME/.poshthemes" > /dev/null 2>&1
    chmod u+rw "$HOME/.poshthemes"/*.omp.*
    rm "$HOME/.poshthemes/themes.zip"

    printf "\n%b\n" "${BLD}${CGR}Oh My Posh instalado correctamente.${CNC}"
    sleep 2
}

install_pokemon() {
    clear
    logo "Instalando Pokemon Colorscripts"
    sleep 1
    
    printf "%b\n" "${BLD}${CYE}Clonando repositorio de phoneybadger...${CNC}"
    
    cd /tmp || exit
    # Limpiamos por si hubo un intento fallido antes
    if [ -d "pokemon-colorscripts" ]; then rm -rf pokemon-colorscripts; fi
    
    # Clonamos el repo oficial
    git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git
    
    if [ -d "pokemon-colorscripts" ]; then
        cd pokemon-colorscripts
        
        printf "%b\n" "${BLD}${CYE}Ejecutando instalador oficial...${CNC}"
        
        # Damos permisos y ejecutamos el instalador (requiere sudo para copiar a /usr/local/bin)
        chmod +x install.sh
        sudo ./install.sh
        
        # Verificación
        if command -v pokemon-colorscripts >/dev/null 2>&1; then
             printf "\n%b\n" "${BLD}${CGR}[OK] Pokemon-colorscripts instalado. Tu terminal ya no petará.${CNC}"
        else
             printf "\n%b\n" "${BLD}${CRE}[ERROR] Algo falló en la instalación.${CNC}"
        fi
        
        # Limpieza
        cd ..
        rm -rf pokemon-colorscripts
    else
        printf "\n%b\n" "${BLD}${CRE}[ERROR] No se pudo clonar el repositorio de GitLab.${CNC}"
    fi
    
    sleep 2
    cd "$HOME" || exit
}

clone_dotfiles() {
    clear
    logo "Descargando Dotfiles"
    
    timestamp=$(date +"%Y%m%d-%H%M%S")
    
    # Si ya existe la carpeta, la apartamos para no mezclar
    if [ -d "$REPO_DIR" ]; then
        backup_dir="${REPO_DIR}_backup_$timestamp"
        printf "%b\n" "${BLD}${CYE}Repo detectado. Renombrando a: ${CBL}${backup_dir}${CNC}"
        mv "$REPO_DIR" "$backup_dir"
    fi

    printf "%b\n" "${BLD}${CYE}Clonando desde: ${CBL}${REPO_URL}${CNC}"
    git clone "$REPO_URL" "$REPO_DIR"
    
    if [ ! -d "$REPO_DIR" ]; then
        printf "%b\n" "${BLD}${CRE}Error: No se ha podido descargar el repositorio.${CNC}"
        exit 1
    fi
    sleep 2
}

backup_existing_config() {
    clear
    logo "Haciendo Backup"
    sleep 1

    backup_folder="$HOME/.RiceBackup/$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$backup_folder"
    printf "\n%b\n" "${BLD}${CYE}Guardando tus configs actuales en: ${CBL}$backup_folder${CNC}"

    # 1. Carpetas de .config
    # (Añade aquí las carpetas que sepas que vas a sobrescribir)
    cfg_dirs="bspwm sxhkd polybar rofi kitty picom dunst ncmpcpp mpd fish neofetch qt5ct qt6ct gtk-3.0 gtk-4.0"
    
    for dir in $cfg_dirs; do
        if [ -d "$HOME/.config/$dir" ]; then
            mv "$HOME/.config/$dir" "$backup_folder/"
            printf "  -> Salvado: .config/%s\n" "$dir"
        fi
    done
    
    # 2. Archivos y carpetas sueltos del HOME
    files=".gtkrc-2.0 .fehbg .zshrc .bashrc .profile .nanorc .pene Scripts scripts Funciones"
    for f in $files; do
        if [ -e "$HOME/$f" ]; then
            mv "$HOME/$f" "$backup_folder/"
            printf "  -> Salvado: %s\n" "$f"
        fi
    done

    printf "\n%b\n" "${BLD}${CGR}Backup completado.${CNC}"
    sleep 2
}

install_dotfiles() {
    clear
    logo "Instalando Configuración"
    sleep 1

    # Crear estructura de carpetas si no existe
    mkdir -p "$HOME/.config" 
    mkdir -p "$HOME/.local/share/fonts" 
    mkdir -p "$HOME/.local/share/icons" 
    mkdir -p "$HOME/.local/share/themes"
    mkdir -p "$HOME/.icons" 
    mkdir -p "$HOME/.themes"
    mkdir -p "$HOME/Wallpapers"

    printf "%b\n" "${BLD}${CYE}Distribuyendo archivos...${CNC}"
    
    # --- 1. CARPETA CONFIG (.config) ---
    if [ -d "$REPO_DIR/config" ]; then
        cp -r "$REPO_DIR/config/"* "$HOME/.config/"
        printf "  [OK] Configs copiadas a ~/.config\n"
    fi
    
    # --- 2. CARPETA HOME (Archivos varios) ---
    
    # Fuentes
    if [ -d "$REPO_DIR/home/fonts" ]; then
        cp -r "$REPO_DIR/home/fonts/"* "$HOME/.local/share/fonts/"
        printf "  [OK] Fuentes instaladas\n"
    fi
    
    # Iconos (Copiamos a ambos sitios por compatibilidad)
    if [ -d "$REPO_DIR/home/icons" ]; then
        cp -r "$REPO_DIR/home/icons/"* "$HOME/.icons/" 2>/dev/null
        cp -r "$REPO_DIR/home/icons/"* "$HOME/.local/share/icons/" 2>/dev/null
        printf "  [OK] Iconos instalados\n"
    fi
    
    # Temas (Copiamos a ambos sitios)
    if [ -d "$REPO_DIR/home/themes" ]; then
        cp -r "$REPO_DIR/home/themes/"* "$HOME/.themes/" 2>/dev/null
        cp -r "$REPO_DIR/home/themes/"* "$HOME/.local/share/themes/" 2>/dev/null
        printf "  [OK] Temas instalados\n"
    fi

    # Scripts (El lío de mayúsculas/minúsculas resuelto)
    if [ -d "$REPO_DIR/home/scripts" ]; then
        mkdir -p "$HOME/Scripts"
        cp -r "$REPO_DIR/home/scripts/"* "$HOME/Scripts/"
        cp -r "$REPO_DIR/home/scripts" "$HOME/" # Backup en minúscula '~/scripts'
        printf "  [OK] Scripts instalados en ~/Scripts y ~/scripts\n"
    fi

    # Archivos sueltos de 'home' (.fehbg, .profile, etc)
    # Copiamos todo lo que empiece por punto dentro de 'home'
    find "$REPO_DIR/home" -maxdepth 1 -name ".*" -type f -exec cp {} "$HOME/" \;

    # --- 3. ARCHIVOS EN LA RAÍZ DEL REPO ---
    
    # Funciones
    if [ -d "$REPO_DIR/Funciones" ]; then
        cp -r "$REPO_DIR/Funciones" "$HOME/"
        printf "  [OK] Carpeta ~/Funciones copiada\n"
    fi
    
    # Nano (Renombramos nanorc a .nanorc para que sea oculto y funcione)
    if [ -f "$REPO_DIR/nanorc" ]; then
        cp "$REPO_DIR/nanorc" "$HOME/.nanorc"
        printf "  [OK] Configuración de Nano instalada (.nanorc)\n"
    fi

    # Wallpapers (Están en misc/wallpapers)
    if [ -d "$REPO_DIR/misc/wallpapers" ]; then
        cp -r "$REPO_DIR/misc/wallpapers/"* "$HOME/Wallpapers/"
        printf "  [OK] Fondos copiados a ~/Wallpapers\n"
    fi
    
    # --- 4. FINALIZANDO ---

    # Actualizar caché de fuentes
    fc-cache -fv >/dev/null 2>&1

    # Permisos de ejecución a todo lo que huela a script
    chmod +x "$HOME/.config/bspwm/bspwmrc"
    chmod +x "$HOME/.config/bspwm/scripts/"* 2>/dev/null
    chmod +x "$HOME/.config/polybar/ghost/"*.sh 2>/dev/null
    chmod +x "$HOME/.config/polybar/ghost/"*.bash 2>/dev/null
    chmod +x "$HOME/Scripts/"* 2>/dev/null
    chmod +x "$HOME/scripts/"* 2>/dev/null
    chmod +x "$HOME/Funciones/"* 2>/dev/null

    printf "\n%b\n" "${BLD}${CGR}¡Todos los archivos colocados en su sitio!${CNC}"
    sleep 2
}

configure_services() {
    clear
    logo "Configurando Servicios"
    sleep 1
    
    if command -v mpd >/dev/null 2>&1; then
        printf "%b\n" "${BLD}${CYE}Configurando MPD (Música)...${CNC}"
        
        # Paramos el servicio de sistema si está rodando para que no moleste
        if systemctl is-active --quiet mpd; then
            sudo systemctl stop mpd
            sudo systemctl disable mpd
        fi
        
        # Activamos el servicio de usuario (lee ~/.config/mpd/mpd.conf)
        systemctl --user enable --now mpd
        printf "  [OK] MPD activado como servicio de usuario.\n"
    fi
    
    sleep 2
}

configure_shell() {
    clear
    logo "Configurando Shell (FISH)"
    sleep 1
    
    # Verificamos si Fish está instalado
    if command -v fish >/dev/null 2>&1; then
        current_shell=$(basename "$SHELL")
        
        if [ "$current_shell" != "fish" ]; then
            printf "%b\n" "${BLD}${CYE}Tu shell actual es $current_shell. Cambiando a FISH...${CNC}"
            
            # Cambiamos la shell del usuario actual
            # Usamos chsh -s con la ruta que nos diga 'which fish'
            sudo chsh -s "$(which fish)" "$USER"
            
            printf "  [OK] Shell cambiada. Verás el cambio al reiniciar.\n"
        else
            printf "%b\n" "${BLD}${CGR}Ya estás usando Fish. Todo correcto.${CNC}"
        fi
    else
        printf "%b\n" "${BLD}${CRE}¡Ojo! Fish no parece estar instalado. No se pudo cambiar.${CNC}"
    fi
    sleep 2
}

final_prompt() {
    clear
    logo "Instalando Completada"

    printf "%b\n" "${BLD}${CGR}¡HEMOS TERMINADO!${CNC}"
    printf "%b\n" "Se ha instalado tu Rice, tus configs, fuentes, temas y Fish."
    printf "%b\n\n" "${BLD}${CRE}>>> ES OBLIGATORIO REINICIAR AHORA MISMO <<<${CNC}"

    while :; do
        printf "%b" "${BLD}${CYE}¿Reiniciar el sistema ahora?${CNC} [y/N]: "
        read -r yn
        case "$yn" in
            [Yy]) 
                printf "\nReiniciando en 3, 2, 1...\n"
                sleep 1
                sudo reboot
                break 
                ;;
            [Nn]|"") 
                printf "\n%b\n" "${BLD}${CYE}Vale, pero recuerda reiniciar antes de usar nada.${CNC}"
                exit 0 
                ;;
            *) 
                printf " Escribe 'y' o 'n'\n" 
                ;;
        esac
    done
}

# 1. Comprobaciones
initial_checks
welcome

# 2. Instalación
install_dependencies
install_picom
install_pokemon
install_ohmyposh

# 3. Archivos (La parte que personalizamos antes)
clone_dotfiles
backup_existing_config
install_dotfiles

# 4. Finalización
configure_services
configure_shell
final_prompt