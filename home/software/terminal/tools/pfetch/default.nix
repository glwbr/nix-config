{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.programs.terminal.tools.pfetch;
in {
  options.aria.programs.terminal.tools.pfetch = {
    enable = mkBoolOpt false "Whether or not to enable pfetch.";
  };

  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [pfetch-rs];
      sessionVariables.PF_INFO = "ascii title os kernel uptime shell de palette";
    };
  };
}
