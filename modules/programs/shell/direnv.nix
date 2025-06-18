{ config, lib, ... }:
let
  cfg = config.aria.programs.shell.direnv;
in
{
  options.aria.programs.shell.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf cfg.enable {
    environment.sessionVariables.DIRENV_WARN_TIMEOUT = "1m";

    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
