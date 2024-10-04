_: {
  wayland.windowManager.hyprland.settings = {
    bind = [
      "SUPER_SHIFT, E, exec, pkill Hyprland"
      "SUPER, RETURN, exec, alacritty"

      "SUPER, Q, killactive,"

      "SUPER, SPACE, togglefloating,"

      "SUPER, 1, workspace,1"
      "SUPER, 2, workspace,2"
      "SUPER, 3, workspace,3"
      "SUPER, 4, workspace,4"
      "SUPER, 5, workspace,5"

      "SUPER_SHIFT, 1, movetoworkspacesilent, 1"
      "SUPER_SHIFT, 2, movetoworkspacesilent, 2"
      "SUPER_SHIFT, 3, movetoworkspacesilent, 3"
      "SUPER_SHIFT, 4, movetoworkspacesilent, 4"
      "SUPER_SHIFT, 5, movetoworkspacesilent, 5"

      ",Print,exec,screenshot"
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
