return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },

  -- Tmux と Neovim のステータスラインを統合する
  {
    "mocaffy/vim-tpipeline",
  },

  -- stylus のシンタックスハイライト
  {
    "iloginow/vim-stylus",
    lazy = true,
    event = "BufEnter *.styl"
  },

  -- mjml プラグイン
  {
    "amadeus/vim-mjml",
    lazy = true,
    event = "BufEnter *.mjml"
  },

  -- tridactylrc のシンタックスハイライト
  {
    "tridactyl/vim-tridactyl",
    lazy = true,
    event = "BufEnter tridactylrc"
  },

  -- markdown プレビュー
  "iamcco/markdown-preview.nvim",

  -- 行単位でコミットできるプラグイン
  {
    "TimUntersberger/neogit",
    dependencies = 'nvim-lua/plenary.nvim',
    config = function()
      require("neogit").setup()
    end,
  },

  -- Git の便利プラグイン
  {
    "tanvirtin/vgit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function() require("vgit").setup() end,
  },

  -- ウィンドウ(ペイン)の拡大縮小プラグイン
  {
    "anuvyklack/windows.nvim",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function() require("windows").setup() end,
  },

  -- よく開くファイルを表示
  {
    "nvim-telescope/telescope-frecency.nvim",
    requires = { "kkharji/sqlite.lua" },
    config = function()
      require "telescope".load_extension("frecency")
    end,
  },

  -- {
  --   "jose-elias-alvarez/typescript.nvim",
  --   after = "mason-lspconfig.nvim",
  --   config = function()
  --     require("typescript").setup {
  --       server = astronvim.lsp.server_settings "tsserver",
  --     }
  --   end,
  -- },
  -- {
  --   "sigmasd/deno-nvim",
  --   after = "mason-lspconfig.nvim",
  --   config = function()
  --     require("deno-nvim").setup {
  --       server = astronvim.lsp.server_settings "denols",
  --     }
  --   end
  -- }
}

