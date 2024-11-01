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
  cfg = config.apps.kitty;
in {
  options.apps.kitty = with types; {
    enable = mkBoolOpt false "Enable or disable the kitty terminal.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.kitty];
  };
}
