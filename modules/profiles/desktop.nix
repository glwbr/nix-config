{
  config,
  lib,
  ...
}:
let
  inherit (lib.aria) enabled disabled mkBoolOpt;
  cfg = config.aria.profiles.desktop;
in
{
  options.aria.profiles.desktop = {
    enable = mkBoolOpt false "Whether to enable desktop profile";
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
        nix.nh = enabled;
      };

      terminal.tools = {
        alacritty = enabled;
      };

      security = {
        keyring = enabled;
        polkit = enabled;
      };

      services = {
        dbus = enabled;
        power = disabled;
      };
    };
  };
}
