{
  pkgs,
  config,
  username,
  ...
}: {
    home.packages = [ 
      pkgs.syncthing
      pkgs.fastfetch
    ];
}
