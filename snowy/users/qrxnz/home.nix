{pkgs, ...}: {
  imports = [
    ../../home/core.nix
    ../../home/kitty
    ../../home/hyprland
  ];

  programs.git = {
    userName = " qrxnz";
    userEmail = "send@qrxnz.dev";
  };
}
