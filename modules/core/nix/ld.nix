{ config, lib, ... }:
let
  cfg = config.aria.core.nix.ld;
in
{
  options.aria.core.nix.ld = {
    enable = lib.mkEnableOption "nix-ld";
  };

  config = lib.mkIf cfg.enable {
    programs.nix-ld.enable = true;
  };
}
