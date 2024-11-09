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
  cfg = config.virtualisation.android;
in {
  options.virtualisation.android = with types; {
    enable = mkBoolOpt false "Whether or not to enable waydroid";
  };

  config = mkIf cfg.enable {
    virtualisation = {
      waydroid.enable = true;
      lxd.enable = true;
    };
  };
}
