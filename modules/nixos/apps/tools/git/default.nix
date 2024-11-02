{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.tools.git;
in {
  options.apps.tools.git = with types; {
    enable = mkBoolOpt false "Enable or disable git";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      git-remote-gcrypt

      gh # GitHub cli

      lazygit
      commitizen
    ];

    home.configFile."git/config".text = import ./config.nix {
      sshKeyPath = "/home/${config.user.name}/.ssh/key.pub";
      name = "qrxnz";
      email = "send@qrxnz.dev";
    };
    home.configFile."lazygit/config.yml".source = ./lazygitConfig.yml;
  };
}
