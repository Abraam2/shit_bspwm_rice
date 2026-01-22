#!/bin/bash
# ==============================================================================
#  INSTALLER FINAL - (Ubuntu 24.04 Noble Compatible)
# ==============================================================================

# Colores
CRE=$(tput setaf 1); CYE=$(tput setaf 3); CGR=$(tput setaf 2); CBL=$(tput setaf 4); BLD=$(tput bold); CNC=$(tput sgr0)

# CONFIGURACIÓN
REPO_URL="https://github.com/Abraam2/shit_bspwm_rice"
REPO_DIR="$HOME/mis-dotfiles"

logo() { printf "%b" "${BLD}${CRE}[ ${CYE}INSTALLER ${CRE}]${CNC}\n\n"; }

initial_checks() {
    if [ "$(id -u)" = 0 ]; then printf "%b" "${BLD}${CRE}¡NO lo ejecutes como root!${CNC}\n"; exit 1; fi
}

# --- 1. INSTALACIÓN DE PAQUETES (EL FIX IMPORTANTE) ---
install_dependencies() {
    logo "Instalando Dependencias..."
    sudo apt update
    
    # HE ELIMINADO 'libsn-dev' QUE ROMPÍA TODO Y PUESTO LOS NOMBRES CORRECTOS
    DEPENDENCIES=(
        "bspwm" "sxhkd" "fish" "maim" "imagemagick" "lxappearance" "polybar" "rofi" "kitty" 
        "pkg-config" "unzip" "wget" "curl" "git" "jq" "feh" "dunst" "pavucontrol" "gsimplecal"
        "build-essential" "autoconf" "automake" "cmake" "meson" "ninja-build" "libpam0g-dev"
        "libx11-dev" "libxext-dev" "libxinerama-dev" "libxrandr-dev" "libx11-xcb-dev"
        "libxrender-dev" "libgl1-mesa-dev" "libdbus-1-dev" "libconfig-dev" 
        "libdrm-dev" "libev-dev" "libpixman-1-dev" "libpcre2-dev" "libepoxy-dev"
        "uthash-dev" "libglib2.0-dev" "libxcb-composite0-dev" "libxdo-dev"
        "libxcb-xinerama0-dev" "libxcb-xkb-dev" "libxcb-xrm-dev" "libxcb-util-dev"
        "libxcb-image0-dev" "libxcb-keysyms1-dev" "libxcb-randr0-dev" "libxcb-shm0-dev"
        "libxkbcommon-dev" "libxkbcommon-x11-dev" "libpango1.0-dev" "libstartup-notification0-dev"
        "brightnessctl" "playerctl" "pamixer" "xclip" "xdotool" "nemo" "flameshot"
        "libjpeg-dev" "libgif-dev" "libcairo2-dev"
    )

    # Instalamos y comprobamos si falla
    if sudo apt install -y "${DEPENDENCIES[@]}"; then
        printf "%b\n" "${CGR}Dependencias instaladas correctamente.${CNC}"
    else
        printf "%b\n" "${BLD}${CRE}¡ERROR CRÍTICO! Falló apt install. Revisa tu internet o los repos.${CNC}"
        exit 1
    fi
}

# --- 2. COMPILACIONES ---
install_i3lock_color() {
    # Solo compilamos si no está o es versión vieja
    if ! command -v i3lock &> /dev/null || ! i3lock --version | grep -q "color"; then
        logo "Compilando i3lock-color..."
        cd /tmp || exit
        [ -d "i3lock-color" ] && rm -rf i3lock-color
        git clone https://github.com/Raymo111/i3lock-color.git
        cd i3lock-color || exit
        ./install-i3lock-color.sh
        cd ~ || exit
    else
        printf "%b\n" "${CGR}i3lock-color ya está instalado.${CNC}"
    fi
}

install_picom() {
    if ! command -v picom &> /dev/null; then
        logo "Compilando Picom v12..."
        cd /tmp || exit
        [ -d "picom" ] && rm -rf picom
        git clone https://github.com/yshui/picom.git
        cd picom || exit
        git submodule update --init --recursive
        meson setup --buildtype=release build
        ninja -C build
        sudo ninja -C build install
        cd ~ || exit
    else
        printf "%b\n" "${CGR}Picom ya está instalado.${CNC}"
    fi
}

install_fastfetch() {
    if ! command -v fastfetch &> /dev/null; then
        logo "Instalando Fastfetch..."
        wget https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb -O /tmp/fastfetch.deb
        sudo dpkg -i /tmp/fastfetch.deb
        sudo apt-get install -f -y
        rm /tmp/fastfetch.deb
    fi
}

install_pokemon() {
    if ! command -v pokemon-colorscripts &> /dev/null; then
        logo "Instalando Pokemon Colorscripts..."
        cd /tmp || exit
        [ -d "pokemon-colorscripts" ] && rm -rf pokemon-colorscripts
        git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git
        cd pokemon-colorscripts || exit
        sudo ./install.sh
        cd ~ || exit
    fi
}

# --- 3. ARCHIVOS Y CONFIGURACIÓN ---
update_dotfiles() {
    logo "Actualizando Dotfiles..."
    if [ -d "$REPO_DIR/.git" ]; then
        cd "$REPO_DIR" || exit
        git reset --hard origin/main
        git pull
    else
        git clone "$REPO_URL" "$REPO_DIR"
    fi
}

install_dotfiles() {
    logo "Aplicando Configuraciones..."
    mkdir -p "$HOME/.config" "$HOME/.local/share/fonts" "$HOME/Wallpapers"

    cp -r "$REPO_DIR/config/"* "$HOME/.config/"
    
    # Fuentes
    if [ -d "$REPO_DIR/home/fonts" ]; then
        cp -r "$REPO_DIR/home/fonts/"* "$HOME/.local/share/fonts/"
        fc-cache -fv &> /dev/null
    fi

    # Wallpapers
    if [ -d "$REPO_DIR/misc/wallpapers" ]; then
        cp -r "$REPO_DIR/misc/wallpapers/"* "$HOME/Wallpapers/"
    fi

    # Scripts y permisos
    chmod +x "$HOME/.config/bspwm/bspwmrc"
    find "$HOME/.config/bspwm/scripts" -type f -exec chmod +x {} \;
}

check_session_file() {
    # Aseguramos que BSPWM aparezca en el Login
    if [ ! -f "/usr/share/xsessions/bspwm.desktop" ]; then
        logo "Reparando sesión de BSPWM..."
        # Reinstalamos solo bspwm por si acaso
        sudo apt install --reinstall -y bspwm
    fi
}

# --- EJECUCIÓN ---
initial_checks
install_dependencies
install_i3lock_color
install_picom
install_fastfetch
install_pokemon
update_dotfiles
install_dotfiles
check_session_file

printf "\n%b\n" "${BLD}${CGR}¡INSTALACIÓN CORRECTA! Reinicia ahora.${CNC}"
