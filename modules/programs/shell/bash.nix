{ config, lib, ... }:
let
  cfg = config.aria.programs.shell.bash;
in
{
  options.aria.programs.shell.bash = {
    enable = lib.mkEnableOption "opinionated bash configuration";

    histFile = lib.aria.mkOpt lib.types.str "$HOME/.cache/bash_history" "Location of bash history file";
  };

  config = lib.mkIf cfg.enable {
    programs.bash = {
      completion.enable = true;
      shellInit = ''
        set -o vi
        export HISTFILE="${cfg.histFile}"
        export HISTSIZE=10000
        export HISTFILESIZE=20000
      '';
    };
  };
}
