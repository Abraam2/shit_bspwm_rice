# -----------------------------------------------------
# INIT
# -----------------------------------------------------

set -U fish_greeting ""
zoxide init fish | source

# -----------------------------------------------------
# Exports
# -----------------------------------------------------
export EDITOR=nano

set -U fish_user_paths "/usr/lib/ccache/bin/"
set -U fish_user_paths "$fish_user_paths" "~/.cargo/bin/"
set -U fish_user_paths "$fish_user_paths" "~/.local/bin/"