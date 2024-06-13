{inputs, ...}: {
  imports = [
    ./editors
    ./software
    ./services

    inputs.nix-index-db.hmModules.nix-index
  ];

  home = {
    username = "glwbr";
    homeDirectory = "/home/glwbr";
    stateVersion = "24.05";
  };

  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  # let HM manage itself when in standalone mode
  programs.home-manager.enable = true;
}
