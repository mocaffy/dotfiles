-- スクロールバーを表示するプラグイン
return {
  "dstein64/nvim-scrollview",
  -- enabled = false,
  config = function()
    require("scrollview").setup({
      excluded_filetypes = { "neo-tree" },
      current_only = true,
      winblend = 70,
      column = 1,
    })
  end,
}
