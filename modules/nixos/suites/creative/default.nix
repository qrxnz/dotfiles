{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.creative;
in {
  options.suites.creative = with types; {
    enable = mkBoolOpt false "Enable the creative suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      # Video
      shotcut
      davinci-resolve
    ];
  };
}
