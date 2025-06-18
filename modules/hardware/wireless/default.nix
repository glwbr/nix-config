{ config, lib, ... }:
let
  cfg = config.aria.hardware.wireless;
in
{
  imports = [ ./iwd.nix ./wpa.nix ];

  options.aria.hardware.wireless = {
    enable = lib.mkEnableOption "networking defaults";
  };

  config = lib.mkIf cfg.enable {
    aria.hardware = {
      wireless.iwd.enable = lib.mkDefault false;
      wireless.wpa.enable = lib.mkDefault false;
    };
  };
}
