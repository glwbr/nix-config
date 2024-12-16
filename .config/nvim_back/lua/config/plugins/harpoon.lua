return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup()
    local conf = require("telescope.config").values

    local function toggle_telescope(harpoon_files)
      local file_paths = {}

      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
        theme = "dropdown",
        layout_config = {
          height = 0.3,
        },
      }):find()
    end

    vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
    vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end, { desc = "Harpoon Quick Menu" })

    vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end, { desc = "Goto Harpoon File 1" })
    vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end, { desc = "Goto Harpoon File 2" })
    vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end, { desc = "Goto Harpoon File 3" })
    vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end, { desc = "Goto Harpoon File 4" })

    vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
  end,
}
