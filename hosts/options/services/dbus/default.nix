{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.services.dbus;

  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.services.dbus = {
    enable = mkBoolOpt false "Whether or not to enable dbus.";
  };

  config = lib.mkIf cfg.enable {
    services.dbus = {
      enable = true;
      implementation = "broker";
      packages = [ pkgs.gcr ];
    };

    programs.dconf.enable = true;
  };
}
