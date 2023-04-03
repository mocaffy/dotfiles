return {
  overrides = function()
    local colors = require "ayu.colors"
    colors.generate(true) -- Pass `true` to enable mirage
    if vim.o.background == 'dark' then
      return {
        VertSplit = { fg = "#0C1125", bg = "#0C1125" },
        StatusLine = { fg = colors.fg, bg = "#0C1125" },
        StatusLineNC = { fg = colors.fg_idle, bg = "#0C1125" },
        Normal = { fg = colors.fg, bg = "#131c2e" },
        NormalNC = { fg = colors.fg, bg = "#111726" },
        SignColumn = {},
        CursorLine = { bg = "#1F252F" },
        MsgArea = { fg = "#e1c98e", bg = "#171d26" },
        NonText = { fg = "#111827" },
      }
    else
      return {}
    end
  end,
}
