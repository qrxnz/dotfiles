{
  pkgs,
  config,
  username,
  ...
}: {
  home.packages = [
    # formatters
    pkgs.treefmt2
    pkgs.shfmt
    pkgs.mdformat
    pkgs.alejandra
    pkgs.stylua
  ];
}
