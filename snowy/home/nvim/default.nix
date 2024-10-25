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

  # neovim files
  home.file.".config/nvim".source = ../../../files/nvim;
  home.file.".config/nvim".recursive = true;
}
