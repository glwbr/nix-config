{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.security.polkit;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.security.polkit = {
    enable = mkBoolOpt false "Whether or not to enable polkit.";
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      after = [ "graphical-session.target" ];
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
