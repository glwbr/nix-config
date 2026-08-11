return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  build = ":KanagawaCompile",
  opts = {
    compile = true,
    commentStyle = { italic = true },
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    background = { dark = "wave", light = "lotus" },
  },
  config = function(_, opts)
    require("kanagawa").setup(opts)
    vim.cmd.colorscheme("kanagawa")
  end,
}
