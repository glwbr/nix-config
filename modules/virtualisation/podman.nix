{ config, lib, pkgs, ... }:
let
  cfg = config.aria.virtualisation.podman;
  isDockerEnabled = config.aria.virtualisation.docker.enable;
in
{
  options.aria.virtualisation.podman = {
    enable = lib.mkEnableOption "Podman containerization";

    users = lib.aria.mkListOpt lib.types.str [ ] "Users to add to docker group";
    autoPrune = {
      enable = lib.aria.mkBoolOpt true "Enable automatic container pruning";
      dates = lib.aria.mkOpt lib.types.str "weekly" "How often to prune (systemd timer format)";
      flags = lib.aria.mkListOpt lib.types.str [ "--all" ] "Additional flags for podman system prune";
    };
    defaultNetwork = {
      dnsEnabled = lib.aria.mkBoolOpt true "Enable DNS in default network";
    };
  };

  config = lib.mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
      autoPrune = cfg.autoPrune;
      dockerCompat = !isDockerEnabled;
      dockerSocket.enable = !isDockerEnabled;

      defaultNetwork.settings = {
        dns_enabled = cfg.defaultNetwork.dnsEnabled;
      };
    };

    users.users = lib.genAttrs cfg.users (user: {
      extraGroups = [ "podman" ];
    });

    environment.systemPackages = with pkgs; lib.optionals (!isDockerEnabled) [ podman-compose ];
  };
}
