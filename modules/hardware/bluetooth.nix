{ config, lib, pkgs, ... }:
let
  cfg = config.aria.hardware.bluetooth;
in
{
  options.aria.hardware.bluetooth = {
    enable = lib.mkEnableOption "Bluetooth support";

    ldac = lib.aria.mkBoolOpt false "Enable LDAC codec support";
    aptx = lib.aria.mkBoolOpt false "Enable aptX codec support";
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
        } // lib.optionalAttrs cfg.ldac { ControllerMode = "dual"; };
      };
    };

    # Audio codec packages
    environment.systemPackages = with pkgs; lib.optionals cfg.ldac [ libldac ] ++ lib.optionals cfg.aptx [ libopenaptx ];
  };
}
