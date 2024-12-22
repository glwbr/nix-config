{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.aria.programs.terminal.shell.zsh;
  plugins = import ./plugins pkgs;

  inherit (config.home) homeDirectory;
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
  inherit (lib.strings) fileContents;
in {
  options.aria.programs.terminal.shell.zsh = {
    enable = mkBoolOpt false "Whether or not to enable zsh.";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;

      autocd = true;
      autosuggestion.enable = true;
      enableCompletion = true;

      dirHashes = {
        dl = "${homeDirectory}/Downloads";
        dev = "${homeDirectory}/projects";
        dots = "${homeDirectory}/projects/nix-config";
      };

      dotDir = ".config/zsh";

      history = {
        expireDuplicatesFirst = true;
        extended = true;
        ignoreDups = true;
        ignoreSpace = true;
        path = "${config.xdg.dataHome}/zsh/zsh_history";
        save = 100000;
        share = true;
        size = 100000;
      };

      initExtra =
        # bash
        ''
          ${fileContents ./config/misc.zsh}
          ${fileContents ./config/comp.zsh}

          # Set LS_COLORS by parsing dircolors output
          LS_COLORS="$(${lib.getExe' pkgs.coreutils "dircolors"} --sh)"
          LS_COLORS="''${''${LS_COLORS#*\'}%\'*}"
          export LS_COLORS
        '';

      inherit (plugins) plugins;

      shellAliases = {
        q = "exit";
        trimall = "sudo fstrim -va";
        tmp = "cd /tmp/";

        # home-manager
        hms = "home-manager --flake . switch";

        # ls
        l = "eza -lh";
        la = "eza -lah";
        ls = "eza --icons --color=auto --group-directories-first -s extension";
        tree = "eza --tree --icons --tree";

        # cp mv rm mkdir
        cp = "cp -vr";
        md = "mkdir -p";
        mv = "mv -v";
        rm = "rm -rv";

        # cat grep
        # cat = "bat --theme=base16 --number --color=always --paging=never --tabs=2 --wrap=never";
        grep = "rg";

        # misc
        df = "df -h";
        du = "du-dust";
        fm = "yazi";
        jctl = "journalctl -p 3 -xb";
        htop = "btm -b";
        btop = "btm";

        # youtube-dl
        ytmp3 = "yt-dlp --ignore-errors -x --audio-format mp3 -f bestaudio --audio-quality 0 --embed-metadata --embed-thumbnail --output '%(title)s.%(ext)s'";

        # systemctl
        us = "systemctl --user";
        rs = "sudo systemctl";
      };

      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "brackets"
          "line"
          "root"
        ];
      };
    };
  };
}
