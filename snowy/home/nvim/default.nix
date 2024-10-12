{
  pkgs,
  config,
  username,
  ...
}: {

   # Dependencies
   home.packages = [
      pkgs.neovim
    ];
}
