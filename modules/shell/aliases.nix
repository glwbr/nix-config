{
  # Git Shell Aliases
  g = "git";
  commit = "git add . && git commit -m";
  push = "git push";
  pull = "git pull";
  gcld = "git clone --depth";
  gitgrep = "git ls-files | rg";
  gitrm = "git ls-files --deleted -z | xargs -0 git rm";

  # Utility Aliases
  "--help" = "--help 2>&1 | bat --language=help --style=plain";
  tmp = "cd /tmp/";
  ls = "eza --icons --group-directories-first --sort Name";
  ll = "ls --long --header";
  lla = "ll --all";
  tree = "ls --tree --level=1 --git-ignore";
  cp = "cp -vr";
  df = "df -h";
  du = "dust";
  free = "free -h";
  grep = "rg";
  fm = "yazi";
  ytmp3 = "yt-dlp --ignore-errors -x --audio-format mp3 -f bestaudio --audio-quality 0 --embed-metadata --embed-thumbnail --output '%(title)s.%(ext)s'";

  # System and Monitoring
  jctl = "journalctl -p 3 -xb";
  rs = "sudo systemctl";
  us = "systemctl --user";
  btop = "btm";
  htop = "btm -b";

  # File Management
  md = "mkdir -p";
  mv = "mv -v";
  rm = "rm -rv";

  # Miscellaneous
  q = "exit";

  # nix
  nd = "nix develop -c $SHELL";
  ns = "nix shell";
  nb = "nix build";
  nf = "nix flake";
  nfu = "nix flake update";

  bloat = "nix path-info -Sh /run/current-system";
  switch = "nh os switch";
  rebuild = "nh os test";

  # nix gc
  cleanup = "nh clean all";
  listgen = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";

  # nix packages
  installed = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq | sk";
}
