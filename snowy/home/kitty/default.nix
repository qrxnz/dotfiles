{
  pkgs,
  config,
  username,
  ...
}: {
    home.packages = [ 
      pkgs.kitty 
    ];

    home.file.".config/kitty/kitty.conf".source = ../../../files/kitty/kitty.conf;
}