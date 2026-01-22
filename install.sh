#!/bin/bash
# ==============================================================================
#  INSTALLER FINAL - VERSION AMONG US + BACKUP
# ==============================================================================

# Colores
CRE=$(tput setaf 1); CYE=$(tput setaf 3); CGR=$(tput setaf 2); CBL=$(tput setaf 4); BLD=$(tput bold); CNC=$(tput sgr0)

# CONFIGURACIÓN
REPO_URL="https://github.com/Abraam2/shit_bspwm_rice"
REPO_DIR="$HOME/mis-dotfiles"

# --- 0. ARTE Y MENSAJES ---

logo() {
    text="$1"
    printf "%b" "
${BLD}${CRE}
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
${CNC}
   ${BLD}${CRE}[ ${CYE}${text} ${CRE}]${CNC}\n\n"
}

initial_checks() {
    if [ "$(id -u)" = 0 ]; then printf "%b" "${BLD}${CRE}¡NO lo ejecutes como root!${CNC}\n"; exit 1; fi
}

welcome() {
    clear
    logo "Bienvenido $USER"

    printf "%b" "${BLD}${CGR}Este script hecho completamente con IA instalará mi basura de RICE en Ubuntu/Debian, no tiene capacidad para romper tus sistema:${CNC}

  ${BLD}${CGR}[${CYE}1${CGR}]${CNC} Actualizar sistema e instalar dependencias
  ${BLD}${CGR}[${CYE}2${CGR}]${CNC} Compilar Picom v12 y i3lock-color
  ${BLD}${CGR}[${CYE}3${CGR}]${CNC} Instalar Fastfetch y Pokemon-Colorscripts
  ${BLD}${CGR}[${CYE}4${CGR}]${CNC} Hacer BACKUP de tu configuración actual
  ${BLD}${CGR}[${CYE}5${CGR}]${CNC} Instalar Dotfiles (Fuentes, Temas, Configs)

${BLD}${CRE}[!]${CNC} ${BLD}${CRE}Revisa que tengas internet.${CNC}
"

    while :; do
        printf " %b" "${BLD}${CGR}¿Quieres continuar?${CNC} [y/N]: "
        read -r yn
        case "$yn" in
            [Yy]) break ;;
            [Nn]|"") printf "\n%b\n" "${BLD}${CYE}Cancelado.${CNC}"; exit 0 ;;
            *) printf "\n%b\n" "${BLD}${CRE}Escribe 'y' o 'n'${CNC}" ;;
        esac
    done
}

# --- 1. BACKUP (LO QUE PEDISTE) ---

backup_existing_config() {
    logo "Haciendo Backup de Seguridad"
    
    # Creamos carpeta con fecha y hora
    TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
    BACKUP_DIR="$HOME/.RiceBackup/$TIMESTAMP"
    mkdir -p "$BACKUP_DIR"

    printf "%b\n" "${BLD}${CYE}>>> GUARDANDO TUS COSAS AQUÍ:${CNC}"
    printf "%b\n" "${BLD}${CBL}    $BACKUP_DIR ${CNC}\n"
    sleep 2

    # Carpetas críticas de .config
    DIRS="bspwm sxhkd polybar rofi kitty picom dunst fish fastfetch ncmpcpp mpd"
    
    for dir in $DIRS; do
        if [ -d "$HOME/.config/$dir" ]; then
            cp -r "$HOME/.config/$dir" "$BACKUP_DIR/"
            printf "  [OK] Salvado: .config/$dir\n"
        fi
    done

    # Archivos sueltos del HOME
    FILES=".gtkrc-2.0 .fehbg .zshrc .bashrc .profile .xinitrc"
    for f in $FILES; do
        if [ -f "$HOME/$f" ]; then
            cp "$HOME/$f" "$BACKUP_DIR/"
            printf "  [OK] Salvado: $f\n"
        fi
    done

    printf "\n%b\n" "${BLD}${CGR}Backup completado. Podemos romper cosas tranquilos.${CNC}"
    sleep 2
}

# --- 2. DEPENDENCIAS BLINDADAS ---

install_dependencies() {
    logo "Instalando Dependencias (APT)"
    sudo apt update
    
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

    if sudo apt install -y "${DEPENDENCIES[@]}"; then
        printf "%b\n" "${CGR}Dependencias instaladas correctamente.${CNC}"
    else
        printf "%b\n" "${BLD}${CRE}¡ERROR CRÍTICO! Falló apt install.${CNC}"
        exit 1
    fi
}

# --- 3. COMPILACIONES ---

install_i3lock_color() {
    if ! command -v i3lock &> /dev/null || ! i3lock --version | grep -q "color"; then
        logo "Compilando i3lock-color"
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
        logo "Compilando Picom v12"
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
        logo "Instalando Fastfetch"
        wget https://github.com/fastfetch-cli/fastfetch/releases/latest/download/fastfetch-linux-amd64.deb -O /tmp/fastfetch.deb
        sudo dpkg -i /tmp/fastfetch.deb
        sudo apt-get install -f -y
        rm /tmp/fastfetch.deb
    fi
}

install_pokemon() {
    if ! command -v pokemon-colorscripts &> /dev/null; then
        logo "Instalando Pokemon Colorscripts"
        cd /tmp || exit
        [ -d "pokemon-colorscripts" ] && rm -rf pokemon-colorscripts
        git clone https://gitlab.com/phoneybadger/pokemon-colorscripts.git
        cd pokemon-colorscripts || exit
        sudo ./install.sh
        cd ~ || exit
    fi
}

# --- 4. INSTALACIÓN DE DOTFILES ---

update_dotfiles() {
    logo "Actualizando Dotfiles"
    if [ -d "$REPO_DIR/.git" ]; then
        cd "$REPO_DIR" || exit
        git reset --hard origin/main
        git pull
    else
        git clone "$REPO_URL" "$REPO_DIR"
    fi
}

install_dotfiles() {
    logo "Aplicando Configuraciones"
    
    mkdir -p "$HOME/.config" "$HOME/.local/share/fonts" "$HOME/Wallpapers"

    cp -r "$REPO_DIR/config/"* "$HOME/.config/"
    
    if [ -d "$REPO_DIR/home/fonts" ]; then
        cp -r "$REPO_DIR/home/fonts/"* "$HOME/.local/share/fonts/"
        fc-cache -fv &> /dev/null
    fi

    if [ -d "$REPO_DIR/misc/wallpapers" ]; then
        cp -r "$REPO_DIR/misc/wallpapers/"* "$HOME/Wallpapers/"
    fi

    chmod +x "$HOME/.config/bspwm/bspwmrc"
    find "$HOME/.config/bspwm/scripts" -type f -exec chmod +x {} \;
}

check_session_file() {
    if [ ! -f "/usr/share/xsessions/bspwm.desktop" ]; then
        logo "Reparando sesión de BSPWM..."
        sudo apt install --reinstall -y bspwm
    fi
}

# --- 5. EJECUCIÓN ---

initial_checks
welcome                 # <- El menú que pedías
backup_existing_config  # <- El backup explícito
install_dependencies
install_i3lock_color
install_picom
install_fastfetch
install_pokemon
update_dotfiles
install_dotfiles
check_session_file

clear
logo "¡INSTALACIÓN COMPLETADA!"
printf "%b\n" "${BLD}${CGR}Reinicia ahora.${CNC}"
printf "%b\n" "${BLD}${CYE}Olvidona: Si la lías, tu backup está en ~/.RiceBackup${CNC}\n"
printf "%b\n" "${BLD}${CYE}Bebe agua${CNC}\n"
