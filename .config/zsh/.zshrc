# Interactive shells.

# A non-login interactive shell — Neovim's :terminal, `zsh -i` — never reads
# .zprofile, which leaves it without Homebrew on PATH and, silently, without any
# plugins. path_helper doesn't run in that case either, so pulling .zprofile in
# here is both safe and enough.
[[ -n $HOMEBREW_PREFIX ]] || source $ZDOTDIR/.zprofile

# ── Options ──────────────────────────────────────────────────────────────────
setopt AUTO_CD                # a bare directory name cds into it
setopt AUTO_PUSHD             # every cd pushes the stack; `cd -<Tab>` browses it
setopt PUSHD_IGNORE_DUPS
setopt EXTENDED_GLOB          # required by the compinit staleness check below
setopt INTERACTIVE_COMMENTS   # allow trailing `# comments` at the prompt
setopt NO_BEEP

export GPG_TTY=$TTY           # zsh's own $TTY; no fork of tty(1)

# ── History ──────────────────────────────────────────────────────────────────
# HISTSIZE is the in-memory window and SAVEHIST the on-disk one. Equal values
# stop zsh trimming the file back down on every write.
HISTFILE="$HOME/.local/state/zsh/history"
HISTSIZE=50000
SAVEHIST=50000
mkdir -p ${HISTFILE:h}

setopt EXTENDED_HISTORY       # timestamp + duration per entry
setopt SHARE_HISTORY          # live sync between open shells
setopt HIST_IGNORE_ALL_DUPS   # a repeat keeps only its newest occurrence
setopt HIST_IGNORE_SPACE      # a leading space keeps the command out of history
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY            # !! lands on the line for review instead of running

# ── Keys ─────────────────────────────────────────────────────────────────────
bindkey -e                    # emacs keymap: Ctrl-A/E/W/R as expected

# Arrows search history filtered by what's already typed, rather than walking it
# blindly. Defined before the plugins load, so they wrap finished widgets.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

bindkey '^[[1;5C' forward-word     # Ctrl-Right
bindkey '^[[1;5D' backward-word    # Ctrl-Left

# ── Completion ───────────────────────────────────────────────────────────────
fpath=(
  /opt/homebrew/share/zsh-completions
  /opt/homebrew/share/zsh/site-functions
  $fpath
)

autoload -Uz compinit
_dump=$HOME/.cache/zsh/zcompdump
mkdir -p ${_dump:h}

# Full rescan at most once a day; every other startup takes the cheap -C path.
# The glob has to happen in an assignment — zsh performs no filename generation
# inside [[ ]], which is why the widely-copied `[[ -n dump(#qNmh+24) ]]` form is
# always true and silently never rescans.
_stale=( $_dump(#qN.mh+24) )
if (( $#_stale )); then
  compinit -d $_dump
else
  compinit -C -d $_dump
fi

# Compiling the dump lets later shells mmap it instead of reparsing it.
[[ -f $_dump.zwc && $_dump.zwc -nt $_dump ]] || zcompile -R -- $_dump
unset _dump _stale

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*'  # case-insensitive, then partial-word
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/zcompcache"

# ── Prompt ───────────────────────────────────────────────────────────────────
autoload -Uz promptinit && promptinit
prompt pure

# ── Tools ────────────────────────────────────────────────────────────────────
eval "$(mise activate zsh)"
eval "$(zoxide init zsh)"          # z, zi

source <(fzf --zsh)                # Ctrl-R history, Ctrl-T files, Alt-C cd
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --border --info inline'
export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers --line-range=:200 {}"'

# ── Aliases & functions ──────────────────────────────────────────────────────
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/functions/extract.zsh

# ── Plugins ──────────────────────────────────────────────────────────────────
# Keep last: syntax highlighting can only colourise the aliases and widgets that
# already exist by the time it loads.
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
