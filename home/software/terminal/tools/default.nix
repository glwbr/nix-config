{ pkgs, ... }:
{
  imports = [
    ./bat
    ./bottom
    ./direnv
    ./eza
    ./fzf
    ./git
    ./glow
    ./gpg
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
    file
    jaq
    killall
  ];
}
