return {
  lsp = {
    skip_setup = {
      "denols",
      "tsserver"
    },
    formatting = {
      format_on_save = false, -- enable or disable automatic formatting on save
    },
    ["server-settings"] = {
      -- denoとtsserverが干渉しないように
      -- https://astronvim.github.io/Recipes/advanced_lsp#deno-deno-nvim
      denols = {
        root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
      },
      tsserver = {
        root_dir = require("lspconfig.util").root_pattern("package.json"),
        single_file_support = false
      },
    },
  },
}
