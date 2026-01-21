# -----------------------------------------------------
# GENERAL
# -----------------------------------------------------
alias c='clear'
alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'
alias bum='systemctl poweroff'
alias shutdown='systemctl poweroff'


# -----------------------------------------------------
# Random
# -----------------------------------------------------

alias ospina='ssh batoi@172.17.222.20'
alias clase='xprop | grep WM_CLASS'
alias suso='sudo'
# -----------------------------------------------------
# ARCHIVOS Y NAVEGACIÓN
# -----------------------------------------------------
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -v'
alias mkdir='mkdir -p'
alias f='finder'
alias ..='cd ..'
alias ...='cd ../..'

# 1. Carga zoxide
zoxide init fish | source

# 2. Sobrescribe z para que haga cd y luego ls
function z
    __zoxide_z $argv
    ls
end

# -----------------------------------------------------
# HERRAMIENTAS MODERNAS
# -----------------------------------------------------
#alias ls='eza -a --icons=always --group-directories-first -I ".vboxclient*"'
alias ls='eza -a --icons=always --group-directories-first'
alias ll='eza -alh --icons=always --group-directories-first'
alias lt='eza -a --tree --level=1 --icons=always'
alias cat='batcat --paging=never'
alias catn='batcat'
alias grep='rg'
alias fd='fdfind'
alias df='duf'
alias du='dust'
alias top='btop'
alias htop='btop'
alias disco='ncdu'
alias man='tldr'

# -----------------------------------------------------
# DOCKER Y NALA
# -----------------------------------------------------
alias upgrade='sudo nala update && sudo nala upgrade'
alias full-upgrade='sudo nala update && sudo nala full-upgrade'
alias update='sudo nala update'
alias fetch='sudo nala fetch'
alias pon='sudo docker start pvzge'
alias poff='sudo docker stop pvzge'
