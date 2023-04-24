return {
  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  lsp = {
    skip_setup = {
      "denols",
      "tsserver"
    },
    formatting = {
      format_on_save = false, -- enable or disable automatic formatting on save
    },
    -- ["server-settings"] = {
    --   -- denoとtsserverが干渉しないように
    --   -- https://astronvim.github.io/Recipes/advanced_lsp#deno-deno-nvim
    --   denols = {
    --     root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
    --   },
    --   tsserver = {
    --     root_dir = require("lspconfig.util").root_pattern("package.json"),
    --     single_file_support = false
    --   },
    -- },
  },
}
