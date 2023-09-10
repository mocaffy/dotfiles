return {
  "EdenEast/nightfox.nvim",
  config = function()
    local palettes = require('nightfox.palette').load()
    local Color = require("nightfox.lib.color")
    require("nightfox").setup({
      options = {
        dim_inactive = false,
        terminal_colors = true,
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
      palettes = {
        nightfox = {
          bg4 = Color.from_hex(palettes.nightfox.bg1):brighten(-2):to_css()
        },
        dayfox = {
          bg4 = Color.from_hex(palettes.dayfox.bg1):brighten(-2):to_css()
        },
        dawnfox = {
          bg4 = Color.from_hex(palettes.dawnfox.bg1):brighten(-2):to_css()
        },
        duskfox = {
          bg4 = Color.from_hex(palettes.duskfox.bg1):brighten(-2):to_css()
        },
        nordfox = {
          bg4 = Color.from_hex(palettes.nordfox.bg1):brighten(-2):to_css()
        },
        terafox = {
          bg4 = Color.from_hex(palettes.terafox.bg1):brighten(-2):to_css()
        },
        carbonfox = {
          bg4 = Color.from_hex(palettes.carbonfox.bg1):brighten(-2):to_css()
        },
      },
      groups = {
        all = {
          FloatBorder = { fg = "#232831", bg = "#232831" },
          VertSplit = { fg = "bg0", bg = "bg1" },
          VertSplitNC = { fg = "bg0", bg = "bg4" },
          StatusLine = { fg = "#cdcecf", bg = "#232831" },
          NormalNC = { fg = "fg1", bg = "bg4" },
          SignColumn = { bg = "NONE" },
          MsgArea = { fg = "#e1c98e", bg = "#232831" },
          FoldColumn = {},
          WhichKeyFloat = { bg = "bg0" },
          WinBarNC = { fg = "fg1", bg = "bg4" },
          TabLineFill = { bg = "bg0" },
          NeoTreeTabInactive = { bg = "bg0" },
          NeoTreeTabSeparatorInactive = { fg = "bg0", bg = "bg0" },
          NeogitCursorLine = { bg = "" },
          NeogitDiffContext = { bg = "" },
        },
      },
    })
  end,
}
