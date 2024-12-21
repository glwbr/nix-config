{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (cfg) docker podman;
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.virtualisation;
in {
  options.aria.virtualisation.podman = {
    enable = mkBoolOpt false "Whether to enable podman";
  };

  config = lib.mkIf (podman.enable && !docker.enable) {
    boot.enableContainers = true;
    environment.systemPackages = with pkgs; [podman-compose];
    # ++ lib.optionals display [ podman-desktop ];

    aria.users.extraGroups = ["podman"];

    virtualisation = {
      podman = {
        enable = true;

        # INFO: prune images and containers periodically
        autoPrune = {
          enable = true;
          flags = ["--all"];
          dates = "weekly";
        };

        defaultNetwork.settings.dns_enabled = true;
        dockerCompat = true;
        dockerSocket.enable = true;
      };
    };
  };
}
