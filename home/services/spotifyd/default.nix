{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.aria.services.spotifyd;
  inherit (lib.aria) mkBoolOpt;
in {
  options.aria.services.spotifyd = {
    enable = mkBoolOpt false "Whether or not to enable spotifyd.";
  };

  config = lib.mkIf cfg.enable {
    services.spotifyd = {
      enable = true;
      package = pkgs.spotifyd.override {withMpris = true;};
      settings.global = {
        autoplay = true;
        backend = "pulseaudio";
        bitrate = 320;
        cache_path = "${config.xdg.cacheHome}/spotifyd";
        device_type = "computer";
        initial_volume = "100";
        password_cmd = "tail -1 /run/agenix/spotify";
        use_mpris = true;
        username_cmd = "head -1 /run/agenix/spotify";
        volume_normalisation = false;
      };
    };
  };
}
