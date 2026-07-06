# Homebrew bundle for macOS — install everything with `brew bundle --file ~/nix-config/Brewfile`
# (the bootstrap script does this for you). Mirrors the CLI tools declared in
# packages/*.packages, using their macOS/Homebrew formula names.

# Shell + prompt
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"
brew "zsh-completions"      # extra completion definitions (added to fpath)
brew "pure"                 # prompt theme (adds prompt_pure to fpath)

# Runtime/version manager (replaces asdf)
brew "mise"

# Core CLI the aliases/functions depend on
brew "eza"                  # ls replacement
brew "bat"                  # cat replacement
brew "fd"                   # find replacement
brew "ripgrep"              # grep (rg)
brew "fzf"                  # fuzzy finder
brew "dust"                 # du replacement
brew "procs"                # ps replacement
brew "bottom"              # top/btop/htop -> btm
brew "yazi"                 # file manager (fm)
brew "git-delta"            # git diff pager
brew "git-lfs"              # large-file storage (repo tracks images via LFS)
brew "jq"                   # JSON processor
brew "neovim"               # editor
brew "yt-dlp"               # ytmp3 alias
brew "gnupg"                # gpg (GPG_TTY in .zshrc)

# Archive tools used by the extract() function
brew "p7zip"                # 7z (also handles many .rar archives)
brew "cabextract"
# Note: `unrar` is no longer in Homebrew core (licensing). If you need real RAR
# support for extract(), install it from a tap, e.g.:
#   brew install carlocab/personal/unrar
