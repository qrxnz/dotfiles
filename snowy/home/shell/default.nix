{
  pkgs,
  config,
  username,
  ...
}: {
  home.packages = [
    pkgs.eza
    pkgs.duf
    pkgs.lsof
    pkgs.ranger
    pkgs.direnv
    pkgs.zoxide
    pkgs.netcat-openbsd
  ];

  programs = {
    nushell = {
      enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      # configFile.source = ./.../config.nu;
      # for editing directly to config.nu
      extraConfig = ''
        let carapace_completer = {|spans|
        carapace $spans.0 nushell $spans | from json
        }
        $env.config = {
         show_banner: false,
         completions: {
         case_sensitive: false # case-sensitive completions
         quick: true    # set to false to prevent auto-selecting completions
         partial: true    # set to false to prevent partial filling of the prompt
         algorithm: "fuzzy"    # prefix or fuzzy
         external: {
         # set to false to prevent nushell looking into $env.PATH to find more suggestions
             enable: true
         # set to lower can improve completion performance at the cost of omitting some options
             max_results: 100
             completer: $carapace_completer # check 'carapace_completer'
           }
         }
        }
        $env.PATH = ($env.PATH |
        split row (char esep) |
        prepend /home/myuser/.apps |
        append /usr/bin/env
        )
      '';
      shellAliases = {
        v = "nvim";
        vi = "nvim";
        vim = "nvim";
        nano = "nvim";

        vs = "codium";
        vsc = "codium";

        # git
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

        # eza (modern ls replacement)
        ls = "eza --icons";
        ll = "eza -l --icons";
        l = "eza -l -a --icons";

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
        rlear = "clear";
        rclear = "clear";
        rcle = "clear";
        rcler = "clear";
        cls = "clear";
        csl = "clear";

        # Nix/NixOS
        x = "nix run .";
        nd = "nix develop";
        nosr = "bash -c 'sudo nixos-rebuild switch --flake .#$HOSTNAME'";

        # other
        t = "tmux";
        df = "duf";
        rr = "ranger";
        up = "bash -c 'lsof -i | grep LISTEN'";
        cds = "du -h --max-depth=1 .";
        www = "sudo python3 -m http.server 80";
        tcp-server = "bash -c 'cd /tmp/ && while :; do nc -l -p 4444 | tee  output.log; sleep 1; done'";
      };
    };

    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    starship = {
      enable = true;
      settings = {
        add_newline = true;
      };
    };
  };
}
