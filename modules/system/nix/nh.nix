{
  config,
  lib,
  ...
}:
let
  inherit (lib.aria) mkBoolOpt;
  cfg = config.aria.system.nix.nh;
in
{
  options.aria.system.nix.nh = {
    enable = mkBoolOpt false "Whether or not to enable nh";
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      # weekly cleanup
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/glwbr/projects/nix-config";
    };
  };
}
