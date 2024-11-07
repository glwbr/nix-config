{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.aria.system.fonts;

  inherit (lib) mkIf;
  inherit (lib.aria) mkBoolOpt;
in
{
  options.aria.system.fonts = {
    enable = mkBoolOpt false "Whether or not to enable font settings.";
  };

  config = mkIf cfg.enable {
    fonts = {
      enableDefaultPackages = false;
      fontDir.enable = true;
      packages = with pkgs; [
        # Icon font
        material-symbols

        # Sans (Serif) fonts
        (google-fonts.override { fonts = [ "Inter" ]; })
        liberation_ttf
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        noto-fonts-color-emoji
        roboto

        # Nerd Fonts
        (nerdfonts.override {
          fonts = [
            "NerdFontsSymbolsOnly"
            "JetBrainsMono"
            "FiraCode"
          ];
        })
      ];

      fontconfig = {
        enable = true;
        antialias = true;
        defaultFonts = {
          emoji = [ "Noto Color Emoji" ];
          monospace = [
            "Symbols Nerd Font Mono"
            "JetBrainsMono Nerd Font"
            "Noto Emoji"
          ];
          sansSerif = [
            "Symbols Nerd Font"
            "Inter"
            "Noto Color Emoji"
          ];
          serif = [
            "Symbols Nerd Font"
            "Noto Serif"
            "Noto Color Emoji"
          ];
        };
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
