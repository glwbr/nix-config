{
  config,
  lib,
  ...
}:
let
  cfg = config.aria.services.openssh;

  inherit (lib) mkEnableOption mkIf types;
  inherit (lib.aria) mkOpt;
in
{
  options.aria.services.openssh = with types; {
    enable = mkEnableOption "openssh";
    port = mkOpt port 2222 "The port to listen on.";
  };
  config = mkIf cfg.enable {
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
        GatewayPorts = "clientspecified";
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        StreamLocalBindUnlink = "yes";
        UseDns = true;
        X11Forwarding = true;
      };

    };

    # Passwordless sudo when SSH'ing with keys
    security.pam.sshAgentAuth = {
      enable = true;
      authorizedKeysFiles = [ "/etc/ssh/authorized_keys.d/%u" ];
    };
  };
}
