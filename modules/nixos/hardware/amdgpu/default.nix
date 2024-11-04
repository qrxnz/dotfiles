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
    };

    # OpenCL & Vulkan support
    hardware.graphics.extraPackages = with pkgs; [
      amdvlk
      mesa.opencl
      rocmPackages.clr.icd
    ];
  };
}
