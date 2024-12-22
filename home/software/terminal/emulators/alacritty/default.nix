{lib, ...}: {
  programs.alacritty = {
    enable = true;

    settings = {
      colors.draw_bold_text_with_bright_colors = true;

      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };

        vi_mode_style = {
          shape = "Beam";
        };
      };

      font = lib.mkDefault {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "ExtraLight";
        };
        size = 18;
      };

      keyboard.bindings = [
        {
          key = "Escape";
          mods = "Alt";
          action = "ToggleViMode";
        }
      ];

      env = {
        TERM = "xterm-256color"; # Better color support in some apps
      };

      scrolling.history = 10000;

      window = {
        decorations = "none";
        # dynamic_padding = true;
        padding = {
          x = 0;
          y = 0;
        };
      };
    };
  };
}
