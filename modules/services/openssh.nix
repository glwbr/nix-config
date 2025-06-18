{ config, lib, outputs, ... }:
let
  cfg = config.aria.services.openssh;
  hosts = lib.attrNames outputs.nixosConfigurations;
in
{
  options.aria.services.openssh = {
    enable = lib.mkEnableOption "OpenSSH server with Aria defaults";

    sshAgentAuth = lib.aria.mkBoolOpt false "Enable SSH agent auth for passwordless sudo";
    hostAliases = lib.aria.mkOpt (lib.types.attrsOf (lib.types.listOf lib.types.str)) {} "Additional aliases for hosts (hostName -> [aliases])";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [ 2222 ];

      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        UseDns = false;
        StreamLocalBindUnlink = "yes";
        X11Forwarding = true;
        AllowAgentForwarding = true;
      };

      hostKeys = [ { path = "/etc/ssh/ssh_host_ed25519_key"; type = "ed25519"; } ];
    };

    networking.firewall.allowedUDPPorts = config.services.openssh.ports;

    #INFO: Auto-generate known hosts from flake
    programs.ssh.knownHosts = lib.genAttrs hosts (hostName: {
      publicKeyFile = ../../hosts/${hostName}/ssh_host_ed25519_key.pub;
      extraHostNames = [ "${hostName}.phy0.me" ] ++ (lib.optional (hostName == config.networking.hostName) "localhost") ++ (cfg.hostAliases.${hostName} or []);
    });

    security.pam.sshAgentAuth = lib.mkIf cfg.sshAgentAuth {
      enable = true;
      authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
    };
  };
}
