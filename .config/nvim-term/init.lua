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

-- タイトルの変更を有効にする
vim.opt.title = true

-- swapファイルを無効にする
vim.opt.swapfile = false

require("lazy").setup("plugins")

local ok, _ = pcall(vim.cmd, 'colorscheme ayu-mirage')
if not ok then
  vim.cmd 'colorscheme default'
end

require("utils").set_mappings(require("mappings"))


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
vim.api.nvim_create_autocmd({ "FocusGained" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd "call system('issw com.apple.keylayout.ABC')"
  end
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd "call system('issw com.apple.keylayout.ABC')"
  end
})

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
