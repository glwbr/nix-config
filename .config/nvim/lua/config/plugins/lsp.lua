return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } },
      },
    },
  },
  config = function()
    vim.lsp.config("*", {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    vim.lsp.enable({ "lua_ls", "vtsls" })
  end,
}
