 #!/usr/bin/env bash

# Sprawdzenie, czy argument --hyprland-default został podany
if [[ "$1" == "--hyprland-default" ]]; then
    stow files --adopt

    echo "source ~/.config/zshrc/zshrc" > ~/.zshrc
    echo "source-file ~/.config/tmux/tmux.conf" > ~/.tmux.conf
else
    echo "Invalid argument"
    exit 1
fi
