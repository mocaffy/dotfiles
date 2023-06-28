return {
  "EdenEast/nightfox.nvim",
  config = function()
    require("nightfox").setup({
      groups = {
        all = {
          VertSplit = { fg = "bg0", bg = "bg0" },
          NormalNC = { fg = "fg1", bg = "#2A2F3B" },
          WinBarNC = { fg = "fg1", bg = "#2A2F3B" },
        },
      },
    })
  end,
}
