# ── Editor ───────────────────────────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=nvim

# ── Tool state ───────────────────────────────────────────────────────────────
export NODE_REPL_HISTORY="$HOME/.local/state/node_repl_history"
export LESSHISTFILE=-           # "-" disables ~/.lesshst outright

# Terminal.app derives its session directory from ZDOTDIR, so leaving this on
# writes session state into the dotfiles repo. It also keeps a second history
# file that fights SHARE_HISTORY.
export SHELL_SESSIONS_DISABLE=1

# Keep both arrays deduplicating, so repeated prepends can't stack up.
typeset -U path fpath
