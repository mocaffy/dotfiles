-- file: modern_win_separator.lua (例)

local M = {}

-- Namespace の定義
local NS_ACTIVE = vim.api.nvim_create_namespace("splitactive")
local NS_INACTIVE = vim.api.nvim_create_namespace("splitinactive")

-- ハイライト情報格納用テーブル
local hl_colors = {
  normal    = {},
  normal_nc = {},
  winbar    = {},
  winbar_nc = {},
  winsep    = {},
  winsep_nc = {},
}

--- 指定した group にハイライトを設定するヘルパー
---@param namespace number 0 または Namespace ID
---@param group string ハイライトグループ名
---@param color table { fg = ..., bg = ... }
local function set_hl(namespace, group, color)
  vim.api.nvim_set_hl(namespace, group, {
    fg = color.fg,
    bg = color.bg,
  })
end

--- カラースキームが変わったときにハイライトを再取得＆設定する
local function set_color_config()
  -- 新しい API: nvim_get_hl(0, { name = "GroupName" })
  -- 返り値は { fg = <number>, bg = <number>, ... } のようなテーブル
  hl_colors.normal    = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  hl_colors.normal_nc = vim.api.nvim_get_hl(0, { name = "NormalNC", link = false })
  hl_colors.winbar    = vim.api.nvim_get_hl(0, { name = "WinBar", link = false })
  hl_colors.winbar_nc = vim.api.nvim_get_hl(0, { name = "WinBarNC", link = false })
  hl_colors.winsep    = vim.api.nvim_get_hl(0, { name = "WinSeparator", link = false })
  hl_colors.winsep_nc = vim.api.nvim_get_hl(0, { name = "WinSeparatorNC", link = false })

  -- Namespace 用ハイライト (WinSeparator のみ)
  set_hl(NS_ACTIVE,   "WinSeparator", hl_colors.winsep)
  set_hl(NS_INACTIVE, "WinSeparator", hl_colors.winsep_nc)
end

--- 左側ウィンドウのハイライトを更新する
---@param active boolean アクティブウィンドウかどうか
local function update_left(active)
  local current_win = vim.api.nvim_get_current_win()
  -- 古い nvim_command_output("echo win_getid(winnr('h'))") を置き換え
  local left_win = vim.fn.win_getid(vim.fn.winnr("h"))  -- 0 はウィンドウが存在しない場合

  if left_win ~= 0 and left_win ~= current_win then
    -- 古い nvim_command_output("echo getbufvar(winbufnr(...), '&filetype')") を置き換え
    local left_ft = vim.fn.getbufvar(vim.fn.winbufnr(vim.fn.winnr("h")), "&filetype", "unknown")

    if left_ft == "neo-tree" then
      -- Neo-Tree の WinSeparator
      local color = active and hl_colors.winsep or hl_colors.winsep_nc
      set_hl(0, "NeoTreeWinSeparator", color)
    else
      -- 通常のスプリットの場合は Namespace を切り替え
      local ns = active and NS_ACTIVE or NS_INACTIVE
      vim.api.nvim_win_set_hl_ns(left_win, ns)
    end
  end

  -- 現在ウィンドウの WinSeparator は常に非アクティブ色に
  set_hl(0, "WinSeparator", hl_colors.winsep_nc)
end

--- フォーカスが外れた際のハイライト
local function focus_lost()
  set_hl(0, "Normal",  hl_colors.normal_nc)
  set_hl(0, "WinBar",  hl_colors.winbar_nc)
  update_left(false)
end

--- フォーカスが戻った際のハイライト
local function focus_gained()
  set_hl(0, "Normal", hl_colors.normal)
  set_hl(0, "WinBar", hl_colors.winbar)
  update_left(true)
end

--- autocmd を一括で登録
local function setup_autocmds()
  vim.api.nvim_create_autocmd("WinLeave", {
    pattern = "*",
    callback = function()
      update_left(false)
    end,
  })

  vim.api.nvim_create_autocmd({ "WinEnter", "WinNew" }, {
    pattern = "*",
    callback = function()
      update_left(true)
    end,
  })

  vim.api.nvim_create_autocmd("FocusLost", {
    pattern = "*",
    callback = focus_lost,
  })

  vim.api.nvim_create_autocmd("FocusGained", {
    pattern = "*",
    callback = focus_gained,
  })

  vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = set_color_config,
  })
end

--- エントリポイント
function M.setup()
  set_color_config()
  setup_autocmds()
end

return M
