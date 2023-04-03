local ss = require("nvim-tundra.stylesheet.arctic")
-- Add highlight groups in any theme
return {
  -- init = { -- this table overrides highlights in all themes
  --   Normal = { bg = "#000000" },
  -- }
  init = { -- a table of overrides/changes to the duskfox theme
    VertSplit = { fg = ss.bg.floating, bg = ss.bg.floating },
    StatusLine = { fg = ss.fg.normal, bg = ss.bg.floating },
    StatusLineNC = { fg = ss.fg.normal, bg = ss.bg.floating },
    -- Normal = { fg = ss.fg.normal, bg = "#1f2733" },
    -- NormalNC = { fg = ss.fg.normal, bg = "#1b222d" },
    SignColumn = {},
    -- CursorLine = { bg = "#1F252F" },
    MsgArea = { fg = "#e1c98e", bg = "#171d26" },
  },
}
