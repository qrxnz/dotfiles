#!/usr/bin/env bash

stow files --adopt

echo "source ~/.config/zshrc/zshrc" > ~/.zshrc

echo "source-file ~/.config/tmux/tmux.conf" > ~/.zshrc
