_: {
  # nh default flake
  environment.variables.FLAKE = "/home/glwbr/Workspace/nix-config";

  programs.nh = {
    enable = true;
    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
  };
}
