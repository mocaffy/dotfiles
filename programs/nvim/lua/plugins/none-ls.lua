---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"

    opts.sources = require("astrocore").list_insert_unique(opts.sources, {
      null_ls.builtins.formatting.prettierd.with {
        condition = function(utils) return not utils.root_has_file "biome.json" end,
      },
    })
  end,
}
