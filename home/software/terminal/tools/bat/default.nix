{
  lib,
  pkgs,
  ...
}: {
  programs.bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = lib.mkForce "base16";
      style = "numbers,changes,header";
    };
  };

  home.sessionVariables = {
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };
}
