return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost", "InsertLeave" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint" },
      javascriptreact = { "eslint" },
      typescript = { "eslint" },
      typescriptreact = { "eslint" },
    }

    local function project_eslint(bufnr)
      local root = vim.fs.root(bufnr, { "package.json" })
      if not root then
        return nil
      end
      local bin = root .. "/node_modules/.bin/eslint"
      return vim.uv.fs_stat(bin) and bin or nil
    end

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("glwbr_lint", { clear = true }),
      callback = function(ev)
        local linters = lint.linters_by_ft[vim.bo[ev.buf].filetype]
        if not linters then
          return
        end

        if vim.tbl_contains(linters, "eslint") then
          local bin = project_eslint(ev.buf)
          if not bin then
            return
          end
          lint.linters.eslint.cmd = bin
        end

        lint.try_lint()
      end,
    })
  end,
}
