return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          path = "${3rd}/luv/library",
          words = { "vim%.uv" }
        },
      }
    },
    {
      "saghen/blink.cmp"
    }
  },
  opts = {
    servers = {
      lua_ls = {}
    },
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    for server, config in pairs(opts.servers) do
      config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
      lspconfig[server].setup(config)
    end
  end,
}
