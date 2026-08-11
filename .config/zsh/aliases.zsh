# ── Navigation ───────────────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias tmp='cd /tmp'
alias md='mkdir -p'
alias q='exit'
alias c='clear'

# ── Files ────────────────────────────────────────────────────────────────────
alias cp='cp -vr'
alias mv='mv -v'
alias rm='rm -v'      
alias df='df -h'

alias ls='eza --icons --group-directories-first'
alias la='ls --all'
alias ll='eza --icons --group-directories-first --long --header --classify'
alias lla='ll --all'
alias tree='eza --tree --level=2 --icons'

alias cat='bat --plain'

# `help curl` — paged, highlighted --help. A plain `alias -- --help=…` can't do
# this: zsh expands aliases in command position only, so it never fires.
help() { "$@" --help 2>&1 | bat --plain --language=help }

# ── Editor ───────────────────────────────────────────────────────────────────
alias v=nvim
alias vim=nvim

# ── Git ──────────────────────────────────────────────────────────────────────
alias g=git
alias gcld='git clone --depth'

# ── Containers ───────────────────────────────────────────────────────────────
alias dc='docker compose'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dcl='docker compose logs'
alias k=kubectl

# ── Node ─────────────────────────────────────────────────────────────────────
alias pn=pnpm
