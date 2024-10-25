{
  pkgs,
  config,
  username,
  inputs,
  system,
  ...
}: {
  #
  home.packages = [ inputs.nixvim.packages.x86_64-linux.default ];
}
