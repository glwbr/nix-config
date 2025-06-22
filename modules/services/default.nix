{ config, lib, ... }:
let
  cfg = config.aria.services;
in
{
  imports = [ ./dbus.nix ./power.nix ./openssh.nix ./tailscale.nix ];

  options.aria.services = {
    enable = lib.mkEnableOption "Aria services";

    enableInteractive = lib.aria.mkBoolOpt false "Enable interactive services (dbus, GUI-related services)";
  };

  config = lib.mkIf cfg.enable {
    aria.services = {
      power.enable = lib.mkDefault true;
      openssh.enable = lib.mkDefault true;

      tailscale.enable = lib.mkDefault false;

      dbus = {
        enable = lib.mkDefault true;
        enableDconf = lib.mkDefault cfg.enableInteractive;
      };
    };
  };
}
