return {
  ["goolord/alpha-nvim"] = { disable = true },
  ["declancm/cinnamon.nvim"] = { disable = true },

  -- スクロールバーを表示するプラグイン
  ["dstein64/nvim-scrollview"] = {
    config = function()
      require("scrollview").setup(require "user.plugins.scrollview")
    end,
  },

  -- 行単位でコミットできるプラグイン
  ["TimUntersberger/neogit"] = {
    config = function()
      require("neogit").setup()
    end,
  },

  -- ayu テーマ すこ
  ["Shatur/neovim-ayu"] = {
    config = function()
      require("ayu").setup(require "user.plugins.ayu")
    end,
  },
  ["sam4llis/nvim-tundra"] = {
    config = function()
      require('nvim-tundra').setup(require "user.plugins.tundra")
    end,
  },

  -- stylus のシンタックスハイライト
  ["iloginow/vim-stylus"] = {},

  -- Tmux と Neovim のステータスラインを統合する
  ["mocaffy/vim-tpipeline"] = {},

  -- mjml プラグイン
  ["amadeus/vim-mjml"] = {},

  -- markdown プレビュー
  ["iamcco/markdown-preview.nvim"] = {},

  -- Git の便利プラグイン
  ["tanvirtin/vgit.nvim"] = {
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function() require("vgit").setup() end,
  },

  -- ウィンドウ(ペイン)の拡大縮小プラグイン
  ["anuvyklack/windows.nvim"] = {
    requires = {
      "anuvyklack/middleclass",
    },
    config = function() require("windows").setup() end,
  },

  -- よく開くファイルを表示
  ["nvim-telescope/telescope-frecency.nvim"] = {
    requires = { "kkharji/sqlite.lua" },
    config = function()
      require "telescope".load_extension("frecency")
    end,
  },

  -- Vim コマンド入力をポップアップで表示
  ["folke/noice.nvim"] = {
    disable = true,
    config = function()
      require("noice").setup(require "user.plugins.noice")
    end,
  }
}
