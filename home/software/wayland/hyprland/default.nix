{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./plugins

    ./binds.nix
    ./rules.nix
    ./settings.nix
  ];

  home = {
    packages = with pkgs; [
      grimblast
      jaq
      seatd
      xorg.xprop
      xwaylandvideobridge
    ];

    file = {
      ".config/hypr/scripts/colorpicker" = {
        source = ./scripts/colorpicker;
        executable = true;
      };
    };
  };

  # enable hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
