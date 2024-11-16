#!/usr/bin/env bash

# Hyprland Setup
if [[ $1 == "--hyprland-default" ]]; then
  # Sync dotfiles
  stow files --adopt

  echo "source ~/.config/zshrc/zshrc" > ~/.zshrc
  echo "source-file ~/.config/tmux/tmux.conf" > ~/.tmux.conf

  cd $HOME
  echo "Installation Completed!"

# Kali Linux Setup
elif [[ $1 == "--kali-linux" ]]; then
  # Install dependencies
  sudo apt update && sudo apt upgrade -y
  sudo apt-get install -y wget curl git thunar stow neovim podman zoxide fzf \
    xsel xclip duf eza bat flameshot feh kitty tmux picom  xrdp\
    golang delve clang ccls gdb cargo

  # Prepare directories
  mkdir -p ~/.local/bin/
  mkdir -p ~/.local/share/fonts/

  # Download & Install font
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip

  unzip JetBrainsMono.zip -d ~/.local/share/fonts/

  rm ./JetBrainsMono.zip

  fc-cache -fv
  
  # Install bun (js runtime)
  curl -fsSL https://bun.sh/install | bash

  # Install starship
  curl -sS https://starship.rs/install.sh | sh

  # Install nix
  sh <(curl -L https://nixos.org/nix/install) --no-daemon

  # Install TPM (Tmux Plugin Manager)
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # Install zplug (ZSH Plugin Manager)
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

  # Sync dotfiles
  stow files --adopt --ignore=hyprland --ignore=waybar --ignore=foot

  echo "source ~/.config/zshrc/zshrc" > ~/.zshrc
  echo "source-file ~/.config/tmux/tmux.conf" > ~/.tmux.conf

  # Enable SSH
  sudo systemctl enable ssh --now
  
  # Enable RDP
  sudo systemctl enable xrdp --now
  
  cd $HOME
  
  echo "Installation Completed!"

else
  echo "Invalid argument. Try: ./setup.sh --hyprland-default or ./setup.sh --kali-linux"
  exit 1
fi
