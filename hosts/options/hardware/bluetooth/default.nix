{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.hardware.bluetooth;

  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.hardware.bluetooth = {
    enable = mkBoolOpt false "Whether or not to enable bluetooth support";
  };

  config = mkIf cfg.enable {
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

    # conditionally enable this
    # services.blueman.enable = true;
  };
}
