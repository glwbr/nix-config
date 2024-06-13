{config, ...}: let
  colors = config.stylix.base16Scheme;
  inherit (config.stylix) fonts image;
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = false;
        no_fade_in = true;
      };

      background = [
        {
          monitor = "";
          path = image;
          blur_passes = 3;
          blur_size = 6;
          noise = 0.1;
          contrast = 1.1;
          brightness = 1.2;
        }
      ];

      input-field = [
        {
          monitor = "HDMI-A-1";
          # width, height
          size = "300, 50";

          outline_thickness = 2;
          outer_color = "rgb(${colors.base0D})";
          inner_color = "rgb(${colors.base07})";
          fail_color = "rbg(${colors.base08})";
          font_color = "rgb(${colors.base05})";

          fade_on_empty = false;
          placeholder_text = ''
            <span font_family="${fonts.sansSerif.name}" foreground="##${colors.base05}">Password...</span>
          '';

          dots_spacing = 0.3;
          dots_center = true;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          font_family = fonts.sansSerif.name;
          font_size = 50;
          color = "rgb(${config.stylix.base16Scheme.base0D})";
          # x, y
          position = "0, 80";

          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
