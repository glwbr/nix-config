{ config, lib, ... }:
let
  cfg = config.aria.core;
in
{
  imports = [ ./fonts.nix ./users.nix ./nix ];

  options.aria.core = {
    enable = lib.mkEnableOption "core funcionalities";
  };

  config = lib.mkIf cfg.enable {
    aria.core = {
      users.enable = lib.mkDefault true;
      nix.daemon.enable = lib.mkDefault true;

      fonts.enable = lib.mkDefault false;
    };
  };
}
