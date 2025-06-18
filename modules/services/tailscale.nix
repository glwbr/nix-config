{ config, lib, ... }:
let
  cfg = config.aria.services.tailscale;
in
{
  options.aria.services.tailscale = {
    enable = lib.mkEnableOption "Tailscale";
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      openFirewall = true;
    };
  };
}
