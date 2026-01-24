alias v='nvim'
alias vim='nvim'

alias ..='cd ..'
alias ...='cd ../..'
alias tmp='cd /tmp/'
alias q='exit'
alias c='clear'
alias md='mkdir -p'

alias cp='cp -vr'
alias mv='mv -v'
alias rm='rm -rv'

alias ls='eza --icons --group-directories-first'
alias la='eza --icons --group-directories-first --all'
alias ll='eza --icons --group-directories-first --long --header --classify'
alias lla='ll --all'
alias tree='eza --tree --level=2 --icons'

alias bat='batcat'
alias cat='batcat -p'
alias -- --help='--help 2>&1 | bat --language=help --style=plain'

alias grep='rg'
alias du='dust'
alias ps='procs'
alias fm='yazi'
alias fd='fdfind'

alias top='btm'
alias btop='btm'
alias htop='btm -b' # Runs bottom in basic mode (looks like htop)

alias reboot='sudo reboot'
alias poweroff='sudo poweroff'
alias shutdown='sudo shutdown -h now'
alias config='sudo armbian-config'
alias temp='sudo armbianmonitor -m'

alias jctl='journalctl -p 3 -xb'
alias sctl='systemctl'
alias uctl='systemctl --user'

alias df='df -h'
alias free='free -h'
alias kernel="uname -r | sed 's/[1-9]\+[0-9]*\.[0-9]\+\.[0-9]\+-//' | sed 's/[1-9]\+[0-9]*\.[0-9]*\-rc[0-9]\+-//'"

alias g='git'
alias gcld='git clone --depth'

alias dc='docker compose'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dcl='docker compose logs'
alias k='kubectl'
alias tf='terraform'

alias ytmp3="yt-dlp --ignore-errors -x --audio-format mp3 -f bestaudio --audio-quality 0 --embed-metadata --embed-thumbnail --output '%(title)s.%(ext)s'"

alias pn="pnpm"
