return {
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
    ["<Leader>ttk"] = { "<Cmd>call system('tmux kill-session')<CR>", desc = "Kill Session" },
    ["<Leader>ttd"] = { "<Cmd>call system('tmux detach')<CR>", desc = "Detach Session" },
    ["<Leader>ttr"] = { "<Cmd>call system('tmux respawn-pane -k')<CR>", desc = "Restart Neovim" },
    ["<leader>tf"] = { "<Cmd>call system('tmux popup -h 90% -w 90% -d '.getcwd())<CR>", desc = "ToggleTerm float" },
    ["<leader>tl"] = { "<Cmd>call system('tmux popup -h 90% -w 90% -d'.getcwd().' -E \"lazygit\"')<CR>", desc = "ToggleTerm lazygit" },
    ["<leader>gg"] = { "<Cmd>call system('tmux popup -h 90% -w 90% -d'.getcwd().' -E \"lazygit\"')<CR>", desc = "ToggleTerm lazygit" },
    ["<Leader>fr"] = { "<Cmd>Telescope frecency<CR>", desc = "Telescope Frecency" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  },
  t = {
    -- setting a mapping to false will disable it
    ["<esc>"] = false,
  },
}
