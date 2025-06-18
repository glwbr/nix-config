{ config, lib, ... }:
let
  cfg = config.aria.virtualisation.docker;
in
{
  options.aria.virtualisation.docker = {
    enable = lib.mkEnableOption "Docker containerization";

    users = lib.aria.mkListOpt lib.types.str [ ] "Users to add to docker group";
    rootless = lib.aria.mkBoolOpt false "Enable rootless Docker";
    storageDriver = lib.aria.mkOpt (lib.types.nullOr ( lib.types.enum [ "overlay2" "btrfs" "zfs" "devicemapper" ])) null "Docker storage driver";
    autoPrune = {
      enable = lib.aria.mkBoolOpt true "Enable automatic pruning";
      flags = lib.aria.mkListOpt lib.types.str [ "--all" ] "Flags for docker system prune";
      dates = lib.aria.mkOpt lib.types.str "weekly" "How often to prune (systemd timer format)";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;

      autoPrune = {
        enable = cfg.autoPrune.enable;
        inherit (cfg.autoPrune) flags dates;
      };

      rootless = lib.mkIf cfg.rootless {
        enable = true;
        setSocketVariable = true;
      };

      storageDriver = lib.mkIf (cfg.storageDriver != null) cfg.storageDriver;
    };

    users.users = lib.genAttrs cfg.users (user: {
      extraGroups = [ "docker" ] ++ lib.optionals cfg.rootless [ "docker-rootless" ];
    });
  };
}
