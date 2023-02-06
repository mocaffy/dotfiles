--              AstroNvim Configuration Table
-- All configuration changes should go inside of the table below

-- You can think of a Lua "table" as a dictionary like data structure the
-- normal format is "key = value". These also handle array like data structures
-- where a value with no key simply has an implicit numeric key
local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_reload = false, -- automatically reload and sync packer after a successful update
    auto_quit = false, -- automatically quit the current session after a successful update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme to use
  colorscheme = "ayu-mirage",

  -- Add highlight groups in any theme
  highlights = {
    -- init = { -- this table overrides highlights in all themes
    --   Normal = { bg = "#000000" },
    -- }
    -- duskfox = { -- a table of overrides/changes to the duskfox theme
    --   Normal = { bg = "#000000" },
    -- },
  },

  -- set vim options here (vim.<first_key>.<second_key> = value)
  options = {
    opt = {
      -- set to true or false etc.
      relativenumber = true, -- sets vim.opt.relativenumber
      number = true, -- sets vim.opt.number
      spell = false, -- sets vim.opt.spell
      signcolumn = "auto", -- sets vim.opt.signcolumn to auto
      wrap = false, -- sets vim.opt.wrap
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
      autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true, -- enable completion at start
      autopairs_enabled = true, -- enable autopairs at start
      diagnostics_enabled = true, -- enable diagnostics at start
      status_diagnostics_enabled = true, -- enable diagnostics in statusline
      icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
      ui_notifications_enabled = true, -- disable notifications when toggling UI elements
      heirline_bufferline = false, -- enable new heirline based bufferline (requires :PackerSync after changing)
    },
  },
  -- If you need more control, you can use the function()...end notation
  -- options = function(local_vim)
  --   local_vim.opt.relativenumber = true
  --   local_vim.g.mapleader = " "
  --   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
  --   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
  --
  --   return local_vim
  -- end,

  -- Set dashboard header
  header = {
    " █████  ███████ ████████ ██████   ██████",
    "██   ██ ██         ██    ██   ██ ██    ██",
    "███████ ███████    ██    ██████  ██    ██",
    "██   ██      ██    ██    ██   ██ ██    ██",
    "██   ██ ███████    ██    ██   ██  ██████",
    " ",
    "    ███    ██ ██    ██ ██ ███    ███",
    "    ████   ██ ██    ██ ██ ████  ████",
    "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
    "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
    "    ██   ████   ████   ██ ██      ██",
  },

  -- Default theme configuration
  default_theme = {
    -- Modify the color palette for the default theme
    colors = {
      fg = "#abb2bf",
      bg = "#1e222a",
    },
    highlights = function(hl) -- or a function that returns a new table of colors to set
      local C = require "default_theme.colors"

      hl.Normal = { fg = C.fg, bg = C.bg }

      -- New approach instead of diagnostic_style
      hl.DiagnosticError.italic = true
      hl.DiagnosticHint.italic = true
      hl.DiagnosticInfo.italic = true
      hl.DiagnosticWarn.italic = true

      return hl
    end,
    -- enable or disable highlighting for extra plugins
    plugins = {
      aerial = true,
      beacon = false,
      bufferline = true,
      cmp = true,
      dashboard = false,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      treesitter = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- Extend LSP configuration
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- "sumneko_lua",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the global LSP on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the mason server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = { -- override table for require("lspconfig").yamlls.setup({...})
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },

  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
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
  },

  -- Configure plugins
  plugins = {
    init = {
      -- You can disable default plugins as follows:
      -- ダッシュボードプラグインを無効に
      ["goolord/alpha-nvim"] = { disable = true },
      -- スクロールアニメーションプラグインを無効に
      ["declancm/cinnamon.nvim"] = { disable = true },
      -- ["folke/noice.nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      -- Add plugins, the packer syntax without the "use"
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
      --
      -- スクロールバーを表示するプラグイン
      {
        "dstein64/nvim-scrollview",
        config = function()
          require("scrollview").setup {
            excluded_filetypes = { "nerdtree" },
            current_only = false,
            winblend = 50,
            column = 1,
          }
        end,
      },
      -- 行単位でコミットできるプラグイン
      {
        "TimUntersberger/neogit",
        config = function() require("neogit").setup() end,
      },
      -- ayu テーマ すこ
      {
        "Shatur/neovim-ayu",
        config = function()
          local colors = require "ayu.colors"
          colors.generate(true) -- Pass `true` to enable mirage
          require("ayu").setup {
            overrides = function()
              if vim.o.background == 'dark' then
                return {
                  VertSplit = { fg = "#171d26", bg = "#171d26" },
                  StatusLine = { fg = colors.fg, bg = "#171d26" },
                  StatusLineNC = { fg = colors.fg_idle, bg = "#171d26" },
                  Normal = { fg = colors.fg, bg = "#1f2733" },
                  NormalNC = { fg = colors.fg, bg = "#1b222d" },
                  SignColumn = {},
                  CursorLine = { bg = "#1F252F" },
                  MsgArea = { fg = "#e1c98e", bg = "#171d26" },
                }
              else
                return {}
              end
            end,
          }
        end,
      },
      -- stylus のシンタックスハイライト
      { "iloginow/vim-stylus" },
      -- Tmux と Neovim のステータスラインを統合する
      { "mocaffy/vim-tpipeline" },
      -- mjml プラグイン
      { "amadeus/vim-mjml" },
      -- markdown プレビュー
      { "iamcco/markdown-preview.nvim" },
      -- Git の便利プラグイン
      {
        "tanvirtin/vgit.nvim",
        requires = {
          "nvim-lua/plenary.nvim",
        },
        config = function() require("vgit").setup() end,
      },
      -- ウィンドウ(ペイン)の拡大縮小プラグイン
      {
        "anuvyklack/windows.nvim",
        requires = {
          "anuvyklack/middleclass",
        },
        config = function() require("windows").setup() end,
      },
      -- よく開くファイルを表示
      {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
          require "telescope".load_extension("frecency")
        end,
        requires = { "kkharji/sqlite.lua" }
      }
      -- Vim コマンド入力をポップアップで表示
      -- {
      --   "folke/noice.nvim",
      --   config = function()
      --     require("noice").setup {
      --       lsp = {
      --         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      --         override = {
      --           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      --           ["vim.lsp.util.stylize_markdown"] = true,
      --           ["cmp.entry.get_documentation"] = true,
      --           -- ["config.lsp.hover.enabled"] = false
      --         },
      --         signature = { enabled = false },
      --         hover = { enabled = false },
      --       },
      --       notify = { enabled = false },
      --       -- you can enable a preset for easier configuration
      --       presets = {
      --         -- bottom_search = true, -- use a classic bottom cmdline for search
      --         command_palette = true, -- position the cmdline and popupmenu together
      --         long_message_to_split = true, -- long messages will be sent to a split
      --         inc_rename = false, -- enables an input dialog for inc-rename.nvim
      --         lsp_doc_border = false, -- add a border to hover docs and signature help
      --       },
      --     }
      --   end,
      --   requires = {
      --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      --     "MunifTanjim/nui.nvim",
      --     -- OPTIONAL:
      --     --   `nvim-notify` is only needed, if you want to use the notification view.
      --     --   If not available, we use `mini` as the fallback
      --     "rcarriga/nvim-notify",
      --   },
      -- },
      -- We also support a key value style plugin definition similar to NvChad:
      -- ["ray-x/lsp_signature.nvim"] = {
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
    },
    -- All other entries override the require("<key>").setup({...}) call for default plugins
    ["bufferline"] = {
      options = {
        mode = "tabs",
      },
      highlights = {
        fill = { bg = "#171d26" },
      },
    },
    ["neo-tree"] = {
      filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
        }
      }
    },
    -- カーソルがちらつくことがあるので通知のアニメーションをオフにする
    ["notify"] = {
      stages = "static",
    },
    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      -- config variable is the default configuration table for the setup function call
      -- local null_ls = require "null-ls"

      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.formatting.prettier,
      }
      return config -- return final config table
    end,
    treesitter = { -- overrides `require("treesitter").setup(...)`
      ensure_installed = { "lua", "vim", "typescript", "javascript", "html", "pug", "css" },
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = { -- overrides `require("mason-lspconfig").setup(...)`
      ensure_installed = { "sumneko_lua", "vimls", "angularls", "tsserver" },
    },
    -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
    ["mason-null-ls"] = { -- overrides `require("mason-null-ls").setup(...)`
      -- ensure_installed = { "prettier", "stylua" },
    },
    ["mason-nvim-dap"] = { -- overrides `require("mason-nvim-dap").setup(...)`
      -- ensure_installed = { "python" },
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Extend filetypes
    filetype_extend = {
      -- javascript = { "javascriptreact" },
    },
    -- Configure luasnip loaders (vscode, lua, and/or snipmate)
    vscode = {
      -- Add paths for including more VS Code style snippets in luasnip
      paths = {},
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Customize Heirline options
  heirline = {
    -- -- Customize different separators between sections
    -- separators = {
    --   tab = { "", "" },
    -- },
    -- -- Customize colors for each element each element has a `_fg` and a `_bg`
    -- colors = function(colors)
    --   colors.git_branch_fg = astronvim.get_hlgroup "Conditional"
    --   return colors
    -- end,
    -- -- Customize attributes of highlighting in Heirline components
    -- attributes = {
    --   -- styling choices for each heirline element, check possible attributes with `:h attr-list`
    --   git_branch = { bold = true }, -- bold the git branch statusline component
    -- },
    -- -- Customize if icons should be highlighted
    -- icon_highlights = {
    --   breadcrumbs = false, -- LSP symbols in the breadcrumbs
    --   file_icon = {
    --     winbar = false, -- Filetype icon in the winbar inactive windows
    --     statusline = true, -- Filetype icon in the statusline
    --   },
    -- },
  },

  -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["b"] = { name = "Buffer" },
          ["tt"] = { name = "Tmux" },
        },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
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

    -- Normal と NormalNC のハイライト設定を変数に代入
    local color_normal = vim.api.nvim_get_hl_by_name("Normal", true)
    local color_normal_nc = vim.api.nvim_get_hl_by_name("NormalNC", true)

    -- Neovim からフォーカスか外れた時に Normal の色を NormalNC にして
    -- フォーカスが戻った時に Normal に戻す
    vim.api.nvim_create_autocmd({"FocusLost"}, {
      pattern = {"*"},
      callback = function()
        vim.api.nvim_set_hl(0, "Normal", { fg = color_normal_nc.foreground, bg = color_normal_nc.background})
      end
    })
    vim.api.nvim_create_autocmd({"FocusGained"}, {
      pattern = {"*"},
      callback = function()
        vim.api.nvim_set_hl(0, "Normal", { fg = color_normal.foreground, bg = color_normal.background})
      end
    })
  end,
}

return config
