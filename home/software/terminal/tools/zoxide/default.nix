{
  config,
  lib,
  ...
}: let
  cfg = config.aria.programs.terminal.tools.zoxide;
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
in {
  options.aria.programs.terminal.tools.zoxide = {
    enable = mkBoolOpt false "Whether or not to enable zoxide.";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;

      enableBashIntegration = true;
      enableZshIntegration = true;
      options = ["--cmd cd"];
    };
  };
}
