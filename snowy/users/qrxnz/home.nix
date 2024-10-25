{pkgs, ...}: {
  imports = [
    ../../home/core.nix
    ../../home/basic
    ../../home/shell # Shell (zsh)
    ../../home/nvim # Editor
    ../../home/vscode # Editor
    ../../home/kitty # Terminal
    ../../home/tmux # Terminal multiplexer
    ../../home/hyprland # WM
    ../../home/creative-apps
    ../../home/hardware-stuff
  ];

  programs.git = {
    userName = " qrxnz";
    userEmail = "send@qrxnz.dev";
  };
}
