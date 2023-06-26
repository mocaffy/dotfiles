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
  {
    "voldikss/vim-browser-search",
    config = function()
      vim.g.browser_search_builtin_engines = {
        ["google"] = "https://google.com/search?q=%s",
        ["appgrep"]= "https://grep.app/search?q=%s",
      }
    end,
  },
  {
    "voldikss/vim-translator",
    config = function()
      vim.g.translator_target_lang = 'ja'
      vim.g.translator_default_engines = { 'google' }
    end,
  }
}

