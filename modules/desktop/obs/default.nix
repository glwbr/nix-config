{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.desktop.obs;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.desktop.obs = {
    enable = mkBoolOpt false "Whether to enable OBS-Studio";
  };
  config = lib.mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        droidcam-obs
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-vkcapture
      ];
    };
  };
}
