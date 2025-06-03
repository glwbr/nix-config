{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.aria.wms.i3;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.wms.i3 = {
    enable = mkBoolOpt false "Whether to enable i3";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.defaultSession = "none+i3";

    services.xserver = {
      enable = true;
      desktopManager.xterm.enable = false;

      displayManager.sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 170 50
        ${pkgs.autorandr}/bin/autorandr --change --default mobile
      '';

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
    };

    # Environment Configuration
    environment = {
      pathsToLink = [ "/libexec" ];

      systemPackages = with pkgs; [
        dunst
        xclip
      ];
    };

    # Autorandr Configuration
    services.autorandr = {
      enable = true;
      defaultTarget = "mobile";

      profiles = {
        mobile = {
          fingerprint = {
            eDP-1 = "00ffffffffffff0030e43c0500000000001a0104951f1178029115945c5592291d5054000000010101010101010101010101010101012e3680a070381f403020350035ae100000195c2b80a070381f403020350035ae10000019000000fe004b54343346803134305746370a000000000000413096011000000a010a202000d7";
          };
          config = {
            eDP-1 = {
              enable = true;
              mode = "1920x1080";
              position = "0x0";
              rotate = "normal";
            };
          };
        };

        docked = {
          fingerprint = {
            eDP-1 = "00ffffffffffff0030e43c0500000000001a0104951f1178029115945c5592291d5054000000010101010101010101010101010101012e3680a070381f403020350035ae100000195c2b80a070381f403020350035ae10000019000000fe004b54343346803134305746370a000000000000413096011000000a010a202000d7";
            HDMI-1 = "00ffffffffffff0010acda414c3550432e200103803c2278ea8cb5af4f43ab260e5054a54b00d100d1c0b300a94081808100714fe1c0565e00a0a0a029503020350055502100001a000000ff00384444595a4e330a2020202020000000fc0044454c4c205332373231444746000000fd0030901ee63c000a20202020202001af020338f1525a3f101f2005140413121103020106071516230907078301000067030c001000383c67d85dc401788001681a000001013090e640e7006aa0a067500820980455502100001a6fc200a0a0a055503020350055502100001a000000000000000000000000000000000000000000000000000000000000000000000084";
          };
          config = {
            eDP-1 = {
              enable = true;
              mode = "1920x1080";
              position = "0x0";
              rotate = "normal";
            };
            HDMI-1 = {
              enable = true;
              primary = true;
              mode = "2560x1440";
              position = "1920x0";
              rotate = "normal";
            };
          };
        };
      };
    };
  };
}
