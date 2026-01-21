# -----------------------------------------------------
# CUSTOMIZATION FISH
# -----------------------------------------------------
set POSH agnoster

# -----------------------------------------------------
# Prompt
# -----------------------------------------------------

# Borrar prompt por defecto de fish
functions --erase fish_prompt
functions --erase fish_right_prompt

set -gx PATH $HOME/.local/bin $PATH

set fish_greeting
functions --erase fish_mode_prompt

oh-my-posh init fish --config $HOME/.config/fish/Prompt/EDM115-newline.omp.json | source

#oh-my-posh init fish --config 'https://gist.githubusercontent.com/Abraam2/9f61dc82d5a632b098266cdf657133c8/raw/21cdeb29c5dfebd1597de1c9ed65778d01a90916/violet_ml4w.omp.json' | source

#Cargar la conf de color de las carpetas e iconos en termianl

# Color naranja

#eval (dircolors -c ~/.config/fish/icons/.dircolors_orange)

# Color morado

eval (dircolors -c ~/.config/fish/icons/.dircolors_vegetta)

# Color rojo

#eval (dircolors -c ~/.config/fish/icons/.dircolors_rojo)

# Color azul

#eval (dircolors -c ~/.config/fish/icons/.dircolors_blue)










