local biome_cache = {}

local function mise_biome(filename)
  local dir = filename and vim.fs.dirname(filename)
  if not dir or dir == "" then
    return nil
  end
  if biome_cache[dir] == nil then
    local res = vim.system({ "mise", "which", "biome" }, { cwd = dir, text = true }):wait()
    biome_cache[dir] = res.code == 0 and vim.trim(res.stdout) or false
  end
  return biome_cache[dir] or nil
end

return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>f",
      function() require("conform").format({ async = true }) end,
      mode = { "n", "v" },
      desc = "Format buffer/selection",
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { "biome-check" },
      javascriptreact = { "biome-check" },
      typescript = { "biome-check" },
      typescriptreact = { "biome-check" },
      json = { "biome-check" },
      jsonc = { "biome-check" },
      css = { "biome-check" },
      lua = { "stylua" },
    },
    formatters = {
      ["biome-check"] = {
        command = function(_, ctx) return mise_biome(ctx.filename) or "biome" end,
        condition = function(_, ctx) return mise_biome(ctx.filename) ~= nil end,
      },
    },
    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 1000, lsp_format = "never" }
    end,
  },
  init = function()
    vim.api.nvim_create_user_command("FormatDisable", function(args)
      if args.bang then
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, { bang = true, desc = "Disable format-on-save (! = this buffer only)" })

    vim.api.nvim_create_user_command("FormatEnable", function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { desc = "Re-enable format-on-save" })
  end,
}
