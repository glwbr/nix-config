# Login-shell setup. zsh reads $ZDOTDIR/.zprofile (not ~/.zprofile) once ZDOTDIR
# is set, so Homebrew is initialized here. Exported vars are inherited by any
# non-login child shells.

# Homebrew (macOS / Linuxbrew)
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  [[ -x "$_brew" ]] && eval "$("$_brew" shellenv)" && break
done
unset _brew

# vim:ft=zsh
