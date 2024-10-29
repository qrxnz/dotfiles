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
    #      # If using a stable channel you can use `url = "github:nix-community/nixvim/nixos-<version>"`
    #      inputs.nixpkgs.follows = "nixpkgs";
    #    };
    #  };

    inputs.nveem.packages.x86_64-linux.default # neovim

    # lsp / formatter / dap
    pkgs.go
    pkgs.gopls
    pkgs.delve # Go
  ];
}
