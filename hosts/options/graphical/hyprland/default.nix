{
  config,
  inputs,
  lib,
  ...
}:
let
  cfg = config.aria.wms.hyprland;
  inherit (lib.aria) mkBoolOpt;
in
{

  options.aria.wms.hyprland = {
    enable = mkBoolOpt false "Whether or not to enable hyprland.";
  };

  imports = [ inputs.hyprland.nixosModules.default ];

  config = lib.mkIf cfg.enable {

    environment.variables.NIXOS_OZONE_WL = "1";

    # Enable hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
