# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt* | Eterm | aterm | kterm | gnome* | alacritty | kitty*)
	TERM_TITLE=$'\e]0;%n@%m: %1~\a'
	;;
*) ;;
esac

# enable keyword-style arguments in shell functions
set -k

# Colors
autoload -Uz colors && colors

# Autosuggest
ZSH_AUTOSUGGEST_USE_ASYNC="true"
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_HISTORY_IGNORE=$'*\n*'

# Improve paste delay for nix store paths
FAST_HIGHLIGHT[use_async]=1
