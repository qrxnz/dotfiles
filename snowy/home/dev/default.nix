{
  pkgs,
  config,
  username,
  ...
}: {
  home.packages = [
    pkgs.treefmt2
  ];
}
