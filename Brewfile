# brew bundle --file ~/workspace/nix-config/Brewfile

# Shell
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"
brew "zsh-completions"
brew "pure"

# CLI
brew "eza"
brew "bat"
brew "fd"
brew "ripgrep"
brew "fzf"
brew "zoxide"
brew "mise"

# Editor
brew "neovim"
brew "tree-sitter-cli"      # nvim-treesitter's main branch shells out to `tree-sitter`
                            # to compile parsers; without it every install fails
brew "vtsls"                # TypeScript/JavaScript language server
brew "lua-language-server"  # lua_ls, for editing this Neovim config
brew "stylua"               # conform's Lua formatter
brew "biome"                # NOT used by Neovim (it resolves biome per-project);
                            # hire-be/hire-fe `pnpm format` scripts call bare
                            # `biome`, so they need it on PATH

# Git
brew "gh"
brew "git-lfs"      # .gitconfig sets filter.lfs.required, so git breaks without it

# Project tooling
brew "railway"
brew "supabase"
brew "jira-cli"

cask "claude-code"
