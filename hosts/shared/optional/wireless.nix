{ config, ... }:
{
  sops.secrets.wireless = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
  };

  networking.wireless = {
    enable = true;
    fallbackToWPA2 = false;

    secretsFile = config.sops.secrets.wireless.path;

    networks = {
      "UAIFAI" = {
        pskRaw = "ext:uaifai_24g";
      };

      "UAIFAI_4G" = {
        pskRaw = "ext:uaifai_mobile";
      };

      "UAIFAI_5G" = {
        pskRaw = "ext:uaifai_5g";
        priority = 2;
      };
    };

    # Imperative
    allowAuxiliaryImperativeNetworks = true;
    userControlled = {
      enable = true;
      group = "network";
    };

    extraConfig = ''
      update_config=1
    '';
  };

  # Ensure group exists
  users.groups.network = { };
  systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
}
