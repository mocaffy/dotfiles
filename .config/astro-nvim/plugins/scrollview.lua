-- スクロールバーを表示するプラグイン
return {
  "dstein64/nvim-scrollview",
  config = function()
    require("scrollview").setup({
      excluded_filetypes = { "nerdtree" },
      current_only = true,
      winblend = 80,
      column = 1,
    })
  end,
}
