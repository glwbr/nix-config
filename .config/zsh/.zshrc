autoload -Uz compinit; compinit
# autoload -Uz edit-command-line

# ZSH_AUTOSUGGEST_MANUAL_REBIND=1
 
# plug "zsh-users/zsh-autosuggestions"
# plug "zsh-users/zsh-syntax-highlighting"
# plug "Aloxaf/fzf-tab"
# plug "greymd/docker-zsh-completion"
# I'm stupid and keeping forgetting my aliases
# plug "MichaelAquilina/zsh-you-should-use"
 
# Sourcing
. "$ZDOTDIR/aliases"
. "$ZDOTDIR/opts"
. "/opt/asdf-vm/asdf.sh"

for file in $ZDOTDIR/functions/*; do
    if [[ -f "$file" ]]; then
        source "$file"
    fi
done

[[ ${ZDOTDIR}/.zcompdump.zwc -nt ${ZDOTDIR}/.zcompdump ]] || zcompile-many ${ZDOTDIR}/.zcompdump

# vim:ft=zsh
