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
        ${pkgs.xorg.xrandr}/bin/xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-1 --primary --mode 2560x1440 --pos 1920x0 --rotate normal
      '';

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };

      xkb = {
        model = "pc104";
        layout = "us,us";
        options = "compose:ralt, caps:swapescape, grp:alt_space_toggle";
        variant = ",intl";
      };

      xrandrHeads = [
        {
          output = "HDMI-1";
          primary = true;
        }
        { output = "eDP-1"; }
      ];
    };

    environment.pathsToLink = [ "/libexec" ];
    environment.systemPackages = [ pkgs.xclip ];
  };
}
