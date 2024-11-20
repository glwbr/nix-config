{ lib, pkgs, ... }:
let
  grimblast = lib.getExe pkgs.grimblast;
in
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER, Q, killactive,"
      "SUPER, F, fullscreen, 1"
      "SUPER, P, pseudo,"
      "SUPER, E, exec, alacritty -e yazi"

      "SUPER, RETURN, exec, alacritty"
      "SUPER, SPACE, togglefloating,"

      "SUPER, 1, workspace,1"
      "SUPER, 2, workspace,2"
      "SUPER, 3, workspace,3"
      "SUPER, 4, workspace,4"
      "SUPER, 5, workspace,5"
      "SUPER, 6, workspace,6"
      "SUPER, 7, workspace,7"
      "SUPER, 8, workspace,8"
      "SUPER, 9, workspace,9"

      "SUPER_SHIFT, 1, movetoworkspacesilent, 1"
      "SUPER_SHIFT, 2, movetoworkspacesilent, 2"
      "SUPER_SHIFT, 3, movetoworkspacesilent, 3"
      "SUPER_SHIFT, 4, movetoworkspacesilent, 4"
      "SUPER_SHIFT, 5, movetoworkspacesilent, 5"
      "SUPER_SHIFT, 6, movetoworkspacesilent, 6"
      "SUPER_SHIFT, 7, movetoworkspacesilent, 7"
      "SUPER_SHIFT, 8, movetoworkspacesilent, 8"
      "SUPER_SHIFT, 9, movetoworkspacesilent, 9"

      "SUPER_SHIFT, E, exec, pkill Hyprland"

      # move focus
      "SUPER, K, movefocus, u"
      "SUPER, J, movefocus, d"
      "SUPER, L, movefocus, r"
      "SUPER, H, movefocus, l"

      # move windows
      "SUPER_SHIFT, K, movewindow, u"
      "SUPER_SHIFT, J, movewindow, d"
      "SUPER_SHIFT, L, movewindow, r"
      "SUPER_SHIFT, H, movewindow, l"

      # cycle workspaces
      "SUPER, left, workspace, m-1"
      "SUPER, right, workspace, m+1"

      # cycle monitors
      "SUPER, bracketleft, focusmonitor, l"
      "SUPER, bracketright, focusmonitor, r"

      # send focused workspace to left/right monitors
      "SUPER_SHIFT, bracketleft, movecurrentworkspacetomonitor, l"
      "SUPER_SHIFT, bracketright, movecurrentworkspacetomonitor, r"

      # screenshot
      "CTRL, Print, exec, grimblast --notify --cursor copysave output"
      "ALT, Print, exec, grimblast --notify --cursor copysave screen"

      ",Print,exec,${grimblast} --notify --freeze copy area"
      "SHIFT,Print,exec,${grimblast} --notify --freeze copy output"
    ];

    bindl = [
      # Media controls
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"

      # Volume
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    bindle = [
      # Volume
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"

      # Backlight
      ", XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
      ", XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
    ];

    bindm = [
      "SUPER,mouse:272,movewindow"
      "SUPER,mouse:273,resizewindow"
    ];
  };
}
