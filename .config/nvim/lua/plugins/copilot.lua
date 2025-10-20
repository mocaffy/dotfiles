return {
  {
    "github/copilot.vim",
    cmd = "Copilot",
    event = "BufWinEnter",
    config = function()
      vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
        group = "github_copilot",
        callback = function(args) vim.fn["copilot#On" .. args.event]() end,
      })
      vim.fn["copilot#OnFileType"]()
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = { "fang2hou/blink-copilot" },
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}
