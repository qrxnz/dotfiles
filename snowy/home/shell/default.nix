
{
  pkgs,
  config,
  username,
  ...
}: {
    home.packages = [ 
      pkgs.eza
      pkgs.duf
      pkgs.ranger
      pkgs.zoxide
    ];

    programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      # git
      gaa="git add .";
      gcm="git commit -m";
      gsu="git submodule update --remote";
      gsa="git submodule add";
      gpush="git push -u origin";
      gpull="git pull";
      grb="git rebase";
      grbc="git rebase --continue";
      gch="git checkout";
      grr="git review -R";

      # eza (modern ls replacement)
      ls="eza --icons";
      ll="eza -l --icons";
      l="eza -l -a --icons";

      tree="eza -l -a --icons --tree --ignore-glob='.git'";
      tre="eza -l -a --icons --tree --level 2 --ignore-glob='.git'";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}