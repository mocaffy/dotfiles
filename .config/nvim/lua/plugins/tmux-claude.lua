return {
  "AstroNvim/astrocore",
  opts = {
    mappings = {
      v = {
        ["<Leader>as"] = {
          function()
            local s = vim.fn.line("'<")
            local e = vim.fn.line("'>")
            local lines = vim.fn.getline(s, e)
            local path = vim.fn.expand("%:p"):gsub(vim.fn.expand("$HOME"), "~")
            local content = path .. ":" .. s .. "-" .. e .. "\n\n" .. table.concat(lines, "\n")
            vim.fn.system({ "bash", "-c", os.getenv("HOME") .. "/dotfiles/scripts/send-to-claude.sh" }, content)
          end,
          desc = "Send selection to Claude pane",
        },
      },
      n = {
        ["<Leader>as"] = {
          function()
            local path = vim.fn.expand("%:p"):gsub(vim.fn.expand("$HOME"), "~")
            local line = vim.fn.line(".")
            vim.fn.system({ os.getenv("HOME") .. "/dotfiles/scripts/send-to-claude.sh", path .. ":" .. line })
          end,
          desc = "Send file path to Claude pane",
        },
      },
    },
  },
}
