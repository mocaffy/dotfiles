---@type LazySpec
return {
  -- Tmux と Neovim のステータスラインを統合する
  {
    "mocaffy/vim-tpipeline",
  },

  -- tridactylrc のシンタックスハイライト
  {
    "tridactyl/vim-tridactyl",
    lazy = true,
    event = "BufEnter tridactylrc"
  },

  -- markdown プレビュー
  "iamcco/markdown-preview.nvim",

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
}
