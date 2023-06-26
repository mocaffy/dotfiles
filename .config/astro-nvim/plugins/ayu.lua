-- ayu テーマ すこ
return {
  "Shatur/neovim-ayu",
  config = function()
    require("ayu").setup({
      overrides = function()
        local colors = require "ayu.colors"
        colors.generate(true) -- Pass `true` to enable mirage
        if vim.o.background == 'dark' then
          return {
            VertSplit = { fg = "#0C1125", bg = "#0c1125" },
            StatusLine = { fg = colors.fg, bg = "#0C1125" },
            StatusLineNC = { fg = colors.fg_idle, bg = "#0C1125" },
            Normal = { fg = colors.fg, bg = "#131c2e" },
            NormalNC = { fg = colors.fg, bg = "#111726" },
            SignColumn = {},
            CursorLine = { bg = "#182132" },
            MsgArea = { fg = "#e1c98e", bg = "#171d26" },
            NonText = { fg = "#111827" },
            FoldColumn = {},
            WhichKeyFloat = { bg = "#0C1125" },
            WinBar = { fg = colors.fg, bg = "#131c2e" },
            WinBarNC = { fg = colors.fg, bg = "#111726" },
            TabLineFill = { bg = "#0C1125" },
            NeoTreeTabInactive = { bg = "#0c1125" },
            NeoTreeTabSeparatorInactive = { fg = "#101010", bg = "#0c1125" }
          }
        else
          return {}
        end
      end,
    })
  end,
}
