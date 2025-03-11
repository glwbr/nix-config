{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.hardware.logitech;
in
{
  options.aria.hardware.logitech = {
    enable = mkBoolOpt false "Whether to enable support for logitech devices";
  };

  config = lib.mkIf cfg.enable {
    hardware = {
      logitech.wireless.enable = true;
      # INFO: Solaar
      logitech.wireless.enableGraphical = true;
    };

    environment.systemPackages = with pkgs; [ solaar ];
    services.udev.packages = with pkgs; [
      logitech-udev-rules
      solaar
    ];
  };
}
