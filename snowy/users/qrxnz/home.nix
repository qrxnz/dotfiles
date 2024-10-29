{pkgs, ...}: {
  imports = [
    ../../home/core.nix
    ../../home/basic
    ../../home/shell # Shell (zsh)
    ../../home/kitty # Terminal
    ../../home/tmux # Terminal multiplexer
    ../../home/hyprland # WM
    ../../home/creative-apps

    # Dev
    ../../home/dev/nvim # Editor
    ../../home/dev/vscode # Editor

    ../../home/dev/hardware-stuff
  ];

  programs.git = {
    userName = " qrxnz";
    userEmail = "send@qrxnz.dev";
  };
}
