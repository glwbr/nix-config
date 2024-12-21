{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.aria.system.nix.nh;
  inherit (lib.aria) mkBoolOpt;
in {
  options.aria.system.nix.ld = {
    enable = mkBoolOpt false "Whether or not to enable nix-ld.";
  };

  config = lib.mkIf cfg.enable {
    programs.nix-ld.enable = true;
  };
}
