{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.aria.services.dunst;
  inherit (lib.aria) mkBoolOpt;
in {
  options.aria.services.dunst = {
    enable = mkBoolOpt false "Whether or not to enable dunst.";
  };
  config = lib.mkIf cfg.enable {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          alignment = "center";
          corner_radius = 16;
          follow = "mouse";
          format = "<b>%s</b>\\n%b";
          frame_width = 1;
          offset = "5x5";
          horizontal_padding = 8;
          icon_position = "left";
          indicate_hidden = "yes";
          markup = "yes";
          max_icon_size = 64;
          mouse_left_click = "do_action";
          mouse_middle_click = "close_all";
          mouse_right_click = "close_current";
          padding = 8;
          plain_text = "no";
          separator_height = 1;
          show_indicators = false;
          shrink = "no";
          word_wrap = "yes";
        };

        fullscreen_delay_everything = {
          fullscreen = "delay";
        };
      };
    };
  };
}
