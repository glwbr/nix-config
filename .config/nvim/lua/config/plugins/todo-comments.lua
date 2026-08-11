return {
  "folke/todo-comments.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    signs = false,
    merge_keywords = false,
    keywords = {
      TODO = { icon = " ", color = "info" },
      FIX = { icon = " ", color = "error", alt = { "FIXME" } },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning" },
      PERF = { icon = " ", color = "default" },
      NOTE = { icon = " ", color = "hint" },
    },
  },
  keys = {
    { "<leader>st", "<cmd>TodoFzfLua<cr>", desc = "Search TODOs" },
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
  },
}
