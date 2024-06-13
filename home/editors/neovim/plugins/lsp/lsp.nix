_: {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;

        keymaps = {
          silent = true;
        };

        servers = {
          bashls.enable = true;
          clangd.enable = true;
          dockerls.enable = true;
          elixirls.enable = true;
          eslint.enable = true;
          gopls.enable = true;
          htmx.enable = true;
          jsonls.enable = true;
          lua-ls = {
            enable = true;
            extraOptions = {
              settings = {
                Lua = {
                  completion = {
                    callSnippet = "Replace";
                  };
                  hint.enable = true;
                  telemetry.enabled = false;
                };
              };
            };
          };
          intelephense.enable = true;
          nil-ls.enable = true;
          #tsserver.enable = true;
          yamlls.enable = true;
        };
      };
    };
  };
}
