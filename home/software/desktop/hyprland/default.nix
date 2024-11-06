{
  lib,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./settings.nix
  ];

  home.packages = with pkgs; [
    grimblast
    hyprpicker
    slurp
  ];

  # Enable hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      variables = [ "--all" ];
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };
}
