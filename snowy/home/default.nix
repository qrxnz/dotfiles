{ config, pkgs, ... }: {
  home-manager.users.qrxnz = { pkgs, ... }: {
    home.packages = [
    pkgs.atool
    pkgs.httpie
    pkgs.neofetch
    ];

    programs.bash.enable = true;

    home.stateVersion = "24.05";
  };
}
