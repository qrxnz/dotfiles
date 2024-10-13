{
  config,
  ...
}: {
  imports = [
    ./fonts.nix
  ];

    # Hyprland
  programs.hyprland.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Wayland issue
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
