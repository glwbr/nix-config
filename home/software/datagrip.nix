{pkgs, ...}: {
  home.packages = with pkgs; [
    jetbrains.datagrip
  ];
}
