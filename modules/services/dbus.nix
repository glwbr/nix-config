{ config, lib, pkgs, ... }:
let
  cfg = config.aria.services.dbus;
in
{
  options.aria.services.dbus = {
    enable = lib.mkEnableOption "dbus";

    enableDconf = lib.aria.mkBoolOpt false "Whether to enable dconf alongside dbus";
  };

  config = lib.mkIf cfg.enable {
    services.dbus = {
      enable = true;
      implementation = "broker";
      packages = lib.optional cfg.enableDconf pkgs.gcr_4;
    };

    programs.dconf.enable = lib.mkDefault cfg.enableDconf;
  };
}
