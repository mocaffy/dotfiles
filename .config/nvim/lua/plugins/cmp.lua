return { -- override nvim-cmp plugin
  "hrsh7th/nvim-cmp",
  dependencies = {
    "zbirenbaum/copilot-cmp", -- add cmp source as dependency of cmp
  },
  -- override the options table that is used in the `require("cmp").setup()` call
  opts = function(_, opts)
    -- opts parameter is the default options table
    -- the function is lazy loaded so cmp is able to be required
    local cmp = require "cmp"
    -- modify the sources part of the options table
    opts.sources = cmp.config.sources {
      -- Copilot Source
      { name = "copilot", group_index = 2 },
      -- Other Sources
      { name = "nvim_lsp", group_index = 2 },
      { name = "path", group_index = 2 },
      { name = "luasnip", group_index = 2 },
    }
    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
    end
    -- opts.mapping = cmp.config.mapping {
    --   ["<Tab>"] = vim.schedule_wrap(function(fallback)
    --     if cmp.visible() and has_words_before() then
    --       cmp.confirm { select = true }
    --     else
    --       fallback()
    --     end
    --   end),
    -- }
  end,
}
