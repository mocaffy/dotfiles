local ss = require("nvim-tundra.stylesheet.arctic")

return {
  transparent_background = false,
  dim_inactive_windows = {
    enabled = true,
    color = nil,
  },
  sidebars = {
    enabled = true,
    color = nil,
  },
  editor = {
    search = {},
    substitute = {},
  },
  syntax = {
    booleans = { bold = true, italic = true },
    comments = { bold = true, italic = true },
    conditionals = {},
    constants = { bold = true },
    fields = {},
    functions = {},
    keywords = {},
    loops = {},
    numbers = { bold = true },
    operators = { bold = true },
    punctuation = {},
    strings = {},
    types = { italic = true },
  },
  diagnostics = {
    errors = {},
    warnings = {},
    information = {},
    hints = {},
  },
  plugins = {
    lsp = true,
    treesitter = true,
    telescope = true,
    nvimtree = true,
    cmp = true,
    context = true,
    dbui = true,
    gitsigns = true,
    neogit = true,
  },
  overwrite = {
    colors = {},
    highlights = {
      VertSplit = { fg = ss.bg.floating, bg = ss.bg.floating },
      StatusLine = { fg = ss.fg.normal, bg = ss.bg.floating },
      StatusLineNC = { fg = ss.fg.normal, bg = ss.bg.floating },
      -- Normal = { fg = ss.fg.normal, bg = "#1f2733" },
      -- NormalNC = { fg = ss.fg.normal, bg = "#1b222d" },
      SignColumn = {},
      -- CursorLine = { bg = "#1F252F" },
      MsgArea = { fg = "#e1c98e", bg = "#171d26" },
    },
  },
}
