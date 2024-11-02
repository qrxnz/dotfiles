{
  options,
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.tmux;
in {
  options.apps.tmux = with types; {
    enable = mkBoolOpt false "Enable or disable the tmux.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      inputs.tmux.packages.${pkgs.system}.default
    ];

    environment.shellAliases = {
      # tmux aliases
      t = "tmux";
    };
  };
}
