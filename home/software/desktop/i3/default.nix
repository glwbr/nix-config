{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.aria.programs.wms.i3;
  inherit (lib.aria) mkBoolOpt;
in {
  options.aria.programs.wms.i3 = {
    enable = mkBoolOpt false "Whether to manager i3 settings";
  };

  config = lib.mkIf cfg.enable {
    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = null;
      extraConfig = builtins.readFile ./config;
    };
  };
}
