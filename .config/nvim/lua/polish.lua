-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}

vim.cmd [[
  au WinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
]]

-- オレオレ WinSeparatorNC

local splitactive = vim.api.nvim_create_namespace "splitactive"
local splitinactive = vim.api.nvim_create_namespace "splitinactive"

-- Normal と NormalNC のハイライト設定を変数に代入
local color_normal = vim.api.nvim_get_hl_by_name("Normal", true)
local color_normal_nc = vim.api.nvim_get_hl_by_name("NormalNC", true)
local color_winbar = vim.api.nvim_get_hl_by_name("WinBar", true)
local color_winbar_nc = vim.api.nvim_get_hl_by_name("WinBarNC", true)

local color_vertsplit = vim.api.nvim_get_hl_by_name("WinSeparator", true)
local color_vertsplit_nc = vim.api.nvim_get_hl_by_name("WinSeparatorNC", true)

local set_color_config = function()
  splitactive = vim.api.nvim_create_namespace "splitactive"
  splitinactive = vim.api.nvim_create_namespace "splitinactive"

  -- Normal と NormalNC のハイライト設定を変数に代入
  color_normal = vim.api.nvim_get_hl_by_name("Normal", true)
  color_normal_nc = vim.api.nvim_get_hl_by_name("NormalNC", true)
  color_winbar = vim.api.nvim_get_hl_by_name("WinBar", true)
  color_winbar_nc = vim.api.nvim_get_hl_by_name("WinBarNC", true)

  color_vertsplit = vim.api.nvim_get_hl_by_name("WinSeparator", true)
  color_vertsplit_nc = vim.api.nvim_get_hl_by_name("WinSeparatorNC", true)

  vim.api.nvim_set_hl(
    splitinactive,
    "WinSeparator",
    { fg = color_vertsplit_nc.foreground, bg = color_vertsplit_nc.background }
  )
  vim.api.nvim_set_hl(splitactive, "WinSeparator", { fg = color_vertsplit.foreground, bg = color_vertsplit.background })
end

local update_left = function(active)
  local currentid = vim.api.nvim_get_current_win()
  local leftsideid = tonumber(vim.api.nvim_command_output "echo win_getid(winnr('h'))")
  if leftsideid ~= nil and leftsideid ~= currentid then
    local leftsidetype = vim.api.nvim_command_output "echo getbufvar(winbufnr(winnr('h')), '&filetype', 'unknown')"
    if leftsidetype == "neo-tree" then
      if active then
        vim.api.nvim_set_hl(
          0,
          "NeoTreeWinSeparator",
          { fg = color_vertsplit.foreground, bg = color_vertsplit.background }
        )
      else
        vim.api.nvim_set_hl(
          0,
          "NeoTreeWinSeparator",
          { fg = color_vertsplit_nc.foreground, bg = color_vertsplit_nc.background }
        )
      end
    else
      if active then
        vim.api.nvim_win_set_hl_ns(leftsideid, splitactive)
      else
        vim.api.nvim_win_set_hl_ns(leftsideid, splitinactive)
      end
    end
  end
  
  vim.api.nvim_set_hl(0, "WinSeparator", { fg = color_vertsplit_nc.foreground, bg = color_vertsplit_nc.background })
end

vim.api.nvim_create_autocmd({ "WinLeave" }, {
  pattern = { "*" },
  callback = function() update_left(false) end,
})

vim.api.nvim_create_autocmd({ "WinEnter", "WinNew" }, {
  pattern = { "*" },
  callback = function() update_left(true) end,
})

-- Neovim からフォーカスか外れた時に Normal の色を NormalNC にして
-- フォーカスが戻った時に Normal に戻す
vim.api.nvim_create_autocmd({ "FocusLost" }, {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { fg = color_normal_nc.foreground, bg = color_normal_nc.background })
    vim.api.nvim_set_hl(0, "WinBar", { fg = color_winbar_nc.foreground, bg = color_winbar_nc.background })
    update_left(false)
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained" }, {
  pattern = { "*" },
  callback = function()
    vim.api.nvim_set_hl(0, "Normal", { fg = color_normal.foreground, bg = color_normal.background })
    vim.api.nvim_set_hl(0, "WinBar", { fg = color_winbar.foreground, bg = color_winbar.background })
    update_left(true)
  end,
})

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  pattern = { "*" },
  callback = set_color_config,
})

set_color_config()
