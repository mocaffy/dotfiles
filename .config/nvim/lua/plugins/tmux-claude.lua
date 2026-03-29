return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      v = {
        ["<Leader>as"] = {
          function()
            local s = vim.fn.line("'<")
            local e = vim.fn.line("'>")
            local path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
            local ref = "@" .. path .. ":" .. s .. "-" .. e
            vim.fn.system({ os.getenv("HOME") .. "/dotfiles/scripts/send-to-claude.sh", "-f", ref })
          end,
          desc = "Send selection to Claude pane",
        },
      },
      n = {
        ["<Leader>as"] = {
          function()
            local path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
            local line = vim.fn.line(".")
            vim.fn.system({ os.getenv("HOME") .. "/dotfiles/scripts/send-to-claude.sh", "@" .. path .. ":" .. line })
          end,
          desc = "Send file path to Claude pane",
        },
      },
    },
  },
}
