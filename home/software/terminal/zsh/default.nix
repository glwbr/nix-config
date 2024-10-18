{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.programs.terminal.zsh;
  plugins = import ./plugins.nix pkgs;

  inherit (config.home) homeDirectory;
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
  inherit (lib.strings) fileContents;
in
{
  options.aria.programs.terminal.zsh = {
    enable = mkBoolOpt true "Whether or not to enable zshell.";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;

      autocd = true;
      autosuggestion.enable = true;

      completionInit =
        # bash
        ''
          autoload -U compinit
          zmodload zsh/complist

          _comp_options+=(globdots)
          zcompdump="$XDG_DATA_HOME"/zsh/.zcompdump-"$ZSH_VERSION"-"$(date --iso-8601=date)"
          compinit -d "$zcompdump"

          if [[ -s "$zcompdump" && (! -s "$zcompdump".zwc || "$zcompdump" -nt "$zcompdump".zwc) ]]; then
            zcompile "$zcompdump"
          fi

          autoload -U +X bashcompinit && bashcompinit
          ${fileContents ./config/comp.zsh}
        '';

      dirHashes = {
        dl = "${homeDirectory}/Downloads";
        dev = "${homeDirectory}/projects";
        dots = "${homeDirectory}/projects/nix-config";
      };

      dotDir = ".config/zsh";

      enableCompletion = true;
      enableVteIntegration = true;

      envExtra = mkIf pkgs.stdenv.isLinux ''
        setopt no_global_rcs
      '';

      history = {
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
        path = "${config.xdg.cacheHome}/zsh_history";
        save = 100000;
        share = true;
        size = 100000;
      };

      initExtraFirst = # bash
        ''
          # avoid duplicated entries in PATH
          typeset -U PATH

          setopt correct
          setopt noflowcontrol
          unsetopt nomatch

          ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(history-beginning-search-backward-end history-beginning-search-forward-end)

          # Do this early so fast-syntax-highlighting can wrap and override this
          if autoload history-search-end; then
            zle -N history-beginning-search-backward-end history-search-end
            zle -N history-beginning-search-forward-end  history-search-end
          fi

          source <(${lib.getExe config.programs.fzf.package} --zsh)
          source ${config.programs.git.package}/share/git/contrib/completion/git-prompt.sh

          function zshaddhistory() {
            LASTHIST=''${1//\\$'\n'/}
            return 2
          }

          function precmd() {
            if [[ $? == 0 && -n ''${LASTHIST//[[:space:]\n]/} && -n $HISTFILE ]] ; then
              print -sr -- ''${=''${LASTHIST%%'\n'}}
            fi
          }
        '';

      initExtra = # bash
        ''
          # NOTE: this slows down shell startup time considerably
          ${fileContents ./config/unset.zsh}
          ${fileContents ./config/set.zsh}

          ${fileContents ./config/modules.zsh}
          ${fileContents ./config/fzf-tab.zsh}
          ${fileContents ./config/misc.zsh}

          # Set LS_COLORS by parsing dircolors output
          LS_COLORS="$(${lib.getExe' pkgs.coreutils "dircolors"} --sh)"
          LS_COLORS="''${''${LS_COLORS#*\'}%\'*}"
          export LS_COLORS

          ${lib.optionalString config.programs.fastfetch.enable "fastfetch"}
        '';

      inherit (plugins) plugins;

      shellAliases = {
        q = "exit";
        trimall = "sudo fstrim -va";
        tmp = "cd /tmp/";

        # home-manager
        hms = "home-manager --flake . switch";

        ip = "ip --color";

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

        # youtube-dl
        # FIXME: move this to yt-dlp module
        ytmp3 = "yt-dlp --ignore-errors -x --audio-format mp3 -f bestaudio --audio-quality 0 --embed-metadata --embed-thumbnail --output '%(title)s.%(ext)s'";

        # systemctl
        us = "systemctl --user";
        rs = "sudo systemctl";
      };

      #syntaxHighlighting = {
      #  enable = true;
      #  highlighters = [
      #    "main"
      #    "brackets"
      #    "pattern"
      #    "cursor"
      #    "regexp"
      #    "root"
      #    "line"
      #  ];
      #};
    };
  };
}
