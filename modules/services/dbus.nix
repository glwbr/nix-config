{ config, lib, pkgs, ... }:
let
  cfg = config.aria.services.dbus;
in
{
  options.aria.services.dbus = {
    enable = lib.mkEnableOption "dbus";

    implementation = lib.aria.mkOpt (lib.types.enum [ "broker" "dbus" ]) "broker" "DBus implementation to use.";
    packages = lib.aria.mkListOpt lib.types.package [ pkgs.gcr ] "Additional packages to add to the dbus environment";
    enableDconf = lib.aria.mkBoolOpt true "Whether to enable dconf alongside dbus";
  };

  config = lib.mkIf cfg.enable {
    services.dbus = {
      enable = true;
      implementation = "broker";
      packages = cfg.packages;
    };

    programs.dconf.enable = lib.mkDefault cfg.enableDconf;
  };
}
