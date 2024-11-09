{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.virtualisation.docker-container;
in {
  options.virtualisation.docker-container = with types; {
    enable = mkBoolOpt false "Whether or not to enable docker.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.arion
      pkgs.lazydocker
    ];

    virtualisation.docker.enable = true;
  };
}
