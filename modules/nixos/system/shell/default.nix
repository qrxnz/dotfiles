{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.shell;
in {
  options.system.shell = with types; {
    shell = mkOpt (enum ["nushell" "fish"]) "nushell" "What shell to use";
  };

  config = {
    environment.systemPackages = with pkgs; [
      eza
      bat
      nitch
      zoxide
      starship
    ];

    users.defaultUserShell = pkgs.${cfg.shell};
    users.users.root.shell = pkgs.bashInteractive;

    home.programs.starship = {
      enable = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };
    home.configFile."starship.toml".source = ./starship.toml;

    environment.shellAliases = {
      # Ricing
      neofetch = "nitch";

      # zoxide (modern cd replacement)
      cd = "z";

      ".." = "z ..";
      "..." = "z ../..";
      "...." = "z ../../..";
      "....." = "z ../../../..";
      "......" = "z ../../../../..";

      # Git aliases
      gaa = "git add .";
      gcm = "git commit -m";
      gsu = "git submodule update --remote";
      gsa = "git submodule add";
      gpush = "git push -u origin";
      gpull = "git pull";
      grb = "git rebase";
      grbc = "git rebase --continue";
      gch = "git checkout";
      grr = "git review -R";

      # nix
      x = "nix run .";

      # mental issues
      lcs = "clear";
      cleare = "clear";
      clea = "clear";
      cear = "clear";
      lcear = "clear";
      clera = "clear";
      celar = "clear";
      cler = "clear";
      claer = "clear";
      clearc = "clear";
      cleawr = "clear";
      caler = "clear";
      calar = "clear";
      cclear = "clear";
      rclear = "clear";
      rlear = "clear";
      rcle = "clear";
      rcler = "clear";
      cls = "clear";
      csl = "clear";
    };

    home.programs.zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };

    # Actual Shell Configurations
    home.programs.fish = mkIf (cfg.shell == "fish") {
      enable = true;
      shellAliases = {
        ls = "eza -la --icons --no-user --no-time --git -s type";
        cat = "bat";
      };
      shellInit = ''
        ${mkIf apps.tools.direnv.enable ''
          direnv hook fish | source
        ''}

        zoxide init fish | source

        function , --description 'add software to shell session'
              nix shell nixpkgs#$argv[1..-1]
        end
      '';
    };

    # Enable all if nushell
    home.programs.nushell = mkIf (cfg.shell == "nushell") {
      enable = true;
      shellAliases = config.environment.shellAliases // {ls = "ls";};
      envFile.text = "";
      extraConfig = ''
        $env.config = {
        	show_banner: false,
        }

        def , [...packages] {
            NIXPKGS_ALLOW_UNFREE=1 nix shell ...($packages | each {|s| $"nixpkgs#($s)"}) --impure
        }
      '';
    };
  };
}
