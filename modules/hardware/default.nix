{ config, lib, ... }:
let
  cfg = config.aria.hardware;
in
{
  imports = [ ./audio.nix ./bluetooth.nix ./graphics.nix ./input.nix ./logitech.nix ./wireless ];

  options.aria.hardware = {
    enable = lib.mkEnableOption "hardware defaults";
  };

  config = lib.mkIf cfg.enable {
    aria.hardware = {
      input.enable = lib.mkDefault false;
      audio.enable = lib.mkDefault false;
      logitech.enable = lib.mkDefault false;
      wireless.enable = lib.mkDefault false;
      graphics.enable = lib.mkDefault false;
      bluetooth.enable = lib.mkDefault false;
    };
  };
}
