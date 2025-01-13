local Shade = require "nightfox.lib.shade" -- Shadeをインポート
local palettes = require("nightfox.palette").load()
local Color = require "nightfox.lib.color"

local duskfox_specs = require("nightfox.palette.duskfox").generate_spec(palettes.duskfox)

require("nightfox").setup {
  options = {
    dim_inactive = false,
    terminal_colors = true,
    styles = { -- Style to be applied to different syntax groups
      comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
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
      bg4 = Color.from_hex(palettes.nightfox.bg1):brighten(-2):to_css(),
    },
    dayfox = {
      bg4 = Color.from_hex(palettes.dayfox.bg1):brighten(-2):to_css(),
    },
    dawnfox = {
      bg4 = Color.from_hex(palettes.dawnfox.bg1):brighten(-2):to_css(),
    },
    duskfox = {
      black = Shade.new("#031619", 0.30, -0.30), -- Base01
      red = Shade.new("#16c1d9", 0.30, -0.30), -- Base08
      green = Shade.new("#4dd0e1", 0.10, -0.30), -- Base0B
      yellow = Shade.new("#80deea", 0.30, -0.30), -- Base0A
      blue = Shade.new("#00bcd4", 0.30, -0.30), -- Base0D
      magenta = Shade.new("#00acc1", 0.30, -0.30), -- Base0E
      cyan = Shade.new("#26c6da", 0.30, -0.30), -- Base0C
      white = Shade.new("#109cb0", 0.30, -0.30), -- Base07
      orange = Shade.new("#b3ebf2", 0.30, -0.30), -- Base09
      pink = Shade.new("#0097a7", 0.30, -0.30), -- Base0F

      comment = "#095b67", -- Base03

      bg0 = "#021012", -- Base00
      bg1 = Color.from_hex("#031619"):brighten(-2):to_css(),
      -- bg1 = "#031619", -- Base01
      bg2 = "#041f23", -- Base02
      bg3 = "#041f23", -- Base03
      bg4 = Color.from_hex("#031619"):brighten(-3):to_css(),

      fg0 = "#16c1d9", -- Base07
      fg1 = "#109cb0", -- Base05
      -- fg2 = "#095b67", -- Base04
      fg2 = Color.from_hex("#109cb0"):brighten(-10):to_css(),
      fg3 = "#064048", -- Base03

      sel0 = "#052e34", -- Base01
      sel1 = "#052e34", -- Base02
      -- bg4 = Color.from_hex(palettes.duskfox.bg1):brighten(-2):to_css(),
    },
    nordfox = {
      bg4 = Color.from_hex(palettes.nordfox.bg1):brighten(-2):to_css(),
    },
    terafox = {
      bg4 = Color.from_hex(palettes.terafox.bg1):brighten(-2):to_css(),
    },
    carbonfox = {
      bg4 = Color.from_hex(palettes.carbonfox.bg1):brighten(-2):to_css(),
    },
  },
  specs = {
    duskfox = {
      diag = duskfox_specs.diag,
      diag_bg = duskfox_specs.diag_bg,
      diff = duskfox_specs.diff,
      -- git = duskfox_specs.git
    }
  },
  groups = {
    all = {
      FloatBorder = { fg = "bg0", bg = "bg0" },
      WinSeparator = { fg = "bg2", bg = "bg1" },
      WinSeparatorNC = { fg = "bg2", bg = "bg4" },
      StatusLine = { fg = "#cdcecf", bg = "#131a24" },
      NormalNC = { fg = "fg1", bg = "bg4" },
      SignColumn = { bg = "NONE" },
      MsgArea = { fg = "#e1c98e", bg = "bg0" },
      FoldColumn = {},
      WhichKeyFloat = { bg = "bg0" },
      WinBarNC = { fg = "fg1", bg = "bg4" },
      TabLineFill = { bg = "bg0" },
      NeoTreeIndentMarker = { fg = "bg1" },
      NeoTreeTabInactive = { bg = "bg0" },
      NeogitCursorLine = { bg = "" },
      NeogitDiffContext = { bg = "" },
      NeoTreeDirectoryIcon = { fg = "fg0" },
      -- NeoTreeDirectoryName = { fg = "#ffffff" },
      NeoTreeNormal = { fg = "fg0", bg = "bg1" },
      -- NeoTreeFileName = { fg = "#ffffff" },
      NeoTreeTabActive = { bg = "bg1" },
      NeoTreeTabSeparatorActive = { fg = "bg0", bg = "bg1" },
      NeoTreeTabSeparatorInactive = { fg = "bg1", bg = "bg0" },
      NeoTreeGitIgnored = { fg = "fg3" },
      -- NeoTreeCursorLine = { bg = "#425671" },
    },
  },
}

vim.cmd "colorscheme nightfox"
