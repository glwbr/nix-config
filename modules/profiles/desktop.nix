{
  config,
  lib,
  ...
}: let
  inherit (lib.aria) disabled enabled mkBoolOpt;

  cfg = config.aria.profiles.desktop;
in {
  options.aria.profiles.desktop = {
    enable = mkBoolOpt false "Whether to enable minimal profile";
  };

  config = lib.mkIf cfg.enable {
    aria = {
      profiles.minimal = enabled;

      hardware = {
        audio = enabled;
        bluetooth = enabled;
      };

      system = {
        fonts = enabled;
      };

      security = {
        polkit = enabled;
      };

      services = {
        dbus = enabled;
      };
    };
  };
}
