{ config, lib, ... }:
let
  cfg = config.aria.core.nix.nh;
in
{
  options.aria.core.nix.nh = {
    enable = lib.mkEnableOption "nh (NixOS helper)";

    flakePath = lib.aria.mkOpt lib.types.str "/etc/nixos" "Path to the flake directory";
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 7";
      flake = cfg.flakePath;
    };
  };
}
