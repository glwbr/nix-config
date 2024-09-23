{ pkgs, ... }:
{
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
      noto-fonts-cjk
      noto-fonts-emoji
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
      enable = true;
      hinting = {
        autohint = false;
        enable = true;
        style = "slight";
      };
      subpixel = {
        lcdfilter = "light";
        rgba = "rgb";
      };
    };
  };
}
