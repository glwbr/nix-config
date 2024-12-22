{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.stylix.homeManagerModules.stylix];

  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

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
        package = pkgs.nerd-fonts.jetbrains-mono;
      };

      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };

      serif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };

      sizes = {
        applications = 12;
        desktop = 10;
        popups = 12;
        terminal = 17;
      };
    };

    # Global wallpaper definition
    image = pkgs.fetchurl {
      url = "https://i.imgur.com/l6xe2Rj.jpg";
      sha256 = "sha256-DdSly61XV61My9s0mU7SvovQDiAaw6BnUjHZeUaQ4gY=";
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
