return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup()

    require("nvim-treesitter").install({ "javascript", "typescript", "tsx", "json" })

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("glwbr_treesitter", { clear = true }),
      callback = function(ev) pcall(vim.treesitter.start, ev.buf) end,
    })
  end,
}
