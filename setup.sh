#!/usr/bin/env bash

# Hyprland Setup
if [[ $1 == "--hyprland-default" ]]; then
  # Sync dotfiles
  stow files --adopt --ignore=homebrew

  # Prepare directories
  mkdir -p ~/.local/bin/
  mkdir -p ~/.local/share/fonts/

  # Install zplug (ZSH Plugin Manager)
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

  # Install tpm (Tmux Plugin Manager)
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # Download & Install font
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
  unzip JetBrainsMono.zip -d ~/.local/share/fonts/
  rm ./JetBrainsMono.zip

  echo "source ~/.config/zshrc/zshrc" >~/.zshrc

  echo "source-file ~/.config/tmux/conf" >~/.tmux.conf

  cd $HOME
  echo "Installation Completed!"

elif [[ $1 == "--macos" ]]; then
  # Sync dotfiles
  stow files --adopt --ignore=hyprland --ignore=waybar --ignore=wlogoout

  # Prepare directories
  mkdir -p ~/.local/bin/

  # Install zplug (ZSH Plugin Manager)
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

  # Install tpm (Tmux Plugin Manager)
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # Homebrew pkgs
  xargs brew install <./files/homebrew/leaves.txt

  echo "source ~/.config/zshrc/zshrc" >~/.zshrc

  echo "source-file ~/.config/tmux/conf" >~/.tmux.conf

  cd $HOME
  echo "Installation Completed!"

elif [[ $1 == "--shell-only" ]]; then
  # Sync dotfiles
  stow files --adopt --ignore=homebrew --ignore=hyprland --ignore=waybar --ignore=wlogoout --ignore=kitty --ignore=foot

  # Prepare directories
  mkdir -p ~/.local/bin/

  # Install zplug (ZSH Plugin Manager)
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

  # Install tpm (Tmux Plugin Manager)
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  echo "source ~/.config/zshrc/zshrc" >~/.zshrc

  echo "source-file ~/.config/tmux/conf" >~/.tmux.conf

  cd $HOME
  echo "Installation Completed!"

else
  echo "Invalid argument. Try: ./setup.sh --hyprland-default || ./setup.sh --shell-only || ./setup.sh --macos"
  exit 1
fi
