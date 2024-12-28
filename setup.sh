 #!/usr/bin/env bash

# Hyprland Setup
if [[ $1 == "--hyprland-default" ]]; then
  # Sync dotfiles
  stow files --adopt

  echo "source ~/.config/zshrc/zshrc" > ~/.zshrc

  cd $HOME
  echo "Installation Completed!"

else
  echo "Invalid argument. Try: ./setup.sh --hyprland-default"
  exit 1
fi
