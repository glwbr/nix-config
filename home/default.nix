{ outputs, ... }:
{
  imports = [
    ./software
    ./services
  ];

  home = {
    username = "glwbr";
    homeDirectory = "/home/glwbr";
    stateVersion = "24.05";
  };

  nixpkgs = {
    config.allowUnfree = true;
    config.allowUnfreePredicate = _: true;
    overlays = builtins.attrValues outputs.overlays;
  };

  # Hint electron apps to use wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  # Let HM manage itself when in standalone mode
  programs.home-manager.enable = true;
}
