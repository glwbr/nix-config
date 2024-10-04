{ inputs, ... }:
{
  imports = [ inputs.hyprland.nixosModules.default ];

  environment.variables.NIXOS_OZONE_WL = "1";

  # Enable hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
