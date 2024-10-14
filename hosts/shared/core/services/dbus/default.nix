{
  config,
  lib,
  pkgs,
  ...
}:
with lib;

let
  cfg = config.aria.services.dbus;
in
{
  options.aria.services.dbus = {
    enable = mkEnableOption "dbus";
  };

  config = mkIf cfg.enable {
    services.dbus = {
      enable = true;
      packages = with pkgs; [
        dconf
        gcr
        udisks2
      ];
      implementation = "broker";
    };
  };
}
