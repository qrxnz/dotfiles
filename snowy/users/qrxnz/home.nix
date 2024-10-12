{pkgs, ...}: {
  imports = [
    ../../home/core.nix
    ../../home/kitty
    ../../home/vscode
  ];

  programs.git = {
    userName = " qrxnz";
    userEmail = "send@qrxnz.dev";
  };
}
