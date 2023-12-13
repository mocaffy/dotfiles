return {
  "folke/styler.nvim",
  enabled = true,
  config = function()
    require("styler").setup({
      themes = {
        vim = { colorscheme = "nightfox" },
        NeogitStatus = { colorscheme = "nightfox" },
        NeogitCommitMessage = { colorscheme = "nightfox" },
      },
    })
  end,
}
