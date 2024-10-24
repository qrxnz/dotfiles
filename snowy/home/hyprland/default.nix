{
  pkgs,
  config,
  username,
  ...
}: {
      # Hyprland
      wayland.windowManager.hyprland = {

      # Whether to enable Hyprland wayland compositor
      enable = true;

      # The hyprland package to use
      package = pkgs.hyprland;

      # Whether to enable XWayland
      xwayland.enable = true;

      # Optional
      # Whether to enable hyprland-session.target on hyprland startup
      systemd.enable = true;
  };

   # Dependencies
   home.packages = [
      pkgs.wofi
      pkgs.mako
      pkgs.grim
      pkgs.swappy
      pkgs.waybar
      pkgs.swaybg
      pkgs.wlogout
      pkgs.wl-clipboard
      pkgs.cinnamon.nemo
    ];

  # Gtk theme
  gtk.theme = {
    name = "catppuccin-mocha-blue-compact+default";
    package =
      (pkgs.catppuccin-gtk.overrideAttrs {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "gtk";
          rev = "v1.0.3";
          fetchSubmodules = true;
          hash = "sha256-q5/VcFsm3vNEw55zq/vcM11eo456SYE5TQA3g2VQjGc=";
        };
      postUnpack = "";
    }).override
      {
        accents = [ "sky" ];
        variant = "mocha";
        size = "compact";
      };
  };

  # Hyprland files
  home.file.".config/hypr".source = ../../../files/hypr;
  home.file.".config/hypr".recursive = true;

  # Waybar files
  home.file.".config/waybar".source = ../../../files/waybar;
  home.file.".config/waybar".recursive = true;
}
