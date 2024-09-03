{
  lib,
  pkgs,
  ...
}: {
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = lib.mkForce "catppuccin";
      style = "numbers,changes,header";
    };

    themes = {
      kanagawa = {
        src = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/rebelot/kanagawa.nvim/7b411f9e66c6f4f6bd9771f3e5affdc468bcbbd2/extras/kanagawa.tmTheme";
          hash = "sha256-ohgKjj83XzUD/FmnAtQm9rJ2DXwsXJfbRxDbrUYyYcI=";
        };
      };

      catppuccin = {
        src = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/bat/d714cc1d358ea51bfc02550dabab693f70cccea0/themes/Catppuccin%20Mocha.tmTheme";
          hash = "sha256-UDJ6FlLzwjtLXgyar4Ld3w7x3/zbbBfYLttiNDe4FGY=";
        };
      };
    };
  };

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };
}
