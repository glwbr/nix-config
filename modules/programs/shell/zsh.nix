{ config, lib, ... }:
let
  cfg = config.aria.programs.shell.zsh;
in
{
  options.aria.programs.shell.zsh.enable = lib.mkEnableOption "opinionated zsh configuration";

  config = lib.mkIf cfg.enable {
    environment.pathsToLink = [ "/share/zsh" ];

    programs.zsh = {
      enable = true;
      histFile = "$HOME/.cache/.zsh_history";
      autosuggestions.enable = true;
      enableCompletion = true;
      histSize = 10000;
      setOptions = [ "EXTENDED_HISTORY" "HIST_IGNORE_DUPS" "SHARE_HISTORY" "HIST_VERIFY" "INC_APPEND_HISTORY" ];
      syntaxHighlighting.enable = true;
      interactiveShellInit = ''
        # Vi mode
        bindkey -v
        bindkey '^R' history-incremental-search-backward
        bindkey '^S' history-incremental-search-forward
        bindkey '^A' beginning-of-line
        bindkey '^E' end-of-line

        # Better completion
        zstyle ':completion:*' menu select
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      '';
    };
  };
}
