{
  pkgs,
  config,
  username,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
  };
}
