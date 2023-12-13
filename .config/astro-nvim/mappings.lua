-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

local utils = require "astronvim.utils"
local toggle_term_cmd = utils.toggle_term_cmd


return {
  -- first key is the mode
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
    ["<Leader>gn"] = { function() require('neogit').open({ kind = "vsplit" }) end, desc = "Neogit" },
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
