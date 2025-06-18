{ config, lib, pkgs, ... }:
let
  cfg = config.aria.programs.obs;
in
{
  options.aria.programs.obs.enable = lib.mkEnableOption "OBS Studio";

  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [ droidcam-obs wlrobs obs-backgroundremoval obs-pipewire-audio-capture obs-vaapi obs-vkcapture ];
    };
  };
}
