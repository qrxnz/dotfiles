{
  pkgs,
  config,
  username,
  inputs,
  system,
  ...
}: {
  home.packages = [
    # flake.nix
    #
    #  inputs = {
    #    nveem = {
    #      url = "github:qrxnz/nveem";
    #      inputs.nixpkgs.follows = "nixpkgs";
    #    };
    #  };

    inputs.nveem.packages.${pkgs.system}.default # neovim

    # lsp / formatter / dap
    pkgs.go
    pkgs.gopls
    pkgs.delve # Go
    pkgs.alejandra # Nix
  ];
}
