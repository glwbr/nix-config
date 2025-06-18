{ config, lib, pkgs, ... }:
let
  cfg = config.aria.hardware.logitech;
in
{
  options.aria.hardware.logitech = {
    enable = lib.mkEnableOption "support for Logitech devices";

    enableGraphical = lib.aria.mkBoolOpt false "Whether to enable graphical tools";
  };
  config = lib.mkIf cfg.enable {
    hardware.logitech.wireless = {
      enable = true;
      enableGraphical = cfg.enableGraphical;
    };
    environment.systemPackages = with pkgs; lib.optional cfg.enableGraphical solaar;
    services.udev.packages = with pkgs; [ logitech-udev-rules libratbag ] ++ lib.optional cfg.enableGraphical solaar;
  };
}
