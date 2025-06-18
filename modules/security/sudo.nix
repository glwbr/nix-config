{ config, lib, ... }:
let
  cfg = config.aria.security.sudo;
in
{
  options.aria.security.sudo = {
    enable = lib.mkEnableOption "sudo configuration";

    wheelNeedsPassword = lib.aria.mkBoolOpt true "Whether wheel group needs password for sudo";
    execWheelOnly = lib.aria.mkBoolOpt true "Whether to allow only wheel group to execute sudo";
    passwordPromptTimeout = lib.aria.mkOpt lib.types.int 0 "Password prompt timeout in minutes (0 = default)";
    timeout = lib.aria.mkOpt lib.types.int 15 "Sudo timeout in minutes (0 = no timeout)";
    logFailures = lib.aria.mkBoolOpt false "Whether to log sudo failures";
    extraRules = lib.aria.mkListOpt lib.types.str [ ] "Extra sudo rules";
    userRules = lib.aria.mkOpt (lib.types.attrsOf (lib.types.listOf lib.types.str)) { } "Per-user sudo rules";
    groupRules = lib.aria.mkOpt (lib.types.attrsOf (lib.types.listOf lib.types.str)) { } "Per-group sudo rules";
    noPasswordCommands = lib.aria.mkListOpt lib.types.str [ ] "Commands that can be run without password for wheel group";
  };

  config = lib.mkIf cfg.enable {
    security.sudo = {
      enable = true;
      wheelNeedsPassword = cfg.wheelNeedsPassword;
      execWheelOnly = cfg.execWheelOnly;

      extraConfig = lib.concatLines (
        [ "Defaults logfile=/var/log/sudo.log" ]

        ++ lib.optional (cfg.timeout > 0) "Defaults timestamp_timeout=${toString cfg.timeout}"
        ++ lib.optional (cfg.timeout == 0) "Defaults timestamp_timeout=-1"
        ++ lib.optional (cfg.passwordPromptTimeout > 0) "Defaults passwd_timeout=${toString cfg.passwordPromptTimeout}"

        ++ lib.optional cfg.logFailures "Defaults log_input,log_output"

        ++ lib.optional (cfg.noPasswordCommands != [ ]) "%wheel ALL=(ALL:ALL) NOPASSWD: ${lib.concatStringsSep ", " cfg.noPasswordCommands}"

        ++ cfg.extraRules

        # User-specific rules
        ++ lib.concatLists (lib.mapAttrsToList (user: rules: map (rule: "${user} ${rule}") rules) cfg.userRules)
        # Group-specific rules
        ++ lib.concatLists (lib.mapAttrsToList (group: rules: map (rule: "%${group} ${rule}") rules) cfg.groupRules)
      );
    };

    systemd.tmpfiles.rules = lib.mkIf cfg.logFailures [
      "d /var/log 0755 root root -"
      "f /var/log/sudo.log 0600 root root -"
    ];

    services.logrotate.settings.sudo = lib.mkIf cfg.logFailures {
      files = [ "/var/log/sudo.log" ];
      frequency = "monthly";
      rotate = 12;
      compress = true;
      delaycompress = true;
      missingok = true;
      notifempty = true;
      create = "0600 root root";
    };
  };
}
