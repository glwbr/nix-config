local map = vim.keymap.set

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
    --'nvim-telescope/telescope-ui-select.nvim'
  },

  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = { require('telescope.themes').get_dropdown() },
      },
      pickers = {
        current_buffer_fuzzy_find = {
          theme = "dropdown",
          winblend = 10,
          previewer = false,
        },
        extensioons = {
          fzf = {}
        }
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    local builtin = require('telescope.builtin')

    map('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    map('n', '<leader>sb', builtin.buffers, { desc = '[ ] Find existing buffers' })
    map('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    map('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    map('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer' })
    map('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    map('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config',
        prompt_title = 'Neovim Files'
      }
    end, { desc = '[S]earch [N]eovim files' })

    require "config.plugins.telescope.multigrep".setup()
  end
}
