{ config, pkgs, ... }:
let
  pointer = config.stylix.cursor;
in
{
  imports = [ ./keybindings.nix ];
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

    debug.disable_logs = false;

    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    input = {
      kb_layout = "us,us";
      kb_variant = ",intl";
      kb_options = "caps:swapescape,grp:alt_space_toggle";

      repeat_delay = 170;
      repeat_rate = 30;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      vfr = true;
      vrr = true;
    };

    xwayland.force_zero_scaling = true;
  };
}
