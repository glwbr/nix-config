{ config, lib, ... }:
let
  cfg = config.aria.virtualisation.containers;
in
{
  options.aria.virtualisation.containers = {
    enable = lib.mkEnableOption "container support";

    preset = lib.mkOption {
      type = lib.types.enum [ "development" "production" "minimal" ];
      default = "development";
      description = "Container configuration preset";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.enableContainers = true;
    virtualisation.containers = lib.mkMerge [
      { enable = true; }

      (lib.mkIf (cfg.preset == "development") {
        registries.search = [ "docker.io" "quay.io" "ghcr.io" "registry.fedoraproject.org" ];
        storage.settings.storage = {
          driver = "overlay";
          graphroot = "/var/lib/containers/storage";
        };
      })

      (lib.mkIf (cfg.preset == "production") {
        registries.search = [ "docker.io" "quay.io" ];
        registries.insecure = [ ];
        storage.settings.storage.driver = "overlay";
      })

      (lib.mkIf (cfg.preset == "minimal") {
        registries.search = [ "docker.io" ];
      })
    ];
  };
}
