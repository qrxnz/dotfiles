
{ config, pkgs, ... }:

{
  imports =
    [
      # Suites
      ../../suites/common
      ../../suites/laptop
      ../../suites/desktop

      # Modules
      ../../modules/flatpak
      ../../modules/virtualisation/qemu
      ../../modules/virtualisation/podman
      ../../modules/virtualisation/waydroid

      # Hardware
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


