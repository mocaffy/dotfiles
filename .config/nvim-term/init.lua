local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.opt.laststatus = 0
vim.opt.cmdheight = 0
vim.opt.clipboard = "unnamedplus"
vim.opt.fillchars = {
  eob = " ",
  vert = "▏"
},

vim.opt.fillchars:append("vert:▏")

-- タイトルの変更を有効にする
vim.opt.title = true

-- swapファイルを無効にする
vim.opt.swapfile = false

require("lazy").setup("plugins")

local ok, _ = pcall(vim.cmd, 'colorscheme nordfox')
if not ok then
  vim.cmd 'colorscheme default'
end

require("utils").set_mappings(require("mappings"))




vim.cmd([[
  augroup bigfiles
    " Clear the bigfiles group in case defined elsewhere
    autocmd!
    " Set autocommand to run before reading buffer
    autocmd BufReadCmd * silent call PromptFileEdit()
  augroup end



  " Prompt user input if editing an existing file before reading
  function! PromptFileEdit()
    " Current file
    let file = expand("%")
    let result = system("tmux send-keys -t 0 ':e " . file . "' Enter")
    
    
    bp!
    bd! #
  endfunction
]])



  local splitactive  = vim.api.nvim_create_namespace('splitactive')
  local splitinactive  = vim.api.nvim_create_namespace('splitinactive')

  -- Normal と NormalNC のハイライト設定を変数に代入
  local color_vertsplit = vim.api.nvim_get_hl_by_name("VertSplit", true)
  local color_vertsplit_nc = vim.api.nvim_get_hl_by_name("VertSplitNC", true)

  vim.api.nvim_set_hl(splitinactive, "VertSplit", { fg = color_vertsplit_nc.foreground, bg = color_vertsplit_nc.background })
  vim.api.nvim_set_hl(splitactive, "VertSplit", { fg = color_vertsplit.foreground, bg = color_vertsplit.background })

  vim.api.nvim_create_autocmd({ "WinLeave" }, {
    pattern = { "*" },
    callback = function()
      local leftside = tonumber(vim.api.nvim_command_output("echo win_getid(winnr('h'))"))
      if leftside ~= vim.api.nvim_get_current_win() then
        vim.api.nvim_win_set_hl_ns(leftside, splitinactive)
      end
    end
  })
  vim.api.nvim_create_autocmd({ "WinEnter", "WinNew" }, {
    pattern = { "*" },
    callback = function()
      local leftside = tonumber(vim.api.nvim_command_output("echo win_getid(winnr('h'))"))
      if leftside ~= vim.api.nvim_get_current_win() then
        vim.api.nvim_win_set_hl_ns(leftside, splitactive)
      end
    end
  })

-- フォーカスがターミナルウィンドウから離れたときにノーマルモードに切り替える
vim.cmd[[
  autocmd WinLeave,FocusLost * if &buftype == 'terminal' | stopinsert | endif
]]
