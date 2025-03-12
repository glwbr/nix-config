{
  config,
  lib,
  ...
}: let
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.hardware.wireless.wpa;
in {
  options.aria.hardware.wireless.wpa = {
    enable = mkBoolOpt false "Whether to enable wpa_supplicant";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.wireless = {
      sopsFile = ../../secrets.yaml;
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
          priority = 99;
        };

        "SALA DOS FUNDOS_5G" = {
          pskRaw = "ext:sala_c4w";
          priority = 98;
        };

        "Club4Work" = {
          pskRaw = "ext:c4w";
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
    aria.users.glwbr.extraGroups = ["network"];
    systemd.services.wpa_supplicant.preStart = "touch /etc/wpa_supplicant.conf";
    users.groups.network = {};
  };
}
