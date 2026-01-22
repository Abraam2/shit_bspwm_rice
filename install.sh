#!/bin/bash
# ==============================================================================
#  INSTALLER SEGURO - REVISADO Y AMPLIADO
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
REPO_DIR="$HOME/mis-dotfiles"

# --- FUNCIONES ---

install_dependencies() {
    printf "%b\n" "${BLD}${CYE}Instalando Dependencias (APT)...${CNC}"
    sudo apt update
    
    # Añadidos gsimplecal, pavucontrol y dependencias de compilación para i3lock-color
    DEPENDENCIES=(
        "bspwm" "sxhkd" "fish" "maim" "imagemagick" "lxappearance" "polybar" "rofi" "kitty" 
        "pkg-config" "unzip" "wget" "curl" "git" "jq" "feh" "dunst" "pavucontrol" "gsimplecal"
        "build-essential" "autoconf" "automake" "cmake" "meson" "ninja-build"
        "libx11-dev" "libxext-dev" "libxinerama-dev" "libxrandr-dev" 
        "libxrender-dev" "libgl1-mesa-dev" "libdbus-1-dev" "libconfig-dev" 
        "libdrm-dev" "libev-dev" "libpixman-1-dev" "libpcre2-dev" "libepoxy-dev"
        "uthash-dev" "libglib2.0-dev" "libxcb-composite0-dev" "libxdo-dev"
        "libxcb-xinerama0-dev" "libxcb-xkb-dev" "libxcb-xrm-dev" "libxcb-util0-dev"
        "libxcb-image0-dev" "libxcb-keysyms1-dev" "libxcb-randr0-dev"
        "libxkbcommon-dev" "libxkbcommon-x11-dev" "libpango1.0-dev" "libsn-dev"
        "brightnessctl" "playerctl" "pamixer" "xclip" "xdotool" "nemo" "flameshot"
    )

    sudo apt install -y "${DEPENDENCIES[@]}"
}

install_i3lock_color() {
    # Si i3lock no existe o no es la versión "color", compilamos
    if ! command -v i3lock &> /dev/null || ! i3lock --version | grep -q "color"; then
        printf "%b\n" "${BLD}${CYE}Instalando i3lock-color (Compilando)...${CNC}"
        cd /tmp || exit
        [ -d "i3lock-color" ] && rm -rf i3lock-color
        git clone https://github.com/Raymo111/i3lock-color.git
        cd i3lock-color || exit
        ./install-i3lock-color.sh
        cd ~ || exit
    else
        printf "%b\n" "${CGR}i3lock-color ya está presente.${CNC}"
    fi
}

install_pokemon() {
    if ! command -v pokemon-colorscripts &> /dev/null; then
        printf "%b\n" "${BLD}${CYE}Instalando Pokemon Colorscripts...${CNC}"
        cd /tmp || exit
        [ -d "pokemon-colorscripts" ] && rm -rf pokemon-colorscripts
        git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git
        cd pokemon-colorscripts || exit
        sudo ./install.sh
        cd ~ || exit
    else
        printf "%b\n" "${CGR}Pokemon Colorscripts ya está instalado.${CNC}"
    fi
}

install_fastfetch() {
    if ! command -v fastfetch &> /dev/null; then
        printf "%b\n" "${BLD}${CYE}Instalando Fastfetch desde GitHub...${CNC}"
        wget https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb -O /tmp/fastfetch.deb
        sudo dpkg -i /tmp/fastfetch.deb
        sudo apt-get install -f -y
        rm /tmp/fastfetch.deb
    fi
}

update_dotfiles() {
    if [ -d "$REPO_DIR/.git" ]; then
        printf "%b\n" "${BLD}${CYE}Actualizando repo existente...${CNC}"
        cd "$REPO_DIR" || exit
        git reset --hard origin/main
        git pull
    else
        printf "%b\n" "${BLD}${CYE}Clonando repo...${CNC}"
        git clone "$REPO_URL" "$REPO_DIR"
    fi
}

install_dotfiles() {
    printf "%b\n" "${BLD}${CYE}Copiando configuraciones...${CNC}"
    mkdir -p "$HOME/.config" "$HOME/.local/share/fonts" "$HOME/Wallpapers"

    cp -r "$REPO_DIR/config/"* "$HOME/.config/"
    
    # Fuentes y Caché
    if [ -d "$REPO_DIR/home/fonts" ]; then
        cp -r "$REPO_DIR/home/fonts/"* "$HOME/.local/share/fonts/"
        fc-cache -fv &> /dev/null
    fi

    # Wallpapers
    if [ -d "$REPO_DIR/misc/wallpapers" ]; then
        cp -r "$REPO_DIR/misc/wallpapers/"* "$HOME/Wallpapers/"
    fi

    # Permisos
    chmod +x "$HOME/.config/bspwm/bspwmrc"
    find "$HOME/.config/bspwm/scripts" -type f -exec chmod +x {} \;
}

# --- EJECUCIÓN ---
install_dependencies
install_i3lock_color
install_pokemon
install_fastfetch
update_dotfiles
install_dotfiles

printf "\n%b\n" "${BLD}${CGR}¡Listo! Prueba los atajos ahora.${CNC}"
