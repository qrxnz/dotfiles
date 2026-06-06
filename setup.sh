#!/usr/bin/env bash

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Linux Setup
if [[ $1 == "--linux" ]]; then
  # Sync dotfiles
  stow files --adopt --ignore=homebrew

  # Prepare directories
  mkdir -p ~/.local/bin/
  mkdir -p ~/.local/share/fonts/
  mkdir -p ~/.newsboat/

  cp "$SCRIPT_DIR/rss/urls" ~/.newsboat/urls

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
  stow files --adopt

  # Prepare directories
  mkdir -p ~/.local/bin/
  mkdir -p ~/.newsboat/

  cp "$SCRIPT_DIR/rss/urls" ~/.newsboat/urls

  # Install tpm (Tmux Plugin Manager)
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # Homebrew pkgs
  xargs brew install <./files/homebrew/leaves.txt

  echo "source ~/.config/zshrc/zshrc" >~/.zshrc

  echo "source-file ~/.config/tmux/conf" >~/.tmux.conf

  cd $HOME
  echo "Installation Completed!"

else
  echo "Invalid argument. Try: ./setup.sh --linux || ./setup.sh --macos"
  exit 1
fi
