{
  aliases = {
    a = "add";

    b = "branch";

    c = "commit";
    ca = "commit --amend";
    cm = "commit -m";

    co = "checkout";
    cob = "checkout -b";

    d = "diff";
    ds = "diff --staged";

    l = "log";

    p = "push";
    pf = "push --force-with-lease";

    pl = "pull";

    r = "restore";
    rs = "restore --staged";

    rb = "rebase";
    rbi = "rebase -i";

    s = "status";

    forgor = "commit --amend --no-edit";
    graph = "log --all --decorate --graph --oneline";
    oops = "checkout --";
  };

  shellAliases = { };
}
