return {
  "EdenEast/nightfox.nvim",
  config = function()
    require("nightfox").setup({
      groups = {
        all = {
          VertSplit = { fg = "bg0", bg = "bg0" },
          StatusLine = { fg = "fg1", bg = "bg0" },
          StatusLineNC = { fg = "fg1", bg = "bg0" },
          Normal = { fg = "fg1", bg = "bg1" },
          NormalNC = { fg = "fg1", bg = "#F5EFE8" },
          SignColumn = {},
          MsgArea = { fg = "#e1c98e", bg = "bg1" },
          FoldColumn = {},
          WhichKeyFloat = { bg = "bg0" },
          WinBar = { fg = "fg1", bg = "bg1" },
          WinBarNC = { fg = "fg1", bg = "#F5EFE8" },
          TabLineFill = { bg = "bg0" },
          NeoTreeTabInactive = { bg = "bg0" },
          NeoTreeTabSeparatorInactive = { fg = "bg0", bg = "bg0" }
        },
      },
    })
  end,
}
