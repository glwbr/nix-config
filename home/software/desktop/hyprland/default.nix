{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.aria.programs.wms.hyprland;

  inherit (lib.aria) mkBoolOpt;
in
{

  imports = [
    inputs.hyprland.homeManagerModules.default
    ./settings.nix
  ];

  options.aria.programs.wms.hyprland = {
    enable = mkBoolOpt false "Whether or not to enable hyprland settings.";
  };

  config = lib.mkIf cfg.enable {

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
  };
}
