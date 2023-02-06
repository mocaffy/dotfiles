
return {
  overrides = function()
    local colors = require "ayu.colors"
    colors.generate(true) -- Pass `true` to enable mirage
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
