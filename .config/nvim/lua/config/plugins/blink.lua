return {
  "saghen/blink.cmp",
  version = "1.*",
  dependencies = "rafamadriz/friendly-snippets",
  event = "InsertEnter",
  opts = {
    keymap = { preset = "default" },
    appearance = { nerd_font_variant = "normal" },
    completion = { documentation = { auto_show = true } },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
