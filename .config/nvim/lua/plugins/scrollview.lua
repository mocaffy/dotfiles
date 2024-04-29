-- スクロールバーを表示するプラグイン
return {
  "dstein64/nvim-scrollview",
  -- enabled = false,
  config = function()
    require("scrollview").setup {
      excluded_filetypes = { "neo-tree" },
      current_only = true,
      -- base = "buffer",
      column = 1,
      signs_on_startup = { "all" },
      diagnostics_severities = { vim.diagnostic.severity.ERROR },
    }
  end,
}
