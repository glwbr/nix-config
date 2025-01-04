{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.aria.wms.i3;
  inherit (lib.aria) mkBoolOpt;
in {
  options.aria.wms.i3 = {
    enable = mkBoolOpt false "Whether to enable i3";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.defaultSession = "none+i3";
    services.xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };
  };
}
