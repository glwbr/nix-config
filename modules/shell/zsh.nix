{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types;
  inherit (lib.aria) mkBoolOpt mkOpt;

  cfg = config.aria.shell.zsh;
in {
  options.aria.shell.zsh = with types; {
    enable = mkBoolOpt false "Whether to enable ZSH configuration";

    historySize = mkOpt int 10000 "Size of history to keep";
    historyFile = mkOpt str "$HOME/.cache/zsh_history" "Location of history file";

    extraOptions = mkOpt (types.listOf types.str) [
      "EXTENDED_HISTORY"
      "HIST_IGNORE_DUPS"
      "SHARE_HISTORY"
    ] "Additional ZSH options";
  };

  config = lib.mkIf cfg.enable {
    environment.pathsToLink = ["/share/zsh"];

    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      enableCompletion = true;
      histFile = cfg.historyFile;
      histSize = cfg.historySize;
      setOptions = cfg.extraOptions;
      syntaxHighlighting.enable = true;
    };
  };
}
