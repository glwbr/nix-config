{ config, lib, ... }:
let
  cfg = config.aria.programs.shell.zoxide;
in
{
  options.aria.programs.shell.zoxide.enable = lib.mkEnableOption "zoxide";

  config = lib.mkIf cfg.enable {
    programs.zoxide = {
      enable = true;
      flags = [ "--cmd cd" ];
      enableXonshIntegration = false;
      enableFishIntegration = false;
    };
  };
}
