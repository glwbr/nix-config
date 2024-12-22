{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.aria.services.udiskie;
  inherit (lib.aria) mkBoolOpt;
in {
  options.aria.services.udiskie = {
    enable = mkBoolOpt false "Whether or not to enable udiskie.";
  };

  config = lib.mkIf cfg.enable {
    services.udiskie = {
      enable = true;
    };
  };
}
