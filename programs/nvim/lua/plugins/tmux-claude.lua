return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      v = {
        ["<Leader>as"] = {
          function()
            local vstart = vim.fn.getpos("v")
            local vcursor = vim.fn.getpos(".")
            local s = math.min(vstart[2], vcursor[2])
            local e = math.max(vstart[2], vcursor[2])
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
