{
  pkgs,
  config,
  username,
  ...
}: {
    home.packages = [ 
      # video
      pkgs.shotcut

      # images
      pkgs.figma-linux
    ];
    
}