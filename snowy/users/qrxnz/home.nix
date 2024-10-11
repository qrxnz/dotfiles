{pkgs, ...}: {
  imports = [
    ../../home/core.nix
    ../../home/vscode
  ];

  programs.git = {
    userName = " qrxnz";
    userEmail = "send@qrxnz.dev";
  };
}
