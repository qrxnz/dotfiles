{
  inputs,
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.neovim;
in {
  options.apps.neovim = with types; {
    enable = mkBoolOpt false "Enable or disable neovim";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      EDITOR = "nvim";
    };
    environment.systemPackages = [
      inputs.nveem.packages.${pkgs.stdenv.hostPlatform.system}.default

      pkgs.lazygit
      pkgs.stylua
      pkgs.lua-language-server
      pkgs.ripgrep
    ];

    environment.shellAliases = {
      # nvim aliases
      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      nano = "nvim";
    };
  };
}
