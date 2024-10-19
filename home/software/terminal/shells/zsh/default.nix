{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.programs.terminal.shell.zsh;
  plugins = import ./plugins pkgs;

  inherit (config.home) homeDirectory;
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.programs.terminal.shell.zsh = {
    enable = mkBoolOpt true "Whether or not to enable zshell.";
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;

      autocd = true;
      autosuggestion.enable = true;

      dirHashes = {
        dl = "${homeDirectory}/Downloads";
        dev = "${homeDirectory}/projects";
        dots = "${homeDirectory}/projects/nix-config";
      };

      dotDir = ".config/zsh";

      history = {
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
        path = "${config.xdg.dataHome}/zsh_history";
      };

      initExtra = ''
        # search history based on what's typed in the prompt
        autoload -U history-search-end
        zle -N history-beginning-search-backward-end history-search-end
        zle -N history-beginning-search-forward-end history-search-end
        bindkey "^[OA" history-beginning-search-backward-end
        bindkey "^[OB" history-beginning-search-forward-end

        # General completion behavior
        zstyle ':completion:*' completer _extensions _complete _approximate

        # Use cache
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

        # Complete the alias
        zstyle ':completion:*' complete true

        # Autocomplete options
        zstyle ':completion:*' complete-options true

        # Completion matching control
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
        zstyle ':completion:*' keep-prefix true

        # Group matches and describe
        zstyle ':completion:*' menu select
        zstyle ':completion:*' list-grouped false
        zstyle ':completion:*' list-separator '''
        zstyle ':completion:*' group-name '''
        zstyle ':completion:*' verbose yes
        zstyle ':completion:*:matches' group 'yes'
        zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
        zstyle ':completion:*:messages' format '%d'
        zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
        zstyle ':completion:*:descriptions' format '[%d]'

        # Colors
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

        # case insensitive tab completion
        zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
        zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
        zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
        zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands
        zstyle ':completion:*' special-dirs true
        zstyle ':completion:*' squeeze-slashes true

        # Sort
        zstyle ':completion:*' sort false
        zstyle ":completion:*:git-checkout:*" sort false
        zstyle ':completion:*' file-sort modification
        zstyle ':completion:*:eza' sort false
        zstyle ':completion:complete:*:options' sort false
        zstyle ':completion:files' sort false

        ${lib.optionalString config.services.gpg-agent.enable ''
          gnupg_path=$(ls $XDG_RUNTIME_DIR/gnupg)
          export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/$gnupg_path/S.gpg-agent.ssh"
        ''}
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
    };
  };
}
