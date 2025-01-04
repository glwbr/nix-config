alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
alias trimall="sudo fstrim -va"
alias tmp="cd /tmp/"
alias ls="eza --icons --group-directories-first --sort Name"
alias ll="ls --long --header"
alias lla="ll --all"
alias tree="ls --tree --level=3"
alias cp="cp -vr"
alias df="df -h"
alias du="dust"
alias free="free -h"
alias grep="rg"
alias fm="yazi"
alias ytmp3="yt-dlp --ignore-errors -x --audio-format mp3 -f bestaudio --audio-quality 0 --embed-metadata --embed-thumbnail --output '%(title)s.%(ext)s'"
alias jctl="journalctl -p 3 -xb"
alias rs="sudo systemctl"
alias us="systemctl --user"
alias btop="btm"
alias htop="btm -b"
alias md="mkdir -p"
alias mv="mv -v"
alias rm="rm -rv"
alias q="exit"
