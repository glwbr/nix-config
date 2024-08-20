{pkgs, ...}: {
  imports = [
    # import folders first
    ./browsers
    ./media
    ./terminal
    ./utilities
    ./wayland

    ./gtk.nix
  ];

  home.packages = with pkgs; [
    (calibre.override {unrarSupport = true;})

    # social
    vesktop
    tdesktop

    # personalizations
    nixos-icons

    # misc
    catimg
    cliphist
    colord
    ffmpegthumbnailer
    imagemagick
    jq
    pciutils
    ueberzugpp
    xcolor

    # ags
    mission-center
    dart-sass
    overskride

    # Languages
    cmake
    gcc
    gnumake
    gnupatch
    clang-tools
    elixir
    go
    nodejs
    nodePackages.npm
    nodePackages.yarn
    php
    typescript
  ];
}
