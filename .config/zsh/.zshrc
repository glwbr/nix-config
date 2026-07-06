# General
KEYTIMEOUT=1
setopt AUTOCD
export GPG_TTY=$(tty)

# History
HISTFILE="$ZDOTDIR/history.zsh"
HISTSIZE=1000
SAVEHIST=10000

setopt EXTENDEDHISTORY
setopt INC_APPEND_HISTORY_TIME
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

# Prompt
fpath+=( "$ZDOTDIR/pure" )
[[ -n "$HOMEBREW_PREFIX" ]] && fpath+=( "$HOMEBREW_PREFIX/share/zsh/site-functions" )
autoload -Uz async promptinit
promptinit
# Only load pure if it's actually installed (repo dir or Homebrew site-functions)
(( ${prompt_themes[(I)pure]} )) && prompt pure

# Completion
autoload -Uz compinit

fpath+=(
  "$ZDOTDIR/plugins/zsh-completions/src"
  "$HOMEBREW_PREFIX/share/zsh-completions"
  /usr/share/zsh/functions/Completion
  /usr/share/zsh/site-functions
)

ZSH_CACHE_DIR="$HOME/.cache/zsh"
[[ -d "$ZSH_CACHE_DIR" ]] || mkdir -p "$ZSH_CACHE_DIR"

compinit -d "$ZSH_CACHE_DIR/zcompdump" -C

[[ ! -f "$ZSH_CACHE_DIR/zcompdump.zwc" || \
   "$ZSH_CACHE_DIR/zcompdump" -nt "$ZSH_CACHE_DIR/zcompdump.zwc" ]] && \
  zcompile "$ZSH_CACHE_DIR/zcompdump"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*'

# Plugins — source from the repo's plugin dir (Linux) or Homebrew share (macOS),
# whichever is present.
for _p in \
  "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" \
  "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"; do
  [[ -f "$_p" ]] && source "$_p" && break
done

for _p in \
  "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh" \
  "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"; do
  [[ -f "$_p" ]] && source "$_p" && break
done
unset _p

# fzf: prefer the built-in shell integration (fzf >= 0.48), fall back to ~/.fzf.zsh
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --shell zsh 2>/dev/null)
elif [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

# Functions
source "$ZDOTDIR/functions/extract.zsh"

# Aliases
[[ -f "$ZDOTDIR/aliases.zsh" ]] && source "$ZDOTDIR/aliases.zsh"

# Toolchains / Env
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

export PNPM_HOME="$HOME/.local/share/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

export PATH="$HOME/.opencode/bin:$PATH"
