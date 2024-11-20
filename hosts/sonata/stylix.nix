{
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

    cursor = {
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 24;
    };

    fonts = {
      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };

      monospace = {
        name = "JetBrainsMono Nerd Font";
        package = with pkgs; nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
      };

      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };

      serif = {
        name = "Source Serif";
        package = pkgs.source-serif;
      };

      sizes = {
        applications = 12;
        desktop = 10;
        popups = 12;
        terminal = 24;
      };
    };

    # Global wallpaper definition
    image = pkgs.fetchurl {
      url = "https://gruvbox-wallpapers.pages.dev/wallpapers/minimalistic/gruv-limits.png";
      sha256 = "sha256-kTkkAESPcuqIuy1PSLVFbazbELmfXLogxxNMfr5wHoU=";
    };

    opacity = {
      applications = 1.0;
      terminal = 0.98;
      desktop = 1.0;
      popups = 1.0;
    };

    polarity = "dark"; # "light" or "either"
  };
}
