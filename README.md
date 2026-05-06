# dotfiles

My configuration is tailored for tasks in the areas of DevOps and IT security. The key details I emphasized are reproducibility and a personalized experience to achieve an efficient and enjoyable workflow.

<div style="display: flex; justify-content: center; flex-wrap: wrap;">
    <img src="./.github/assets/img/macos.png" style="margin: 5px; width: 45%;">
</div>

## ⚒️ Installation

```sh
git clone --recursive https://github.com/qrxnz/dotfiles  ~/.dotfiles &&\
cd ~/.dotfiles &&\
chmod +x ./setup.sh
```

### 🐧 Linux

Prerequisite: `stow`, `zsh`, `curl`

> \[!WARNING\]
> Remember to install the necessary packages on your distribution.

```sh
./setup.sh --linux
```

### 🍏 MacOS

Prerequisite: `homebrew`, `stow`, `curl`

```sh
./setup.sh --macos
```

### 👾 Others

#### 🐱 Neovim

If you want to use my neovim configuration, I recommend installing it through nix profile:

```sh
nix profile install github:qrxnz/nveem
```

## 🗒️ Credits

### 🎨 Inspiration

I was inspired by:

- [jazzpiazz](https://github.com/jazzpizazz/zsh-aliases)
- [ptrcnull](https://github.com/ptrcnull/dotfiles)
- [omerxx](https://github.com/omerxx/dotfiles)
- [IogaMaster](https://github.com/IogaMaster/dotfiles)
- [ryan4yin](https://github.com/ryan4yin/nix-config)
- [redyf](https://github.com/redyf/nixdots)
- [Usergh0st](https://github.com/Usergh0st/bspwm)

### 🐈 Theme

I use [Catppuccin](https://catppuccin.com/) in every part of my config!

### ❤️ Special thanks

To [redyf](https://github.com/redyf/wallpapers) for the amazing wallpapers!
