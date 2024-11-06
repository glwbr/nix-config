{ config, pkgs, ... }:
let
  pointer = config.stylix.cursor;
in
{
  imports = [
    ./keybindings.nix
    ./windowrules.nix
  ];
  wayland.windowManager.hyprland.settings = {
    exec = [ "hyprctl setcursor ${pointer.name} ${toString pointer.size}" ];

    exec-once = [ "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1" ];

    animations = {
      enabled = true;
      bezier = [
        "fluent_decel, 0, 0.2, 0.4, 1"
        "easeOutCirc, 0, 0.55, 0.45, 1"
        "easeOutCubic, 0.33, 1, 0.68, 1"
        "easeinoutsine, 0.37, 0, 0.63, 1"
      ];

      animation = [
        "windowsIn, 1, 1.7, easeOutCubic, slide"
        "windowsOut, 1, 1.7, easeOutCubic, slide"
        "windowsMove, 1, 2.5, easeinoutsine, slide"
        "border, 1, 2, default"

        # Fading
        "fadeIn, 1, 3, easeOutCubic"
        "fadeOut, 1, 3, easeOutCubic"
        "fadeSwitch, 1, 5, easeOutCirc"
        "fadeShadow, 1, 5, easeOutCirc"
        "fadeDim, 1, 6, fluent_decel"
        "border, 1, 2.7, easeOutCirc"
        "workspaces, 1, 2, fluent_decel, slide"
        "specialWorkspace, 1, 3, fluent_decel, slidevert"
      ];
    };

    decoration = {
      rounding = 4;

      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 2.0e-2;
        new_optimizations = true;

        passes = 3;
        size = 8;
        xray = true;
      };

      drop_shadow = false;
      shadow_ignore_window = true;
      shadow_offset = "0 2";
      shadow_range = 20;
      shadow_render_power = 3;
    };

    debug.disable_logs = false;

    dwindle = {
      no_gaps_when_only = false;
      pseudotile = true;
      preserve_split = true;
      smart_split = false;
      smart_resizing = false;
    };

    general = {
      gaps_in = 2;
      gaps_out = 4;
      border_size = 1;

      monitor = [
        "eDP-1, 1920x1080@60, 0x0, 1"
        "HDMI-A-1, 2560x1440@60, 1920x0, 1"
      ];

      allow_tearing = true;
      resize_on_border = true;
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    input = {
      accel_profile = "flat";
      follow_mouse = true;

      kb_layout = "us,us";
      kb_variant = ",intl";
      kb_options = "caps:swapescape,grp:alt_space_toggle";

      repeat_delay = 170;
      repeat_rate = 30;

      touchpad = {
        disable_while_typing = true;
        scroll_factor = 0.1;
      };
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;

      force_default_wallpaper = false;

      enable_swallow = true;
      swallow_regex = "^(A|a)lacritty|footclient|foot$";

      vfr = true;
      vrr = 2;
    };

    xwayland.force_zero_scaling = true;
  };
}
