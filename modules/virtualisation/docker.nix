{
  config,
  lib,
  ...
}: let
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.virtualisation.docker;
in {
  options.aria.virtualisation.docker = {
    enable = mkBoolOpt false "Whether to enable docker";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.docker.enable = true;

    aria.users.extraGroups = ["docker"];
  };
}
