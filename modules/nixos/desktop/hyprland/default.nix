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
  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable or disable the hyprland window manager.";
  };

  config = mkIf cfg.enable {
    # Desktop additions
    #desktop.addons = {
    #waybar.enable = true;
    #swww.enable = true;
    #wofi.enable = true;
    #mako.enable = true;
    #gtklock.enable = true;
    #wlogout.enable = true;
    #};

    apps.foot.enable = true;
    apps.kitty.enable = true;

    programs.hyprland.enable = true;
    programs.hyprland.xwayland.enable = true;
    xdg.portal.enable = true;

    environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Hint electron apps to use wayland

    environment.systemPackages = with pkgs; [
      grim
      wofi
      slurp
      swappy
      waybar
      imagemagick
      killall
      pulseaudio
    ];

    # Hyprland configuration files
    home.file.".config/hypr".source = ../../../../files/hypr;
    home.file.".config/hypr".recursive = true;

    # Waybar configuration files
    home.file.".config/waybar".source = ../../../../files/waybar;
    home.file.".config/waybar".recursive = true;
  };
}
