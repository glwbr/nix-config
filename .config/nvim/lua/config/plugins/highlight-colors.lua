return {
  "brenoprata10/nvim-highlight-colors",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    render = "virtual",
    virtual_symbol = "󱓻",
    virtual_symbol_position = "eol",
    enable_tailwind = true,
  },
}
