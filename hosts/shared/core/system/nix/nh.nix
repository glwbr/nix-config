_: {
  programs.nh = {
    enable = true;
    # weekly cleanup
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/glwbr/projects/nix-config";
  };
}
