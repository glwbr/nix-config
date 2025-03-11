{
  config,
  lib,
  ...
}:
let
  inherit (lib) types;
  inherit (lib.aria) mkBoolOpt mkOpt;
  cfg = config.aria.services.openssh;
in
{
  options.aria.services.openssh = with types; {
    enable = mkBoolOpt false "Whether to enable openssh";
    port = mkOpt port 2222 "The port to listen on";
  };
  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;

      hostKeys = [
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];

      ports = [ cfg.port ];

      settings = {
        AcceptEnv = "WAYLAND_DISPLAY";
        AllowAgentForwarding = true;
        GatewayPorts = "clientspecified";
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        StreamLocalBindUnlink = "yes";
        UseDns = true;
        X11Forwarding = true;
      };
    };

    # INFO: Passwordless sudo when SSH'ing with keys
    security.pam.sshAgentAuth = {
      enable = true;
      authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
    };
  };
}
