{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.hardware.bluetooth;
in {
  options.aria.hardware.bluetooth = {
    enable = mkBoolOpt false "Whether to enable bluetooth support";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;

      package = pkgs.bluez5-experimental;
      powerOnBoot = true;

      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
      };
    };
  };
}
