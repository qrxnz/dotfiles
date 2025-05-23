{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.desktop;
in {
  options.suites.desktop = with types; {
    enable = mkBoolOpt false "Enable the desktop suite";
  };

  config = mkIf cfg.enable {
    desktop.hyprland.enable = true;

    apps.tmux.enable = true;

    apps.tools.gnupg.enable = true;

    suites.common.enable = true;

    services.flatpak.enable = true;

    services.sync.enable = true;

    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
    };

    #environment.persist.directories = [
    #"/etc/gdm"
    #];

    environment.systemPackages = with pkgs; [
      nemo
      glfw
      xclip
      xarchiver
      pavucontrol
    ];
  };
}
