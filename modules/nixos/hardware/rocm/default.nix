{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.rocm;
in {
  options.hardware.rocm = with types; {
    enable = mkBoolOpt false "Enable rocm";
  };

  config = mkIf cfg.enable {
    hardware.opengl = {
      enable = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };
  };
}
