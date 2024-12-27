return {
  "saghen/blink.cmp",
  dependencies = "rafamadriz/friendly-snippets",
  enabled = true,
  version = "v0.8.2",
  opts = {
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "normal"
    },
    completion = {
      ghost_text = {
        enabled = true,
      },
      menu = {
        auto_show = function(ctx) return ctx.mode ~= 'cmdline' end
      },
    },
    keymap = { preset = "default" },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  },
}
