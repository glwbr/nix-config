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
    enable = mkBoolOpt false "Whether to manage zsh settings";
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
        trimall = "sudo fstrim -va";
        tmp = "cd /tmp/";

        ls = "eza --icons --group-directories-first";
        ll = "ls --long --header";
        lla = "ll --all --sort filename";
        tree = "ls --tree --level=3";
        cp = "cp -vr";

        df = "df -h";
        du = "dust";
        free = "free -h";
        grep = "rg";

        fm = "yazi";

        ytmp3 = "yt-dlp --ignore-errors -x --audio-format mp3 -f bestaudio --audio-quality 0 --embed-metadata --embed-thumbnail --output '%(title)s.%(ext)s'";

        jctl = "journalctl -p 3 -xb";
        rs = "sudo systemctl";
        us = "systemctl --user";

        btop = "btm";
        htop = "btm -b";

        md = "mkdir -p";
        mv = "mv -v";
        rm = "rm -rv";

        q = "exit";
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
