{pkgs, ...}: {
  imports = [
    ../../home/core.nix
    ../../home/kitty
    ../../home/vscode
    ../../home/hyprland
  ];

  programs.git = {
    userName = " qrxnz";
    userEmail = "send@qrxnz.dev";
  };
}
