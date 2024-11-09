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
      swaybg
      killall
      pulseaudio
      imagemagick

      numix-icon-theme-circle
      colloid-icon-theme
      catppuccin-gtk
      catppuccin-kvantum
      catppuccin-cursors.mochaSky
    ];

    # Enable Theme
    environment.variables.GTK_THEME = "catppuccin-mocha-sky-standard";
    environment.variables.XCURSOR_THEME = "Catppuccin-Mocha-Sky";
    environment.variables.XCURSOR_SIZE = "24";
    environment.variables.HYPRCURSOR_THEME = "Catppuccin-Mocha-Sky";
    environment.variables.HYPRCURSOR_SIZE = "24";
    qt.enable = true;

    qt.platformTheme = "gtk2";
    qt.style = "gtk2";
    console = {
      earlySetup = true;
      colors = [
        "24273a"
        "ed8796"
        "a6da95"
        "eed49f"
        "8aadf4"
        "f5bde6"
        "8bd5ca"
        "cad3f5"
        "5b6078"
        "ed8796"
        "a6da95"
        "eed49f"
        "8aadf4"
        "f5bde6"
        "8bd5ca"
        "a5adcb"
      ];
    };

    # Override packages
    nixpkgs.config.packageOverrides = pkgs: {
      colloid-icon-theme = pkgs.colloid-icon-theme.override {colorVariants = ["sky"];};
      catppuccin-gtk = pkgs.catppuccin-gtk.override {
        accents = ["sky"]; # You can specify multiple accents here to output multiple themes
        size = "standard";
        variant = "mocha";
      };
    };

    # Hyprland configuration files
    home.file.".config/hypr".source = ../../../../files/hypr;
    home.file.".config/hypr".recursive = true;

    # Waybar configuration files
    home.file.".config/waybar".source = ../../../../files/waybar;
    home.file.".config/waybar".recursive = true;
  };
}
