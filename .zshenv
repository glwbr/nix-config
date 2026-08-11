# Symlinked to ~/.zshenv. zsh reads this before ZDOTDIR exists, so it has to
# live in $HOME. Its only job is to point zsh at the real config dir and hand
# off — zsh does not re-read .zshenv once ZDOTDIR changes, so the source below
# has to be explicit.

export ZDOTDIR="$HOME/.config/zsh"
[[ -r $ZDOTDIR/.zshenv ]] && source $ZDOTDIR/.zshenv
