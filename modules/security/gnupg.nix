{ config, lib, pkgs, ... }:
let
  cfg = config.aria.security.gnupg;
in
{
  options.aria.security.gnupg = {
    enable = lib.mkEnableOption "GnuPG";

    enableSSHSupport = lib.aria.mkBoolOpt true "Whether to enable SSH support";
    maxCacheTtl = lib.aria.mkOpt lib.types.int 86400 "Maximum cache TTL in seconds";
    defaultCacheTtl = lib.aria.mkOpt lib.types.int 3600 "Default cache TTL in seconds";
    pinentryPackage = lib.aria.mkOpt lib.types.package pkgs.pinentry-curses "Pinentry package to use";
  };

  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = cfg.enableSSHSupport;
      pinentryPackage = cfg.pinentryPackage;
      settings = {
        default-cache-ttl = cfg.defaultCacheTtl;
        max-cache-ttl = cfg.maxCacheTtl;
      };
    };
  };
}
