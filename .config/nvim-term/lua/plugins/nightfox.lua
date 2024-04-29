return {
  "EdenEast/nightfox.nvim",
  config = function()
    require("nightfox").setup({
      options = {
        transparent = true,
        -- terminal_colors = true,
      },
      groups = {
        nightfox = {
          WinSeparator = { fg = "bg2" },
          WinBarNC = { fg = "fg1" },
          TermCursor = { bg = "yellow" },
        },
      },
    })
  end,
}
