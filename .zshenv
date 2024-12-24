export PATH="$HOME/.local/bin:$PATH"
# XDG
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

# ZSH
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}
export DOTFILESDIR=${DOTFILESDIR:-$HOME/dotfiles}

# EDITORS
export EDITOR="nvim"
export VISUAL="nvim"

# APPLICATIONS DATA
export ASDF_DIR=/opt/asdf-vm/
export ASDF_DATA_DIR=${ASDF_DATA_DIR:-$XDG_DATA_HOME/asdf}
export ASDF_CONFIG_FILE=${ASDF_DATA_DIR/.asdfrc}
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history

# vim:ft=zsh
