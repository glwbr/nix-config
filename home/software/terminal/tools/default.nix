{pkgs, ...}: {
  imports = [
    ./bat
    ./bottom
    ./git
    ./gpg
    ./inlyne
    ./nix
    ./skim
    ./transient-services.nix
    ./xdg
    ./yazi
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
    libnotify
    fontconfig
    fastfetch

    # utils
    bottom
    duf
    fd
    file
    jaq
    killall
    ripgrep
  ];

  programs = {
    eza.enable = true;
    ssh.enable = true;
  };
}
