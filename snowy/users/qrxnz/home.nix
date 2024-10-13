{pkgs, ...}: {
  imports = [
    ../../home/core.nix
    ../../home/basic
    ../../home/nvim # Editor
    ../../home/vscode # Editor
    ../../home/kitty # Terminal
    ../../home/hyprland # WM
  ];

  programs.git = {
    userName = " qrxnz";
    userEmail = "send@qrxnz.dev";
  };
}
