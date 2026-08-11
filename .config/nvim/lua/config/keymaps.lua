vim.g.mapleader = " "

local map = vim.keymap.set

-- <leader>pv and - open oil; see plugins/oil.lua
map("n", "<leader><leader>", "<cmd>source %<cr>", { desc = "Source current file" })

-- Windows
map("n", "<leader>-", "<C-w>s", { desc = "Split below" })
map("n", "<leader>|", "<C-w>v", { desc = "Split right" })
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Keep the cursor put
map("n", "n", "nzzzv", { desc = "Next search result" })
map("n", "N", "Nzzzv", { desc = "Prev search result" })
map("n", "J", "mzJ`z", { desc = "Join lines" })

-- Stay in visual mode when shifting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Black-hole register, so a delete/paste doesn't clobber the yank
map({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete (no clipboard)" })
map("x", "<leader>p", '"_dP', { desc = "Paste over selection" })

-- System clipboard
map({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank line to clipboard" })

map("n", "<esc>", "<cmd>noh<cr>", { desc = "Clear search highlight" })

-- Break the arrow-key habit
for _, key in ipairs({ "<Up>", "<Down>", "<Left>", "<Right>" }) do
  map("n", key, "<nop>")
end
map("n", "Q", "<nop>")
