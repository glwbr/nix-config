{ config, lib, pkgs, ... }:
let
  cfg = config.aria.hardware.input;
in
{
  options.aria.hardware.input = {
    enable = lib.mkEnableOption "input device configuration";

    layout = lib.aria.mkOpt lib.types.str "us,us" "Keyboard layouts to use. First layout is default";
    variant = lib.aria.mkOpt lib.types.str ",intl" "Keyboard variants for the layouts. Comma-separated list";
    options = lib.aria.mkOpt lib.types.str "compose:ralt, grp:alt_space_toggle" "XKB options for keyboard behavior";
  };

  config = lib.mkIf cfg.enable {
    services.interception-tools = {
      enable = true;
      plugins = [ pkgs.interception-tools-plugins.caps2esc ];
      udevmonConfig = ''
        - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
          DEVICE:
            EVENTS:
              EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
      '';
    };

    console = lib.mkForce {
      useXkbConfig = true;
      keyMap = "us";
    };

    services.xserver.xkb = {
      model = "pc104";
      variant = cfg.variant;
      options = cfg.options;
      layout = cfg.layout;
    };
  };
}
