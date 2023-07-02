return {
  "EdenEast/nightfox.nvim",
  config = function()
    require("nightfox").setup({
      options = {
        dim_inactive = false,
        styles = {               -- Style to be applied to different syntax groups
          comments = "NONE",     -- Value is any valid attr-list value `:help attr-list`
          conditionals = "NONE",
          constants = "NONE",
          functions = "NONE",
          keywords = "NONE",
          numbers = "NONE",
          operators = "NONE",
          strings = "NONE",
          types = "NONE",
          variables = "NONE",
        },
      },
      groups = {
        all = {
          -- WinActive = { fg = "fg1", bg = "bg1" },
          -- WinInactive = { fg = "fg1", bg = "#F5EFE8" },
          -- SplitActive = { fg = "fg1", bg = "bg1" },
          -- SplitInactive = { fg = "black", bg = "#F5EFE8" },
          VertSplit = { fg = "bg0", bg = "bg1" },
          VertSplitNC = { fg = "bg0", bg = "#F5EFE8" },
          StatusLine = { fg = "#cdcecf", bg = "#232831" },
          -- StatusLineNC = { fg = "fg1", bg = "bg0" },
          -- Normal = { bg = "NONE" },
          NormalNC = { fg = "fg1", bg = "#F5EFE8" },
          SignColumn = { bg = "NONE" },
          MsgArea = { fg = "#e1c98e", bg = "bg1" },
          FoldColumn = {},
          WhichKeyFloat = { bg = "bg0" },
          -- WinBar = { fg = "fg1", bg = "bg1" },
          WinBarNC = { fg = "fg1", bg = "#F5EFE8" },
          TabLineFill = { bg = "bg0" },
          NeoTreeTabInactive = { bg = "bg0" },
          NeoTreeTabSeparatorInactive = { fg = "bg0", bg = "bg0" },
        },
      },
    })
  end,
}
