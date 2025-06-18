{ config, lib, ... }:
let
  cfg = config.aria.security;
in
{
  imports = [ ./pam.nix ./sops.nix ./sudo.nix ./gnupg.nix ./polkit.nix ./keyring.nix ./fail2ban.nix ];

  options.aria.security.enable = lib.mkEnableOption "security defaults";

  config = lib.mkIf cfg.enable {
    aria.security = {
      pam.enable = lib.mkDefault true;
      sops.enable = lib.mkDefault true;
      sudo.enable = lib.mkDefault true;

      polkit.enable = lib.mkDefault false;
      keyring.enable = lib.mkDefault false;
      fail2ban.enable = lib.mkDefault false;
    };
  };
}
