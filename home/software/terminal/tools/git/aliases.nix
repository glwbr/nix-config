{
  aliases = {
    a = "add";
    b = "branch";
    c = "commit";
    d = "diff";
    l = "log";
    p = "push";
    r = "restore";
    s = "status";
    ca = "commit --amend";
    cl = "clone";
    cm = "commit -m";
    co = "checkout";
    ds = "diff --staged";
    pf = "push --force-with-lease";
    pl = "pull";
    rb = "rebase";
    rs = "restore --staged";

    cob = "checkout -b";
    rbi = "rebase -i";

    forgor = "commit --amend --no-edit";
    graph = "log --all --decorate --graph --oneline";
    last = "log -1 HEAD";
    oops = "checkout --";
  };

  shellAliases = {
    g = "git";
    commit = "git add . && git commit -m";
    push = "git push";
    pull = "git pull";
    gcld = "git clone --depth";
    gco = "git checkout";
    gitgrep = "git ls-files | rg";
    gitrm = "git ls-files --deleted -z | xargs -0 git rm";
  };
}
