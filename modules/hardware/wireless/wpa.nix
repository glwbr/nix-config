{ config, lib, ... }:
let
  cfg = config.aria.hardware.wireless.wpa;
in
{
  options.aria.hardware.wireless.wpa.enable = lib.mkEnableOption "wpa_supplicant";

  config = lib.mkIf cfg.enable {
    sops.secrets.wireless.neededForUsers = true;

    networking.wireless = {
      enable = true;
      fallbackToWPA2 = false;

      secretsFile = config.sops.secrets.wireless.path;

      networks = {
        "Club4Work" = { pskRaw = "ext:c4w"; authProtocols = [ "WPA-PSK" ]; };
        "Evolution@Lemos_5G" = { pskRaw = "ext:lemos_5g"; };
        "UAIFAI" = { pskRaw = "ext:uaifai"; priority = 15; };
        "UAIFAI_5G" = { pskRaw = "ext:uaifai_5g"; priority = 20; authProtocols = [ "WPA-PSK" ]; };
        "UAIFAI_4G" = { pskRaw = "ext:uaifai_4g"; priority = 10; };
        "SALA DOS FUNDOS_5G" = { pskRaw = "ext:sala_c4w"; priority = 30; authProtocols = [ "WPA-PSK" ]; };
      };

      allowAuxiliaryImperativeNetworks = true;
      userControlled = { enable = true; group = "network"; };
      extraConfig = ''
        ctrl_interface=DIR=/run/wpa_supplicant GROUP=${config.users.groups.network.name}
        update_config=1
      '';
    };

    users.groups.network = { };
    systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
  };
}
