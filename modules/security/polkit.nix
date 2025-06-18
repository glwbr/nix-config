{ config, lib, pkgs, ... }:
let
  cfg = config.aria.security.polkit;
  agentPath = {
    lxqt = "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent";
    gnome = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    kde = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
  };
  execPath = if builtins.hasAttr cfg.agent agentPath then agentPath.${cfg.agent} else throw "Unknown polkit agent: ${cfg.agent}";
in
{
  options.aria.security.polkit = {
    enable = lib.mkEnableOption "polkit authorization";

    agent = lib.aria.mkOpt (lib.types.enum [ "gnome" "kde" "lxqt" ]) "gnome" "Which polkit authentication agent to use";
    extraRules = lib.aria.mkOpt lib.types.lines "" "Extra polkit rules";
  };

  config = lib.mkIf cfg.enable {
    security.polkit.enable = true;

    systemd.user.services.polkit-authentication-agent = {
      after = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      wantedBy = [ "graphical-session.target" ];
      description = "Polkit authentication agent";
      serviceConfig = {
        Type = "simple";
        ExecStart = execPath;
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

    security.polkit.extraConfig = lib.mkIf (cfg.extraRules != "") cfg.extraRules;
  };
}
