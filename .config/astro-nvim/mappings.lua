local is_available = astronvim.is_available
local toggle_term_cmd = astronvim.toggle_term_cmd

local maps = {
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
    ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
    ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
    -- ウィンドウの拡大
    ["<Leader>z"] = { "<Cmd>WindowsMaximize<CR>", desc = "Maximize window" },
    -- Neogit を開く
    ["<Leader>gn"] = { "<Cmd>Neogit<CR>", desc = "Neogit" },
    -- Tmux
    ["<Leader>ttks"] = { "<Cmd>call system('tmux kill-session')<CR>", desc = "Kill Session" },
    ["<Leader>ttkww"] = { "<Cmd>call system('tmux kill-window')<CR>", desc = "Kill Window" },
    ["<Leader>ttd"] = { "<Cmd>call system('tmux detach')<CR>", desc = "Detach Session" },
    ["<Leader>ttr"] = { "<Cmd>call system('tmux respawn-pane -k')<CR>", desc = "Restart Neovim" },
    ["<leader>ttn"] = { function() toggle_term_cmd "~/dotfiles/.bin/peco-src.sh" end, desc = "Open Workspace" },
    ["<leader>fj"] = { function() toggle_term_cmd "vifm" end, desc = "Open Vifm" },
    -- ["<leader>tf"] = { "<Cmd>call system('tmux popup -h 90% -w 90% -d '.getcwd())<CR>", desc = "ToggleTerm float" },
    -- ["<leader>tl"] = { "<Cmd>call system('tmux popup -h 90% -w 90% -d'.getcwd().' -E \"export XDG_CONFIG_HOME=$HOME/.config ; lazygit\"')<CR>", desc = "ToggleTerm lazygit" },
    -- ["<leader>gg"] = { "<Cmd>call system('tmux popup -h 90% -w 90% -d'.getcwd().' -E \"export XDG_CONFIG_HOME=$HOME/.config ; lazygit\"')<CR>", desc = "ToggleTerm lazygit" },
    ["<leader>gC"] = { function() toggle_term_cmd "gitmoji -c" end, desc = "Gitmoji Commit" },
    ["<Leader>fr"] = { "<Cmd>Telescope frecency<CR>", desc = "Telescope Frecency" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    ["<esc>"] = false,
  },
}
-- Smart Splits
if is_available "smart-splits.nvim" then
  -- Better window navigation
  -- maps.n["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  -- maps.n["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  -- maps.n["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  -- maps.n["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }

  -- Resize with arrows
  maps.n["<C-Up>"] = false
  maps.n["<C-Down>"] = false
  -- maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
  -- maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
else
  -- maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
  -- maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
  -- maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
  -- maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }
  maps.n["<C-Up>"] = false
  maps.n["<C-Down>"] = false
  -- maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
  -- maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }
end
return maps
