{ config, lib, outputs, ... }:
let
  cfg = config.aria.services.openssh;
  hosts = lib.attrNames outputs.nixosConfigurations;
in
{
  options.aria.services.openssh = {
    enable = lib.mkEnableOption "OpenSSH server";

    ports = lib.aria.mkListOpt lib.types.port [ 2222 ] "Ports to listen on";
    listenAddresses = lib.aria.mkListOpt (lib.types.submodule {
      options = {
        addr = lib.aria.mkOpt lib.types.str "0.0.0.0" "Address to bind to";
        port = lib.aria.mkOpt (lib.types.nullOr lib.types.port) null "Port to bind to (null uses global ports)";
      };
    }) [ ] "Specific addresses and ports to listen on";
    gatewayPorts = lib.aria.mkOpt (lib.types.enum [ "no" "yes" "clientspecified" ]) "no" "Gateway ports setting";

    passwordAuth = lib.aria.mkBoolOpt false "Enable password authentication";
    permitRootLogin = lib.aria.mkBoolOpt false "Allow root login";
    sshAgentAuth = lib.aria.mkBoolOpt false "Enable SSH agent auth for passwordless sudo";

    x11Forwarding = lib.aria.mkBoolOpt true "Enable X11 forwarding";
    agentForwarding = lib.aria.mkBoolOpt true "Enable SSH agent forwarding";

    hostAliases = lib.aria.mkOpt (lib.types.attrsOf (lib.types.listOf lib.types.str)) { } "Additional aliases for hosts (hostName -> [aliases])";
    extraConfig = lib.aria.mkOpt lib.types.lines "" "Additional SSH configuration";
  };

  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      hostKeys = [ { path = "/etc/ssh/ssh_host_ed25519_key"; type = "ed25519"; } ];
      inherit (cfg) ports listenAddresses extraConfig;

      settings = {
        PasswordAuthentication = cfg.passwordAuth;
        PermitRootLogin = lib.mkIf cfg.permitRootLogin "yes";
        X11Forwarding = cfg.x11Forwarding;
        AllowAgentForwarding = cfg.agentForwarding;
        GatewayPorts = cfg.gatewayPorts;

        UseDns = false;
        StreamLocalBindUnlink = "yes";
      };
    };

    programs.ssh.knownHosts = lib.genAttrs hosts (hostName: {
      publicKeyFile = ../../hosts/${hostName}/ssh_host_ed25519_key.pub;
      extraHostNames = (cfg.hostAliases.${hostName} or [ ]) ++ (lib.optional (hostName == config.networking.hostName) "localhost");
    });

    security.pam.sshAgentAuth = lib.mkIf cfg.sshAgentAuth {
      enable = true;
      authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
    };
  };
}
