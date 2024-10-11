{
  pkgs,
  config,
  username,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [

      #
      # Theme
      #


      ########### The best like Polyphia the worst :P ####
      catppuccin.catppuccin-vsc ##########################
      catppuccin.catppuccin-vsc-icons ## catppuccin theme#
      ####################################################

      #
      # Language extensions
      #

      ms-python.python # python
      ms-vscode.vscode-typescript-next # js/ts
      golang.go # golang
      llvm-vs-code-extensions.vscode-clangdS # c/c++

      #
      # Others
      #

      vscodevim.vim # vim support for vscode
      yzhang.markdown-all-in-one # markdown shit
      pixl-garden.bongocat # yes, I like cats
    ];
  };
}
