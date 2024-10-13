{ pkgs, config, ... }: {
  users.users.qrxnz = {
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
