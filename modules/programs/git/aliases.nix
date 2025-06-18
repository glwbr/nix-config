{
  # Basic Operations
  s = "status";
  a = "add";
  aa = "add --all";
  r = "restore";
  rs = "restore --staged";

  # Commit Operations
  c = "commit";
  cm = "commit -m";
  ca = "commit --amend";
  caa = "commit --amend --no-edit";
  wip = "commit -m 'WIP'";

  # Branch & Checkout Operations
  b = "branch";
  co = "checkout";
  cob = "checkout -b";
  sw = "switch";

  # Remote Operations
  cl = "clone";
  p = "push";
  pf = "push --force-with-lease";
  pl = "pull";
  up = "pull --rebase --autostash";

  # History & Information
  l = "log";
  last = "log -1 HEAD";
  graph = "log --all --decorate --graph --pretty=format:'%C(auto)%h%d %s %C(green)(%cr)%C(reset) %C(bold blue)<%an>%C(reset)' --date=short";
  sh = "show";
  d = "diff";
  ds = "diff --staged";

  # Advanced Operations
  st = "stash";
  rb = "rebase";
  nuke = "reset --hard HEAD";
  rbi = "rebase --interactive";
}
