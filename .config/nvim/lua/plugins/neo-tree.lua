return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 37,
      mappings = {
        ["<space>"] = false, -- disable space until we figure out which-key disabling
        ["<bs>"] = false, -- disable space until we figure out which-key disabling
        o = "open",
        H = "prev_source",
        L = "next_source",
      },
    },
    default_component_configs = {
      indent = {
        with_markers = false,
        with_expanders = false
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "󰜌",
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = "*",
        highlight = "NeoTreeFileIcon",
      },
      git_status = {
        symbols = {
          -- Change type
          added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "", -- this can only be used in the git_status source

          renamed = "", -- this can only be used in the git_status source
          -- Status type
          untracked = "",
          ignored = "",
          unstaged = "",

          staged = "",
          conflict = "",
        },
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = true,
      },
      follow_current_file = {
        enable = true,
      },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          -- O = "system_open",
          -- h = "toggle_hidden",
          -- ["<cr>"] = "open_extended",
          -- ["<space><space>"] = "quick_view",
        },
      },
      commands = {
        -- system_open = function(state)
        --   local path = state.tree:get_node():get_id()
        --   print(path)
        --   -- TODO: just use vim.ui.open when dropping support for Neovim <0.10
        --   vim.fn.jobstart({ "zsh", "-c", "~/dotfiles/.bin/open " .. path }, { detach = true })
        -- end,
        -- open_extended = function(state)
        --   local path = state.tree:get_node():get_id()
        --   local ext = state.tree:get_node().ext
        --   local list = { jpg = true, jpeg = true, png = true, gif = true, bmp = true, webp = true, svg = false }
        --   if list[ext] then
        --     vim.fn.system { "qlmanage", "-p", path }
        --   else
        --     commands.open(state)
        --   end
        -- end,
        -- quick_view = function(state)
        --   local path = state.tree:get_node():get_id()
        --   vim.fn.system { "qlmanage", "-p", path }
        -- end,
      },
    },
  },
}
