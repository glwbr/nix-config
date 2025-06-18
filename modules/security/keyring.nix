{ config, lib, ... }:
let
  cfg = config.aria.security.keyring;
in
{
  options.aria.security.keyring = {
    enable = lib.mkEnableOption "GNOME keyring";
  };

  config = lib.mkIf cfg.enable {
    aria.security.polkit.enable = true;
    services.gnome.gnome-keyring.enable = true;
    security.pam.services.login.enableGnomeKeyring = true;
    security.pam.services.greetd.enableGnomeKeyring = true;
  };
}
