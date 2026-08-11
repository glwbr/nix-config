return {
  "stevearc/oil.nvim",
  lazy = false,
  opts = {
    default_file_explorer = true,
    view_options = { show_hidden = true },
    keymaps = {
      ["<C-h>"] = false,
      ["<C-l>"] = false,
    },
  },
  keys = {
    { "<leader>pv", "<cmd>Oil<cr>", desc = "File explorer" },
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
  },
}
