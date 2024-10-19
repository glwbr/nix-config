{ pkgs, ... }:
{
  imports = [
    ./bat
    ./bottom
    ./direnv
    ./eza
    ./git
    ./glow
    ./gpg
    ./skim
    ./ssh
    ./tmux
    ./transient-services.nix
    ./zoxide
    #./yazi
  ];

  home.packages = with pkgs; [
    # archives
    zip
    unzip
    unrar

    # media
    viewnior
    yt-dlp

    # misc
    # libnotify
    # fontconfig
    fastfetch

    # utils
    duf
    fd
    file
    jaq
    killall
    ripgrep
  ];
}
