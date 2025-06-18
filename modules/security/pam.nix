{ config, lib, ... }:
let
  cfg = config.aria.security.pam;
in
{
  options.aria.security.pam = {
    enable = lib.mkEnableOption "custom PAM configuration";

    limits = {
      nofile = lib.aria.mkOpt lib.types.int 65536 "Maximum number of open files";
      nproc = lib.aria.mkOpt lib.types.int 32768 "Maximum number of processes";
      memlock = lib.aria.mkOpt lib.types.str "unlimited" "Maximum locked memory";
    };
  };

  config = lib.mkIf cfg.enable {
    security.pam.loginLimits = [
      { domain = "*"; item = "nofile"; type = "-"; value = toString cfg.limits.nofile; }
      { domain = "*"; item = "nproc"; type = "-"; value = toString cfg.limits.nproc; }
      { domain = "*"; item = "memlock"; type = "-"; value = cfg.limits.memlock; }
    ];
  };
}
