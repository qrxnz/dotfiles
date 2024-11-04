{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.amdgpu;
in {
  options.hardware.amdgpu = with types; {
    enable = mkBoolOpt false "Enable needed features for amdgpu";
  };

  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;

      driSupport = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [
        amdvlk
        mesa.opencl
        rocmPackages.clr.icd
      ];
    };

    # Others
    environment.systemPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
