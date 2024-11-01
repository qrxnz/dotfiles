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
      inputs.nveem.packages.${pkgs.system}.default

      pkgs.lazygit
      pkgs.stylua
      pkgs.sumneko-lua-language-server
      pkgs.ripgrep
    ];
  };
}
