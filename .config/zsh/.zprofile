# Login shells, and — importantly — after /etc/zprofile, which on macOS runs
# path_helper and puts the system directories back in front of everything.
# Anything that has to win the PATH race belongs here, not in .zshenv.

eval "$(/opt/homebrew/bin/brew shellenv)"

# mise shims keep managed tools resolvable for non-interactive children, such as
# the LSP servers Neovim spawns — without them those die with
# "env: node: No such file or directory". `mise activate` in .zshrc covers
# interactive shells and prepends its own path at runtime, so it still wins there.
path=(
  $HOME/.local/bin
  $HOME/.local/share/mise/shims
  $path
)
export PATH
