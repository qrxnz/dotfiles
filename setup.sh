 #!/usr/bin/env bash

# Hyprland Setup
if [[ $1 == "--hyprland-default" ]]; then
  # Sync dotfiles
  stow files --adopt --ignore=homebrew

  # Prepare directories
  mkdir -p ~/.local/bin/
  mkdir -p ~/.local/share/fonts/
  
  # Install nix
  sh <(curl -L https://nixos.org/nix/install) --no-daemon

  # Install zplug (ZSH Plugin Manager)
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

  # Download & Install font
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip

  unzip JetBrainsMono.zip -d ~/.local/share/fonts/

  rm ./JetBrainsMono.zip

  echo "source ~/.config/zshrc/zshrc" > ~/.zshrc

  cd $HOME
  echo "Installation Completed!"

elif [[ $1 == "--macos" ]]; then
  # Sync dotfiles
  stow files --adopt --ignore=hyprland --ignore=waybar --ignore=wlogoout
  
  # Prepare directories
  mkdir -p ~/.local/bin/

   # Install nix
  sh <(curl -L https://nixos.org/nix/install) --no-daemon

  # Install zplug (ZSH Plugin Manager)
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

  # homebrew pkgs
  xargs brew install < leaves.txt

  echo "source ~/.config/zshrc/zshrc" > ~/.zshrc

  cd $HOME
  echo "Installation Completed!"

else
  echo "Invalid argument. Try: ./setup.sh --hyprland-default or ./setup.sh --macos"
  exit 1
fi
