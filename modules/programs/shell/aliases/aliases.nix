{
  git = {
    g = "git";
    gcld = "git clone --depth";
  };

  utility = {
    "--help" = "--help 2>&1 | bat --language=help --style=plain";
    tmp = "cd /tmp/";
    q = "exit";
    c = "clear";

    ls = "eza --icons --group-directories-first";
    ll = "eza --icons --group-directories-first --long --header";
    la = "eza --icons --group-directories-first --long --header --all";
    lla = "ll --all";
    tree = "eza --tree --level=2 --icons";

    cp = "cp -vr";
    mv = "mv -v";
    rm = "rm -rv";
    md = "mkdir -p";

    df = "df -h";
    du = "dust";
    free = "free -h";

    fzf = "sk";
    grep = "rg";
    fm = "yazi";

    ytmp3 = "yt-dlp --ignore-errors -x --audio-format mp3 -f bestaudio --audio-quality 0 --embed-metadata --embed-thumbnail --output '%(title)s.%(ext)s'";
  };

  system = {
    ".." = "cd ..";
    "..." = "cd ../..";
    jctl = "journalctl -p 3 -xb";
    sctl = "systemctl";
    uctl = "systemctl --user";
    btop = "btm";
    htop = "btm -b";
    ps = "procs";
  };

  nix = {
    nb = "nix build";
    nd = "nix develop -c $SHELL";
    nf = "nix flake";
    ns = "nix shell";
    nfu = "nix flake update";

    switch = "nh os switch";
    rebuild = "nh os test";
    cleanup = "nh clean all";

    bloat = "nix path-info -Sh /run/current-system";
    listgen = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
    installed = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq | sk";
  };

  development = {
    dc = "docker compose";
    dcu = "docker compose up";
    dcd = "docker compose down";
    dcl = "docker compose logs";
    k = "kubectl";
    tf = "terraform";
  };
}
