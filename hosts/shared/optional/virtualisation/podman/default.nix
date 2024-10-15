{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.virtualisation;
  #display = config.aria.display.enable;

  inherit (cfg) docker podman;
  inherit (lib) mkIf optionals;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.virtualisation.podman = {
    enable = mkBoolOpt false "Whether or not to enable podman.";
  };

  config = mkIf (podman.enable && !docker.enable) {
    boot.enableContainers = true;
    environment.systemPackages = with pkgs; [
      podman-compose
    ];
    # ++ optionals display [ podman-desktop ];

    aria = {
      user.extraGroups = [
        "docker"
        "podman"
      ];

      # home.extraOptions = {
      #   home.shellAliases = {
      #     "docker-compose" = "podman-compose";
      #   };
      # };
    };

    virtualisation = {
      podman = {
        enable = true;

        # prune images and containers periodically
        autoPrune = {
          enable = true;
          flags = [ "--all" ];
          dates = "weekly";
        };

        defaultNetwork.settings.dns_enabled = true;
        dockerCompat = true;
        dockerSocket.enable = true;
      };
    };
  };
}
