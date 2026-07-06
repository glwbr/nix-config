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

# bat/fd ship under different binary names across distros (Debian: batcat/fdfind,
# most others incl. Homebrew: bat/fd). Pick whichever exists.
if command -v bat >/dev/null 2>&1; then
  _bat=bat
elif command -v batcat >/dev/null 2>&1; then
  _bat=batcat
fi
if [[ -n "$_bat" ]]; then
  alias bat="$_bat"
  alias cat="$_bat -p"
  alias -- --help="--help 2>&1 | $_bat --language=help --style=plain"
fi
unset _bat

command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1 && alias fd='fdfind'

alias grep='rg'
alias du='dust'
alias ps='procs'
alias fm='yazi'

alias top='btm'
alias btop='btm'
alias htop='btm -b' # Runs bottom in basic mode (looks like htop)

alias df='df -h'
alias kernel="uname -r | sed 's/[1-9]\+[0-9]*\.[0-9]\+\.[0-9]\+-//' | sed 's/[1-9]\+[0-9]*\.[0-9]*\-rc[0-9]\+-//'"

# Linux-only aliases (systemd, armbian, GNU coreutils that don't exist on macOS)
if [[ "$OSTYPE" == linux* ]]; then
  alias reboot='sudo reboot'
  alias poweroff='sudo poweroff'
  alias shutdown='sudo shutdown -h now'
  alias config='sudo armbian-config'
  alias temp='sudo armbianmonitor -m'

  alias jctl='journalctl -p 3 -xb'
  alias sctl='systemctl'
  alias uctl='systemctl --user'

  alias free='free -h'
fi

alias g='git'
alias gcld='git clone --depth'

alias dc='docker compose'
alias dcu='docker compose up'
alias dcd='docker compose down'
alias dcl='docker compose logs'
alias k='kubectl'
alias tf='terraform'

alias ytmp3='yt-dlp \
    -f bestaudio \
    -x --audio-format mp3 \
    --audio-quality 0 \
    --embed-metadata \
    --embed-thumbnail \
    --convert-thumbnails jpg \
    --add-metadata \
    --ignore-errors \
    -o "~/Music/%(artist|Unknown Artist)s/%(playlist_title|Singles)s/%(playlist_index)02d - %(title)s.%(ext)s"'


alias pn="pnpm"
