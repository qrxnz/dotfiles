{
  pkgs,
  config,
  username,
  ...
}: {
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

   home.packages = [
      pkgs.wofi
      pkgs.mako
      pkgs.waybar
      pkgs.wlogout
      pkgs.wl-clipboard
    ];

  # Hyprland files
  home.file.".config/hypr".source = ../../../files/hypr;
  home.file.".config/hypr".recursive = true;
  
  # Waybar files
  home.file.".config/waybar".source = ../../../files/waybar;
  home.file.".config/waybar".recursive = true;
}