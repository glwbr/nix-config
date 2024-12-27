return {
  {
    "rebelot/kanagawa.nvim",
    build = ":KanagawaCompile",
    enabled = true,
    opts = {
      compile = true,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = false,
      dimInactive = false,
      terminalColors = true,
      background = {
        dark = "wave",
        light = "lotus"
      },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd("colorscheme kanagawa")
    end
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    enabled = false,
    opts = {
      variant = "moon",
      styles = {
        bold = true,
        italic = false,
        transparency = false,
      },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)
      vim.cmd("colorscheme rose-pine")
    end
  }
}
