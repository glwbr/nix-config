{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.services.dbus;
in
{
  options.aria.services.dbus = {
    enable = mkBoolOpt false "Whether to enable dbus";
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
