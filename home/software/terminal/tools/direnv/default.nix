{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt enabled;

  cfg = config.aria.programs.terminal.tools.direnv;
in
{
  options.aria.programs.terminal.tools.direnv = {
    enable = mkBoolOpt false "Whether or not to enable direnv.";
  };

  config = mkIf cfg.enable {
    home.sessionVariables.DIRENV_LOG_FORMAT = "";

    programs.direnv = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      nix-direnv = enabled;
    };
  };
}
