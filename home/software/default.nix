{pkgs, ...}: {
  imports = [
    # import folders first
    ./browsers
    ./desktop
    ./editors
    ./media
    ./terminal
    #./utilities

    # ./gtk.nix
    # ./datagrip.nix
  ];

  home.packages = with pkgs; [
    # (calibre.override {unrarSupport = true;})

    # social
    # vesktop
    # tdesktop

    # personalizations
    #nixos-icons

    # misc
    #cliphist
    #colord
    #jq
    pciutils
    #xcolor

    # ags
    # mission-center
    # dart-sass
    # overskride

    # Languages
    #cmake
    #gcc
    #gnumake
    #gnupatch
    #clang-tools
    #elixir
    #go
    nodejs_latest
    nodePackages.yarn
    nodePackages.jsonlint
    php83
    # typescript
    # yaml-language-server
  ];
}
