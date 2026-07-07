# Login-shell setup. zsh reads $ZDOTDIR/.zprofile (not ~/.zprofile) once ZDOTDIR
# is set, so Homebrew is initialized here. Exported vars are inherited by any
# non-login child shells.

# Homebrew (macOS / Linuxbrew)
for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  [[ -x "$_brew" ]] && eval "$("$_brew" shellenv)" && break
done
unset _brew

# mise shims — expose managed tools (node, go, …) to non-interactive child
# processes such as editor-spawned LSP servers. `mise activate` in .zshrc only
# affects interactive shells, so LSPs launched by Neovim otherwise can't find
# `node` (jsonls/tailwindcss/vtsls fail with "env: node: No such file...").
[[ -d "$HOME/.local/share/mise/shims" ]] && export PATH="$HOME/.local/share/mise/shims:$PATH"

# vim:ft=zsh
