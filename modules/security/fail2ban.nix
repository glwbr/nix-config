{ config, lib, ... }:
let
  cfg = config.aria.security.fail2ban;
in
{
  options.aria.security.fail2ban = {
    enable = lib.mkEnableOption "fail2ban intrusion prevention";

    banTime = lib.aria.mkOpt lib.types.str "1h" "Default ban time";
    maxRetry = lib.aria.mkOpt lib.types.int 3 "Maximum retries before ban";
    jails = lib.aria.mkOpt lib.types.attrs { } "Custom jail configurations";
    findTime = lib.aria.mkOpt lib.types.str "10m" "Time window for failed attempts";
    ignoreIP = lib.aria.mkListOpt lib.types.str [ "127.0.0.1/8" "::1" ] "IPs to never ban";
  };

  config = lib.mkIf cfg.enable {
    services.fail2ban = {
      enable = true;
      bantime = cfg.banTime;
      maxretry = cfg.maxRetry;
      ignoreIP = cfg.ignoreIP;

      jails = lib.mkMerge [
        (lib.mkIf config.services.openssh.enable {
          sshd.settings = {
            enabled = true;
            maxretry = cfg.maxRetry;
            bantime = cfg.banTime;
            findtime = cfg.findTime;
          };
        })

        cfg.jails
      ];
    };
  };
}
