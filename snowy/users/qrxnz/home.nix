{pkgs, ...}: {
  imports = [
    ../../home/core.nix
  ];

  programs.git = {
    userName = " qrxnz";
    userEmail = "send@qrxnz.dev";
  };
}
