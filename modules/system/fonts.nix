{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.aria) mkBoolOpt;

  cfg = config.aria.system.fonts;
in {
  options.aria.system.fonts = {
    enable = mkBoolOpt false "Whether to enable font settings";
  };

  config = lib.mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = false;
      fontDir.enable = true;
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.ubuntu-mono
        nerd-fonts.symbols-only
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        noto-fonts-emoji
        roboto
      ];

      fontconfig = {
        enable = true;
        antialias = true;
        hinting = {
          enable = true;
          autohint = false;
          style = "slight";
        };
        subpixel = {
          lcdfilter = "light";
          rgba = "rgb";
        };
      };
    };
  };
}
