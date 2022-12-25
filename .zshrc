#        _                             _     
#       | |                           | |    
#   ___ | |__  _ __ ___  _   _ _______| |__  
#  / _ \| '_ \| '_ ` _ \| | | |_  / __| '_ \ 
# | (_) | | | | | | | | | |_| |/ /\__ \ | | |
#  \___/|_| |_|_| |_| |_|\__, /___|___/_| |_|
#                         __/ |              
#                        |___/               


export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gentoo"

plugins=(git)

source $ZSH/oh-my-zsh.sh


#        _ _                     
#       | (_)                    
#   __ _| |_  __ _ ___  ___  ___ 
#  / _` | | |/ _` / __|/ _ \/ __|
# | (_| | | | (_| \__ \  __/\__ \
#  \__,_|_|_|\__,_|___/\___||___/
                                
                                
alias ymi="sudo yum install -y"
alias ymr="sudo yum remove -y"
alias ymu="sudo yum upgrade -y"
alias yms="yum search"
alias ymc="sudo yum clean -y"
alias ymri="sudo yum reinstall -y"

alias tree='exa -l -a --icons --tree'
alias ll='exa -l'
alias l='exa -l -a'
