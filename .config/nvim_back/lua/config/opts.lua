local opt = vim.opt

-- UI and Display
opt.cursorline = true                       -- Highlight current line
opt.number = true                           -- Show line numbers
opt.relativenumber = true                   -- Show relative line numbers
opt.scrolloff = 8                           -- Lines to keep above and below cursor
opt.colorcolumn = "120"                     -- Show column marker at 120 characters
opt.cmdheight = 0                           -- Minimize command line height
opt.laststatus = 3                          -- Always show the status line
opt.signcolumn = "yes"                      -- Always show the sign column
opt.showmode = false                        -- Disable mode display in command line
opt.termguicolors = true                    -- Enable true color support

-- Search & Case Sensitivity
opt.ignorecase = true                       -- Ignore case in search patterns
opt.smartcase = true                        -- Override ignorecase if search contains uppercase
opt.grepformat = "%f:%l:%c:%m"              -- Format for 'grep' results
opt.grepprg = "rg --vimgrep"                -- Use ripgrep for searching

-- File Handling
opt.backup = false                          -- Disable backup files
opt.swapfile = false                        -- Disable swap files
opt.encoding = "utf-8"                      -- Set file encoding
opt.fileencoding = "utf-8"                  -- Set file encoding (for reading/writing files)
opt.undofile = true                         -- Enable undo file persistence
opt.undolevels = 10000                      -- Set the number of undo levels

-- Completion & Popup Menu
opt.completeopt = "menu,menuone,noselect"   -- Configure completion options
opt.pumblend = 10                           -- Set popup menu transparency
opt.pumheight = 10                          -- Limit popup menu height

-- Indentation & Tab Settings
opt.tabstop = 4                             -- Set the number of spaces for a tab
opt.shiftwidth = 4                          -- Set indentation width
opt.softtabstop = 4                         -- Set soft tab width
opt.expandtab = true                        -- Use spaces instead of tabs

-- Split & Window Management
opt.splitright = true                       -- Split windows to the right
opt.splitbelow = true                       -- Split windows below
opt.splitkeep = "screen"                    -- Keep split windows' screen position

-- Timeouts & Updates
opt.timeoutlen = 1000                       -- Set timeout length for key sequences
opt.updatetime = 200                        -- Set time to wait before triggering events

-- Line Wrapping
opt.wrap = false                            -- Disable line wrapping

-- Session & Persistent Settings
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
