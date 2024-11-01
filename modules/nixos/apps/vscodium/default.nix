{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.vscodium;
in {
  options.apps.vscodium = with types; {
    enable = mkBoolOpt false "Enable or disable the vscodium";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.vscodium-fhs];
  };
}
