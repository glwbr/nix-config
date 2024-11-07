{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.hardware.logitech;

  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.hardware.logitech = {
    enable = mkBoolOpt false "Whether or not to enable support for logitech mouses.";
  };

  config = mkIf cfg.enable {
    hardware = {
      logitech.wireless.enable = true;
      logitech.wireless.enableGraphical = true; # Solaar.
    };

    environment.systemPackages = with pkgs; [ solaar ];
    services.udev.packages = with pkgs; [
      logitech-udev-rules
      solaar
    ];
  };
}
