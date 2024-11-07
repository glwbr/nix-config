{ config, lib, ... }:
let
  cfg = config.aria.virtualisation.docker;

  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.virtualisation.docker = {
    enable = mkBoolOpt false "Whether or not to enable docker.";
  };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
    };

    aria.user.extraGroups = [ "docker" ];
  };
}
