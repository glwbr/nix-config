return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local setup = require("nvim-treesitter.configs").setup
    setup({
      ensure_installed = {
        "bash",
        "dockerfile",
        "go",
        "hyprlang",
        "javascript",
        "jsdoc",
        "json",
        "lua",
        "nginx",
        "nix",
        "tmux",
        "typescript",
        "tsx",
        "vue",
        "yaml"
      },
      auto_install = false,
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 100 * 1024
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = true,
      },
    })
  end,
}
