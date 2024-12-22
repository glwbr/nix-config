{
  config,
  lib,
  pkgs,
  ...
}: let
  pointer = config.stylix.cursor;
in {
  imports = [
    ./keybindings.nix
    ./windowrules.nix
  ];
  wayland.windowManager.hyprland.settings = {
    exec = ["hyprctl setcursor ${pointer.name} ${toString pointer.size}"];

    exec-once = ["${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"];

    animations = {
      enabled = true;
      bezier = [
        "easein,0.1, 0, 0.5, 0"
        "easeinback,0.35, 0, 0.95, -0.3"
        "easeout,0.5, 1, 0.9, 1"
        "easeoutback,0.35, 1.35, 0.65, 1"
        "easeinout,0.45, 0, 0.55, 1"
      ];

      animation = [
        "fadeIn,1,3,easeout"
        "fadeLayersIn,1,3,easeoutback"
        "layersIn,1,3,easeoutback,slide"
        "windowsIn,1,3,easeoutback,slide"

        "fadeLayersOut,1,3,easeinback"
        "fadeOut,1,3,easein"
        "layersOut,1,3,easeinback,slide"
        "windowsOut,1,3,easeinback,slide"

        "border,1,3,easeout"
        "fadeDim,1,3,easeinout"
        "fadeShadow,1,3,easeinout"
        "fadeSwitch,1,3,easeinout"
        "windowsMove,1,3,easeoutback"
        "workspaces,1,2.6,easeoutback,slide"
      ];
    };

    decoration = lib.mkForce {
      active_opacity = 1.0;
      dim_inactive = true;
      dim_strength = 0.2;
      inactive_opacity = 0.98;
      fullscreen_opacity = 1.0;
      rounding = 4;

      blur = {
        enabled = true;
        brightness = 1.0;
        ignore_opacity = true;
        new_optimizations = true;

        passes = 3;
        size = 4;
        xray = true;
      };

      shadow = {
        enabled = true;
        offset = "3 3";
        range = 12;
        color = "0x44000000";
        color_inactive = "0x66000000";
      };
    };

    debug = {
      disable_logs = false;
      suppress_errors = true;
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
      smart_split = false;
      split_width_multiplier = 1.35;
    };

    general = {
      gaps_in = 2;
      gaps_out = 4;
      border_size = 2;

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

      new_window_takes_over_fullscreen = 2;

      enable_swallow = true;
      swallow_regex = "^(A|a)lacritty|footclient|foot$";

      vfr = true;
      vrr = 2;
    };

    xwayland.force_zero_scaling = true;
  };
}
