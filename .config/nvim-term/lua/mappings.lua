local maps = { i = {}, n = {}, v = {}, t = {} }

-- Smart Splits
if require("utils").is_available "smart-splits.nvim" then
  maps.n["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  maps.n["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  maps.n["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  maps.n["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
  maps.n["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
  maps.n["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
  maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
  maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }

  maps.t["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  maps.t["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  maps.t["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  maps.t["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
  maps.t["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
end

-- ウィンドウの拡大
maps.n["<Leader>z"] = { "<Cmd>WindowsMaximize<CR>", desc = "Maximize window" }
-- Neogit を開く
maps.n["<Leader>gn"] = { "<Cmd>Neogit<CR>", desc = "Neogit" }

maps.n["<Leader>ttr"] = { "<Cmd>call system('tmux respawn-pane -k')<CR>", desc = "Restart Neovim" }

maps.n["<Leader>s"] = { "<Cmd>BrowserSearch<CR>", desc = "Browser Search" }
maps.v["<Leader>s"] = { "<Cmd>BrowserSearch<CR>", desc = "Browser Search" }

return maps
