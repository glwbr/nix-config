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
autoload -Uz async promptinit
promptinit
prompt pure

# Completion
autoload -Uz compinit

fpath+=(
  "$ZDOTDIR/plugins/zsh-completions/src"
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

# Plugins
[[ -f "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && \
  source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"

[[ -f "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh" ]] && \
  source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Functions
source "$ZDOTDIR/functions/extract.zsh"

# Aliases
[[ -f "$ZDOTDIR/aliases.zsh" ]] && source "$ZDOTDIR/aliases.zsh"

# Toolchains / Env
[[ -f "$HOME/.asdf/asdf.sh" ]] && source "$HOME/.asdf/asdf.sh"

export PNPM_HOME="$HOME/.local/share/pnpm"
[[ ":$PATH:" != *":$PNPM_HOME:"* ]] && export PATH="$PNPM_HOME:$PATH"

export PATH="$HOME/.opencode/bin:$PATH"
