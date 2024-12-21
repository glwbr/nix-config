{
  config,
  lib,
  ...
}: let
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.services.firewall;
in {
  options.aria.services.firewall = {
    enable = mkBoolOpt false "Whether to enable firewall rules";
  };

  config = lib.mkIf cfg.enable {
    networking.nftables.enable = true;
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [
        80
        443
        8080
        8443
      ];
    };
  };
}
