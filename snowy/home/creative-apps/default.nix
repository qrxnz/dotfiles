{
  pkgs,
  config,
  username,
  ...
}: {
  home.packages = [
    # video
    pkgs.shotcut
    pkgs.davinci-resolve

    # images
    pkgs.figma-linux
  ];
}
