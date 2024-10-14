{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption mkForce mkIf;

  cfg = config.aria.system.locale;
in
{
  options.aria.system.locale = {
    enable = mkEnableOption "locale";
  };

  config = mkIf cfg.enable {
    i18n = {
      defaultLocale = lib.mkDefault "en_US.UTF-8";

      extraLocaleSettings = {
        LC_TIME = lib.mkDefault "pt_BR.UTF-8";
      };

      supportedLocales = lib.mkDefault [
        "en_US.UTF-8/UTF-8"
        "pt_BR.UTF-8/UTF-8"
      ];
    };

    location.provider = "geoclue2";

    time.timeZone = lib.mkDefault "America/Bahia";
    time.hardwareClockInLocalTime = lib.mkDefault true;

    console.keyMap = mkForce "us";

    #services.xserver.xkb = {
    #  layout = "us,us";
    #  variant = ",intl";
    #  options = "caps:swapescape,grp:alt_space_toggle";
    #};
  };
}
