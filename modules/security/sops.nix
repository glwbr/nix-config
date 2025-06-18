{ config, lib, inputs, ... }:
let
  cfg = config.aria.security.sops;
  ariaUsers = config.aria.core.users.users;
in
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  options.aria.security.sops = {
    enable = lib.mkEnableOption "SOPS secrets management";

    autoUserPasswords = lib.aria.mkBoolOpt true "Auto-configure user passwords from SOPS";
    serviceSecrets = lib.aria.mkOpt (lib.types.attrsOf lib.types.str) {} "Service secrets mapping (service -> secret key)";
  };

  config = lib.mkIf cfg.enable {
    sops = {
      defaultSopsFile = ../../secrets/common.yaml;
      age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      secrets = lib.mkMerge [
        # INFO: auto-generate user password secrets for Aria" users
        (lib.mkIf cfg.autoUserPasswords (
          lib.genAttrs
            (map (username: "${username}-password") (builtins.attrNames ariaUsers))
            (secretName: { neededForUsers = true; })
        ))

        # INFO: auto-generate service secrets
        (lib.mapAttrs (service: secretKey: {
          owner = service;
          group = service;
          mode = "0400";
        }) cfg.serviceSecrets)
      ];
    };
  };
}
