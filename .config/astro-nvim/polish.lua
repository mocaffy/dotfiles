-- This function is run last and is a good place to configuring
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here
return function()
  -- Set up custom filetypes
  -- vim.filetype.add {
  --   extension = {
  --     foo = "fooscript",
  --   },
  --   filename = {
  --     ["Foofile"] = "fooscript",
  --   },
  --   pattern = {
  --     ["~/%.config/foo/.*"] = "fooscript",
  --   },
  -- }

  -- タイトルの変更を有効にする
  vim.opt.title = true

  -- swapファイルを無効にする
  vim.opt.swapfile = false

  -- 不可視な文字の設定
  vim.opt.list = true
  vim.opt.listchars = {
    tab = '»-',
    trail = '-',
    eol = '↲',
    extends = '»',
    precedes = '«',
    nbsp = '%',
    space = '･',
  }

  -- Normal と NormalNC のハイライト設定を変数に代入
  local color_normal = vim.api.nvim_get_hl_by_name("Normal", true)
  local color_normal_nc = vim.api.nvim_get_hl_by_name("NormalNC", true)

  -- Neovim からフォーカスか外れた時に Normal の色を NormalNC にして
  -- フォーカスが戻った時に Normal に戻す
  vim.api.nvim_create_autocmd({ "FocusLost" }, {
    pattern = { "*" },
    callback = function()
      vim.api.nvim_set_hl(0, "Normal", { fg = color_normal_nc.foreground, bg = color_normal_nc.background })
    end
  })
  vim.api.nvim_create_autocmd({ "FocusGained" }, {
    pattern = { "*" },
    callback = function()
      vim.api.nvim_set_hl(0, "Normal", { fg = color_normal.foreground, bg = color_normal.background })
    end
  })
end
