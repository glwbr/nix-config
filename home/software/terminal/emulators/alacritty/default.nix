{ lib, ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      colors.draw_bold_text_with_bright_colors = false;

      cursor = {
        vi_mode_style = {
          shape = "Beam";
          blinking = "Always";
        };
      };

      font = lib.mkForce {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Light";
        };
        size = 16;
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
        dynamic_padding = true;
        padding.x = 2;
        padding.y = 2;
        startup_mode = "Maximized";
      };
    };
  };
}
