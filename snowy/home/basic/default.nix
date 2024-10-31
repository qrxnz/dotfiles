{
  pkgs,
  config,
  username,
  ...
}: {
  home.packages = [
    # media
    pkgs.mpv
    pkgs.amberol

    # remote desktop
    pkgs.remmina

    # others
    pkgs.syncthing
    pkgs.fastfetch
  ];
}
