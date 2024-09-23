{ pkgs, ... }:
{
  imports = [
    # import folders first
    ./browsers
    ./desktop
    ./editors
    ./media
    ./terminal
    ./utilities

    #  ./gtk.nix
  ];

  home.packages = with pkgs; [
    # (calibre.override {unrarSupport = true;})

    # social
    # vesktop
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
    # mission-center
    # dart-sass
    # overskride

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
    nodePackages.jsonlint
    php
    typescript
    yaml-language-server
  ];
}
