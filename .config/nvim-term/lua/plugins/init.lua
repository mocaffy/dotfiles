return {
  -- 行単位でコミットできるプラグイン
  {
    "TimUntersberger/neogit",
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require("neogit").setup()
    end,
  },

  {
    "mrjones2014/smart-splits.nvim",
    opts = { ignored_filetypes = { "nofile", "quickfix", "qf", "prompt" }, ignored_buftypes = { "nofile" } },
  },
}

