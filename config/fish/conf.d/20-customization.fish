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

set fish_greeting
functions --erase fish_mode_prompt

oh-my-posh init fish --config $HOME/.config/fish/prompt/EDM115-newline.omp.json | source

#Cargar la conf de color de las carpetas e iconos en termianl

# Color naranja

#eval (dircolors -c ~/.config/fish/icons/.dircolors_orange)

# Color morado

eval (dircolors -c ~/.config/fish/icons/.dircolors_vegetta)

# Color rojo

#eval (dircolors -c ~/.config/fish/icons/.dircolors_rojo)

# Color azul

#eval (dircolors -c ~/.config/fish/icons/.dircolors_blue)










