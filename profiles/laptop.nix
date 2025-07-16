{ ... }:
{
  documentation.enable = true;
  documentation.man.enable = true;

  i18n = {
    supportedLocales = [ "en_US.UTF-8/UTF-8" "pt_BR.UTF-8/UTF-8" ];
    extraLocaleSettings = { LC_TIME = "pt_BR.UTF-8"; LC_CTYPE = "pt_BR.UTF-8"; };
  };

  hardware.i2c.enable = true;
  location.provider = "geoclue2";

  aria = {
    core.nix.nh.enable = true;
    core.fonts = { enable = true; includeDesignerFonts = true; enableEnhancedRendering = true; };

    hardware.audio.enable = true;
    hardware.input.enable = true;
    hardware.bluetooth.enable = true;
    hardware.wireless.wpa.enable = true;

    programs.shell = { direnv.enable = true; includeExtras = true; };

    security.polkit.enable = true;
    security.keyring.enable = true;

    services = { enableInteractive = true; power = { profile = "laptop"; }; };
  };
}
