{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt enabled;
  cfg = config.aria.terminal.tools.direnv;
in
{
  options.aria.terminal.tools.direnv = {
    enable = mkBoolOpt false "Whether to enable direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      nix-direnv = enabled;
      silent = true;
    };
  };
}
