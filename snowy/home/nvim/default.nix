{
  pkgs,
  config,
  username,
  inputs,
  system,
  ...
}: {
  #
  home.packages = [ inputs.nveem.packages.x86_64-linux.default ];
}
