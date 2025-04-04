{ config, lib, ... }:
let
  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.terminal.tools.zoxide;
in
{
  options.aria.terminal.tools.zoxide = {
    enable = mkBoolOpt false "Whether to enable zoxide";
  };

  config = mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      flags = [ "--cmd cd" ];
      enableXonshIntegration = false;
      enableFishIntegration = false;
    };
  };
}
