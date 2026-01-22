#!/bin/bash
# ==============================================================================
#  INSTALLER OPTIMIZADO - Solo instala lo que falta
# ==============================================================================

# Colores
CRE=$(tput setaf 1)    # Rojo
CYE=$(tput setaf 3)    # Amarillo
CGR=$(tput setaf 2)    # Verde
CBL=$(tput setaf 4)    # Azul
BLD=$(tput bold)       # Negrita
CNC=$(tput sgr0)       # Reset

# --- CONFIGURACIÓN ---
REPO_URL="https://github.com/Abraam2/shit_bspwm_rice"
REPO_DIR="$HOME/mis-dotfiles" # Cambiado a tu carpeta habitual para facilitar git pull

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
    if [ "$(id -u)" = 0 ]; then
        printf "%b" "${BLD}${CRE}¡ERROR: NO ejecutes como root!${CNC}\n"
        exit 1
    fi
}

# --- FUNCIONES DE INSTALACIÓN INTELIGENTES ---

install_dependencies() {
    logo "Comprobando Dependencias (APT)"
    sudo apt update
    
    DEPENDENCIES=(
        "bspwm" "sxhkd" "fish" "maim" "imagemagick" "lxappearance" "polybar" "rofi" "kitty" 
        "pkg-config" "thunar" "unzip" "wget" "curl" "git" "jq" "feh" "dunst" 
        "build-essential" "autoconf" "automake" "cmake" "meson" "ninja-build"
        "libx11-dev" "libxext-dev" "libxinerama-dev" "libxrandr-dev" 
        "libxrender-dev" "libgl1-mesa-dev" "libdbus-1-dev" "libconfig-dev" 
        "libdrm-dev" "libev-dev" "libpixman-1-dev" "libpcre2-dev" "libepoxy-dev"
        "uthash-dev" "libglib2.0-dev" "mpd" "ncmpcpp" "brightnessctl" 
        "playerctl" "pamixer" "xclip" "xdotool" "redshift" "nemo" "flameshot" 
        "libxcb-composite0-dev" "libxdo-dev" "firejail" "pulseaudio-utils" 
    )

    # Apt es inteligente, si ya está instalado no hace nada
    sudo apt install -y "${DEPENDENCIES[@]}"
}

install_picom() {
    if ! command -v picom &> /dev/null; then
        logo "Compilando Picom v12"
        cd /tmp || exit
        git clone https://github.com/yshui/picom.git
        cd picom
        git submodule update --init --recursive
        meson setup --buildtype=release build
        ninja -C build
        sudo ninja -C build install
        cd ~
    else
        printf "${CGR}Picom ya está instalado, saltando...${CNC}\n"
    fi
}

install_i3lock_color() {
    if ! i3lock --version 2>&1 | grep -q "i3lock-color"; then
        logo "Compilando i3lock-color"
        sudo apt install -y libev-dev libpango1.0-dev libsn-dev libxcb-xinerama0-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-util0-dev libxcb-image0-dev libxcb-keysyms1-dev libxcb-randr0-dev libxkbcommon-dev libxkbcommon-x11-dev
        cd /tmp
        git clone https://github.com/Raymo111/i3lock-color.git
        cd i3lock-color
        ./install-i3lock-color.sh
        cd ~
    else
        printf "${CGR}i3lock-color ya está instalado, saltando...${CNC}\n"
    fi
}

install_fastfetch() {
    if ! command -v fastfetch &> /dev/null; then
        logo "Instalando Fastfetch"
        wget https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb -O /tmp/fastfetch.deb
        sudo dpkg -i /tmp/fastfetch.deb
        sudo apt-get install -f -y
        rm /tmp/fastfetch.deb
    else
        printf "${CGR}Fastfetch ya está instalado.${CNC}\n"
    fi
}

# --- GESTIÓN DE DOTFILES (GIT PULL) ---

update_dotfiles() {
    logo "Actualizando Dotfiles"
    if [ -d "$REPO_DIR/.git" ]; then
        printf "${CYE}Carpeta detectada. Haciendo git pull...${CNC}\n"
        cd "$REPO_DIR" || exit
        git reset --hard origin/main  # Forzamos que la VM sea igual al repo
        git pull
    else
        printf "${CYE}Clonando repositorio por primera vez...${CNC}\n"
        git clone "$REPO_URL" "$REPO_DIR"
    fi
}

install_dotfiles() {
    logo "Copiando Archivos de Configuración"
    
    # Crear carpetas necesarias
    mkdir -p "$HOME/.config" "$HOME/.local/share/fonts" "$HOME/Wallpapers"

    # Copiar configs (Sobreescribe lo que haya cambiado)
    cp -r "$REPO_DIR/config/"* "$HOME/.config/"
    
    # Fuentes y Caché (Solo si hay fuentes nuevas)
    if [ -d "$REPO_DIR/home/fonts" ]; then
        cp -r "$REPO_DIR/home/fonts/"* "$HOME/.local/share/fonts/"
        fc-cache -fv > /dev/null 2>&1
    fi

    # Wallpapers
    if [ -d "$REPO_DIR/misc/wallpapers" ]; then
        cp -r "$REPO_DIR/misc/wallpapers/"* "$HOME/Wallpapers/"
    fi

    # Scripts y permisos
    cp -r "$REPO_DIR/home/scripts" "$HOME/" 2>/dev/null
    find "$HOME/.config/bspwm/scripts" -type f -exec chmod +x {} \;
    chmod +x "$HOME/.config/bspwm/bspwmrc"

    printf "${CGR}Archivos actualizados correctamente.${CNC}\n"
}

# --- EJECUCIÓN ---

initial_checks
install_dependencies
install_picom
install_i3lock_color
install_fastfetch
update_dotfiles
install_dotfiles

printf "\n${BLD}${CGR}¡Proceso finalizado!${CNC} Si solo has cambiado scripts, no hace falta reiniciar.\n"
