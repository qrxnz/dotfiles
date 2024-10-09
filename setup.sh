#!/usr/bin/env bash

if [[ "$1" == "--hyprland-default" ]]; then
    stow files --adopt

    echo "source ~/.config/zshrc/zshrc" > ~/.zshrc
    echo "source-file ~/.config/tmux/tmux.conf" > ~/.tmux.conf
    
    cd $HOME
    echo "Installation Completed!"

elif [[ "$1" == "--kali-linux" ]]; then
    sudo apt update && sudo apt upgrade -y
    sudo apt-get install -y wget curl git thunar stow neovim podman zoxide fzf \
    xsel xclip duf eza bat flameshot feh kitty tmux picom \
    golang delve clang ccls gdb cargo

    mkdir -p ~/.local/bin/
    mkdir -p ~/.local/share/fonts/

    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
    
    unzip JetBrainsMono.zip -d ~/.local/share/fonts/

    rm ./JetBrainsMono.zip
    
    fc-cache -fv
    
    curl -fsSL https://bun.sh/install | bash
    curl -sS https://starship.rs/install.sh | sh
    sh <(curl -L https://nixos.org/nix/install) --no-daemon
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    
    stow files --adopt --ignore=hyprland --ignore=waybar
    
    echo "source ~/.config/zshrc/zshrc" > ~/.zshrc
    echo "source-file ~/.config/tmux/tmux.conf" > ~/.tmux.conf
    
    cd $HOME
    echo "Installation Completed!"

else
    echo "Invalid argument. Try: ./setup.sh --hyprland-default or ./setup.sh --kali-linux"
    exit 1
fi
