{
  lib,
  pkgs,
  ...
}:
{
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

  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v32n.psf.gz";
    useXkbConfig = true;
  };

  services.xserver.xkb = {
    layout = "us,us";
    variant = ",intl";
    options = "caps:swapescape,grp:alt_space_toggle";
  };
}
