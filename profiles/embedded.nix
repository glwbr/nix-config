{ lib, ... }:
{
  aria = {
    hardware.wireless.iwd.enable = true;

    services.power = { profile = "embedded"; enableThermald = false; };
  };

  i18n = {
    supportedLocales = [ "en_US.UTF-8/UTF-8" "pt_BR.UTF-8/UTF-8" ];
    extraLocaleSettings = { LC_TIME = "pt_BR.UTF-8"; LC_CTYPE = "pt_BR.UTF-8"; };
  };

  services.journald.extraConfig = ''
    SystemMaxUse=100M
    SystemMaxFiles=10
    MaxRetentionSec=1week
  '';

  fonts.fontconfig.enable = lib.mkDefault false;
}
