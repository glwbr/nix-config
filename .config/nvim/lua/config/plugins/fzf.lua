return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader>sf", "<cmd>FzfLua files<cr>", desc = "Search files" },
    { "<leader>sb", "<cmd>FzfLua buffers<cr>", desc = "Search buffers" },
    { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Search diagnostics" },
    { "<leader>s.", "<cmd>FzfLua oldfiles<cr>", desc = "Search recent files" },
    { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Grep (pattern -- --glob)" },
    { "<leader>s/", "<cmd>FzfLua lines<cr>", desc = "Search lines in open buffers" },
    { "<leader>sr", "<cmd>FzfLua resume<cr>", desc = "Resume last search" },
    { "<leader>/", "<cmd>FzfLua blines<cr>", desc = "Search current buffer" },
    {
      "<leader>sn",
      function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end,
      desc = "Search Neovim config",
    },
  },
  opts = {
    "telescope",
    files = { formatter = "path.filename_first" },
  },
}
