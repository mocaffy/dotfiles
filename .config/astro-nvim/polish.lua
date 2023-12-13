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

  
  winactive  = vim.api.nvim_create_namespace('winactive')
  wininactive  = vim.api.nvim_create_namespace('wininactive')
  splitactive  = vim.api.nvim_create_namespace('splitactive')
  splitinactive  = vim.api.nvim_create_namespace('splitinactive')

  -- Normal と NormalNC のハイライト設定を変数に代入
  color_normal = vim.api.nvim_get_hl_by_name("Normal", true)
  color_normal_nc = vim.api.nvim_get_hl_by_name("NormalNC", true)
  color_winbar = vim.api.nvim_get_hl_by_name("WinBar", true)
  color_winbar_nc = vim.api.nvim_get_hl_by_name("WinBarNC", true)

  color_vertsplit = vim.api.nvim_get_hl_by_name("VertSplit", true)
  color_vertsplit_nc = vim.api.nvim_get_hl_by_name("VertSplitNC", true)

  local set_color_config = function()
    winactive  = vim.api.nvim_create_namespace('winactive')
    wininactive  = vim.api.nvim_create_namespace('wininactive')
    splitactive  = vim.api.nvim_create_namespace('splitactive')
    splitinactive  = vim.api.nvim_create_namespace('splitinactive')

    -- Normal と NormalNC のハイライト設定を変数に代入
    color_normal = vim.api.nvim_get_hl_by_name("Normal", true)
    color_normal_nc = vim.api.nvim_get_hl_by_name("NormalNC", true)
    color_winbar = vim.api.nvim_get_hl_by_name("WinBar", true)
    color_winbar_nc = vim.api.nvim_get_hl_by_name("WinBarNC", true)

    color_vertsplit = vim.api.nvim_get_hl_by_name("VertSplit", true)
    color_vertsplit_nc = vim.api.nvim_get_hl_by_name("VertSplitNC", true)

    vim.api.nvim_set_hl(wininactive, "Normal", { fg = color_normal_nc.foreground, bg = color_normal_nc.background })
    vim.api.nvim_set_hl(wininactive, "NeoTreeNormal", { fg = color_normal_nc.foreground, bg = color_normal_nc.background })
    vim.api.nvim_set_hl(wininactive, "WinBar", { fg = color_winbar_nc.foreground, bg = color_winbar_nc.background })
    vim.api.nvim_set_hl(splitinactive, "VertSplit", { fg = color_vertsplit_nc.foreground, bg = color_vertsplit_nc.background })
    vim.api.nvim_set_hl(splitinactive, "NeoTreeWinSeparator", { fg = color_vertsplit_nc.foreground, bg = color_vertsplit_nc.background })

    vim.api.nvim_set_hl(winactive, "Normal", { fg = color_normal.foreground, bg = color_normal.background })
    vim.api.nvim_set_hl(winactive, "NeoTreeNormal", { fg = color_normal.foreground, bg = color_normal.background })
    vim.api.nvim_set_hl(winactive, "WinBar", { fg = color_winbar.foreground, bg = color_winbar.background })
    vim.api.nvim_set_hl(splitactive, "VertSplit", { fg = color_vertsplit.foreground, bg = color_vertsplit.background })
    vim.api.nvim_set_hl(splitactive, "NeoTreeWinSeparator", { fg = color_vertsplit.foreground, bg = color_vertsplit.background })
  end

  set_color_config()
 
  -- Neovim からフォーカスか外れた時に Normal の色を NormalNC にして
  -- フォーカスが戻った時に Normal に戻す
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
  vim.api.nvim_create_autocmd({ "FocusLost" }, {
    pattern = { "*" },
    callback = function()
      vim.api.nvim_set_hl(0, "Normal", { fg = color_normal_nc.foreground, bg = color_normal_nc.background })
      vim.api.nvim_set_hl(0, "WinBar", { fg = color_winbar_nc.foreground, bg = color_winbar_nc.background })
      vim.api.nvim_set_hl(0, "VertSplit", { fg = color_vertsplit_nc.foreground, bg = color_vertsplit_nc.background })
      local leftside = tonumber(vim.api.nvim_command_output("echo win_getid(winnr('h'))"))
      if leftside ~= vim.api.nvim_get_current_win() then
        vim.api.nvim_win_set_hl_ns(leftside, splitinactive)
      end
    end
  })
  vim.api.nvim_create_autocmd({ "FocusGained" }, {
    pattern = { "*" },
    callback = function()
      vim.api.nvim_set_hl(0, "Normal", { fg = color_normal.foreground, bg = color_normal.background })
      vim.api.nvim_set_hl(0, "WinBar", { fg = color_winbar.foreground, bg = color_winbar.background })
      vim.api.nvim_set_hl(0, "VertSplit", { fg = color_vertsplit.foreground, bg = color_vertsplit.background })
      local leftside = tonumber(vim.api.nvim_command_output("echo win_getid(winnr('h'))"))
      if leftside ~= vim.api.nvim_get_current_win() then
        vim.api.nvim_win_set_hl_ns(leftside, splitactive)
      end
    end
  })
  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    pattern = { "*" },
    callback = set_color_config
  })
  -- vim.api.nvim_create_autocmd({ "FocusLost" }, {
  --   pattern = { "*" },
  --   callback = function()
  --     vim.api.nvim_win_set_hl_ns(0, wininactive)
  --   end
  -- })
  -- vim.api.nvim_create_autocmd({ "FocusGained" }, {
  --   pattern = { "*" },
  --   callback = function()
  --     vim.api.nvim_win_set_hl_ns(0, winactive)
  --   end
  -- })
  --
  local id = vim.api.nvim_create_augroup("startup", {
    clear = false
  })
  
  local persistbuffer = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    vim.fn.setbufvar(bufnr, 'bufpersist', 1)
  end

  local cleanbuffer = function()
    local curbufnr = vim.api.nvim_get_current_buf()
    local buflist = vim.api.nvim_list_bufs()
    for _, bufnr in ipairs(buflist) do
      if vim.bo[bufnr].buflisted and bufnr ~= curbufnr and (vim.fn.getbufvar(bufnr, 'bufpersist') ~= 1) then
        vim.cmd('bd ' .. tostring(bufnr))
      end
    end
  end
  
  vim.api.nvim_create_autocmd({"BufRead"}, {
    group = id,
    pattern = {"*"},
    callback = function()
      vim.api.nvim_create_autocmd({"InsertEnter","BufModifiedSet"}, {
        buffer = 0,
        once = true,
        callback = function()
          persistbuffer()
        end
      })
    end
  })

  vim.api.nvim_create_autocmd({"BufRead"}, {
    group = id,
    pattern = {"*"},
    callback = function()
      cleanbuffer()
    end
  })

  vim.keymap.set('n', '<Leader>bx', cleanbuffer, { silent = true, desc = 'Close unused buffers' })

  if vim.env.TMUX then
    vim.g.clipboard = {
      name = 'tmux',
      copy = {
        ["+"] = {'tmux', 'load-buffer', '-w', '-'},
        ["*"] = {'tmux', 'load-buffer', '-w', '-'},
      },
      paste = {
        ["+"] = {'tmux', 'save-buffer', '-'},
        ["*"] = {'tmux', 'save-buffer', '-'},
      },
      cache_enabled = false,
    }
  end
end
