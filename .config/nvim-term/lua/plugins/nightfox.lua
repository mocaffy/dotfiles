return {
  "EdenEast/nightfox.nvim",
  config = function()
    require("nightfox").setup({
      options = {
        -- transparent = true,
        terminal_colors = true,
      },
      groups = {
        all = {
          VertSplit = { fg = "bg0", bg = "bg1" },
          VertSplitNC = { fg = "bg0", bg = "#2A2F3B" },
          NormalNC = { fg = "fg1", bg = "#2a2f3b" },
          WinBarNC = { fg = "fg1", bg = "#2A2F3B" },
          TermCursor = { bg = "yellow" },
          -- TermCursorNC = { bg = "bg2" }
        },
      },
    })
  end,
}
