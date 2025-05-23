-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        fileformat = "unix",
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        fillchars = {
          eob = " ",
          vert = "▏",
        },
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Configuration table of session options for AstroNvim's session management powered by Resession
    sessions = {
      -- Configure auto saving
      autosave = {
        last = true, -- auto save last session
        cwd = true, -- auto save session for each working directory
      },
      -- Patterns to ignore when saving sessions
      ignore = {
        dirs = {}, -- working directories to ignore sessions in
        filetypes = { "gitcommit", "gitrebase" }, -- filetypes to ignore sessions
        buftypes = {}, -- buffer types to ignore sessions
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        ["<Leader>c"] = false,
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        L = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        H = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
        ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
        ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },

        -- ウィンドウの拡大
        ["<Leader>z"] = { "<Cmd>WindowsMaximize<CR>", desc = "Maximize window" },

        -- Neogit を開く
        ["<Leader>gn"] = { function() require("neogit").open { kind = "vsplit" } end, desc = "Neogit" },

        -- Tmux
        ["<Leader>tt"] = { desc = "Tmux" },
        ["<Leader>ttks"] = { "<Cmd>call system('tmux kill-session')<CR>", desc = "Kill Session" },
        ["<Leader>ttkw"] = { "<Cmd>call system('tmux kill-window')<CR>", desc = "Kill Window" },
        ["<Leader>ttd"] = { "<Cmd>call system('tmux detach')<CR>", desc = "Detach Session" },
        ["<Leader>ttr"] = { "<Cmd>call system('tmux respawn-pane -k')<CR>", desc = "Restart Neovim" },
        ["<Leader>ttz"] = { "<Cmd>call system('tmux resize-pane -Z')<CR>", desc = "Toggle Maximize" },
        ["<leader>ttn"] = {
          function() require("astrocore").toggle_term_cmd "~/dotfiles/.bin/peco-src.sh" end,
          desc = "Open Workspace",
        },

        -- nnn
        -- ["<leader>E"] = { function() require("astrocore").toggle_term_cmd " export NNN_PLUG='p:preview-tui' && nnn -a" end, desc = "nnn" },
        ["<Leader>E"] = {
          "<Cmd>call system('tmux splitp -h \"export NNN_PLUG=p:preview-tui && nnn -aP p\"')<CR>",
          desc = "Toggle Maximize",
        },

        -- git
        ["<leader>gC"] = { function() require("astrocore").toggle_term_cmd "gitmoji -c" end, desc = "Gitmoji Commit" },

        -- Telescope
        ["<Leader>fr"] = { "<Cmd>Telescope frecency<CR>", desc = "Telescope Frecency" },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
  },
}
