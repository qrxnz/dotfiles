{
  pkgs,
  config,
  username,
  ...
}: {
  home.packages = [
    # serial communication shit
    pkgs.minicom

    # radio shit
    pkgs.sdrpp

    # logic analyzer shit
    pkgs.saleae-logic-2
    pkgs.openhantek6022
  ];
}
