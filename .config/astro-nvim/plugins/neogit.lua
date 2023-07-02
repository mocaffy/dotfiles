  -- 行単位でコミットできるプラグイン
return {
  "TimUntersberger/neogit",
  dependencies = 'nvim-lua/plenary.nvim',
  -- enabled = false,
  config = function()
    require("neogit").setup({
    })
    vim.cmd([[
      augroup DefaultRefreshEvents
        au!
        au FocusGained * lua require('neogit').dispatch_refresh(true)
      augroup END
    ]])
  end,
}
