
{ config, pkgs, ... }:

{
  imports =
    [
      ../../suites/common
      ../../suites/desktop
      ../../modules/flatpak
      ../../modules/virtualisation/qemu
      ../../modules/virtualisation/podman
      ../../modules/virtualisation/waydroid
      ./hardware-configuration.nix
    ];

  # Hostname
  networking.hostName = "mentay";

  # Unsupported GPU Processing Mode Fix
  hardware.opengl = {
   enable = true;
   extraPackages = with pkgs; [
     rocmPackages.clr.icd
   ];
  };
}


