vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = true
  opts.silent = opts.silent == nil and true or opts.silent
  vim.keymap.set(mode, lhs, rhs, opts)
end

map("n", "<leader>pv", vim.cmd.Ex, { desc = "Open File Explorer" })
map("n", "<leader><leader>", function() vim.cmd("source %") end, { desc = "Source Current File" })

map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<leader>d", "\"_d", { desc = "Delete (no clipboard)" })
map("v", "<leader>d", "\"_d", { desc = "Delete (no clipboard)" })

map("n", "<leader>y", "\"+y", { desc = "Yank to clipboard" })
map("v", "<leader>y", "\"+y", { desc = "Yank to clipboard" })
map("n", "<leader>Y", "\"+Y", { desc = "Yank Line to clipboard" })

map("x", "<leader>p", "\"_dP", { desc = "Paste over selection (no clipboard)" })

map("n", "<Q>", "<nop>", { desc = "Disable Q" })
map("n", "<Up>", "<nop>", { desc = "Disable Up Arrow" })
map("n", "<Down>", "<nop>", { desc = "Disable Down Arrow" })
map("n", "<Left>", "<nop>", { desc = "Disable Left Arrow" })
map("n", "<Right>", "<nop>", { desc = "Disable Right Arrow" })

map("n", "J", "mzJ`z", { desc = "Join Lines" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })
