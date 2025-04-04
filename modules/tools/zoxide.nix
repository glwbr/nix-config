{ config, lib, ... }:
let
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.tools.zoxide;
in
{
  options.aria.shell.zoxide = {
    enable = mkBoolOpt false "Whether to enable zoxide";
  };

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      flags = [ "--cmd cd" ];
      enableXonshIntegration = false;
      enableFishIntegration = false;
    };
  };
}
