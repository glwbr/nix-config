{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.security.polkit;

  inherit (lib) mkDefault mkIf;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.security.polkit = {
    enable = mkBoolOpt false "Whether or not to enable polkit.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ libsForQt5.polkit-kde-agent ];

    security.polkit = {
      enable = true;
      debug = mkDefault true;

      extraConfig = mkIf config.security.polkit.debug ''
        /* Log authorization checks. */
        polkit.addRule(function(action, subject) {
          polkit.log("user " +  subject.user + " is attempting action " + action.id + " from PID " + subject.pid);
        });
      '';
    };

    systemd.user.services.polkit-kde-authentication-agent-1 = {
      after = [ "graphical-session.target" ];
      description = "polkit-kde-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
