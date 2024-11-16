{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.development;
in {
  options.suites.development = with types; {
    enable = mkBoolOpt false "Enable the development suite";
  };

  config = mkIf cfg.enable {
    # Editors
    apps.neovim.enable = true;
    apps.vscodium.enable = true;

    # Misc
    apps.tools.direnv.enable = true;
    apps.misc.enable = true;

    home.configFile."nix-init/config.toml".text = ''
      maintainers = ["qrxnz"]
      commit = true
    '';

    environment.systemPackages = with pkgs; [
      # Misc
      remmina
      waypipe
      licensor

      # Nix Utils
      nix-index
      nix-init
      nix-melt
      nix-update
      nixpkgs-fmt
      nixpkgs-hammering
      nixpkgs-review
      nurl

      # Web
      atac
      burpsuite

      # DB
      postgresql
    ];
  };
}
