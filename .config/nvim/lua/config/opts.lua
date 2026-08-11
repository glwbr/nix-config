local opt = vim.opt

-- UI
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.colorcolumn = "120"
opt.cmdheight = 0
opt.laststatus = 3 -- one global statusline
opt.signcolumn = "yes" -- always reserved, so text doesn't jump
opt.showmode = false
opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true -- ...unless the pattern has uppercase
opt.grepprg = "rg --vimgrep"
opt.grepformat = "%f:%l:%c:%m"

-- Files
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000

-- Indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true

-- Splits
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"

-- Timing
opt.timeoutlen = 500
opt.updatetime = 200

-- Popup menu height; the rest of completion is blink's business
opt.pumheight = 10
