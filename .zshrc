# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# theme
ZSH_THEME="dpoggi"


# plugins
plugins=(git adb nmap)

source $ZSH/oh-my-zsh.sh

# aliases

alias tree='exa -l -a --icons --tree'
alias ll='exa -l'
alias l='exa -l -a'
alias connect='kitty +kitten ssh'
