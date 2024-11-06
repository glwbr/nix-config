{ config, lib, ... }:
let
  cfg = config.aria.services.firewall;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.services.firewall = {
    enable = mkBoolOpt false "Whether or not to enable firewall rules.";
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
