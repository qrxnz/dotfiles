
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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Install firefox.
  programs.firefox.enable = true;

}


