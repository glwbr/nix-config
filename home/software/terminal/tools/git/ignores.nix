{
  ignores = [
    # general
    ".cache/"
    "tmp/"
    "*.tmp"
    "log/"
    "._*"

    # IDE
    "*.swp"
    ".idea/"
    ".~lock*"

    # nix
    "result"
    "result-*"
    ".direnv/"

    # node
    "node_modules/"
  ];
}
