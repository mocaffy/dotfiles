local commands = require("neo-tree.sources.filesystem.commands")

return {
  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },
  { "goolord/alpha-nvim", enabled = false },
  { "declancm/cinnamon.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  -- {
  --   "L3MON4D3/LuaSnip",
  --   config = function(plugin, opts)
  --     require "plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom luasnip configuration such as filetype extend or custom snippets
  --     local luasnip = require "luasnip"
  --     luasnip.filetype_extend("javascript", { "javascriptreact" })
  --   end,
  -- },
  -- {
  --   "windwp/nvim-autopairs",
  --   config = function(plugin, opts)
  --     require "plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     -- add more custom autopairs configuration such as custom rules
  --     local npairs = require "nvim-autopairs"
  --     local Rule = require "nvim-autopairs.rule"
  --     local cond = require "nvim-autopairs.conds"
  --     npairs.add_rules(
  --       {
  --         Rule("$", "$", { "tex", "latex" })
  --           -- don't add a pair if the next character is %
  --           :with_pair(cond.not_after_regex "%%")
  --           -- don't add a pair if  the previous character is xxx
  --           :with_pair(
  --             cond.not_before_regex("xxx", 3)
  --           )
  --           -- don't move right when repeat character
  --           :with_move(cond.none())
  --           -- don't delete if the next character is xx
  --           :with_del(cond.not_after_regex "xx")
  --           -- disable adding a newline when you press <cr>
  --           :with_cr(cond.none()),
  --       },
  --       -- disable for .vim files, but it work for another filetypes
  --       Rule("a", "a", "-vim")
  --     )
  --   end,
  -- },
  -- By adding to the which-key config and using our helper function you can add more which-key registered bindings
  {
    "folke/which-key.nvim",
    config = function(plugin, opts)
      require "plugins.configs.which-key"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- Add bindings which show up as group name
      local wk = require "which-key"
      wk.register({
        ["b"] = { name = "Buffer" },
        ["tt"] = { name = "Tmux" },
      }, { mode = "n", prefix = "<leader>" })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        width = 30,
        mappings = {
          ["<space>"] = false, -- disable space until we figure out which-key disabling
          ["<bs>"] = false, -- disable space until we figure out which-key disabling
          o = "open",
          H = "prev_source",
          L = "next_source",
        },
      },
      filesystem = {
        filtered_items = {
          visible = true, -- when true, they will just be displayed differently than normal items
        },
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        window = {
          mappings = {
            O = "system_open",
            h = "toggle_hidden",
            Q = "quick_look",
            ["<cr>"] = "open_extended",
            ["<space><space>"] = "quick_view"
          },
        },
        commands = {
          system_open = function(state) astronvim.system_open(state.tree:get_node():get_id()) end,
          open_extended = function(state)
            local path = state.tree:get_node():get_id()
            local ext = state.tree:get_node().ext
            local list = { jpg = true, jpeg = true, png = true, gif = true, bmp = true, webp = true, svg = false }
            if list[ext] then
              vim.fn.system{ "qlmanage", "-p", path }
            else
              commands.open(state)
            end
          end,
          quick_view = function(state)
            local path = state.tree:get_node():get_id()
            vim.fn.system{ "qlmanage", "-p", path }
          end,
        },
      }
    }
  }
  --
  -- {
  --   "akinsho/bufferline.nvim",
  --   config = function(plugin, opts)
  --     require "plugins.configs.bufferline"(plugin, opts) -- include the default astronvim config that calls the setup call
  --     local bl = require "bufferline"
  --     bl.options = {
  --       mode = "tabs",
  --     }
  --     bl.highlights = {
  --       fill = { bg = "#171d26" },
  --     }
  --   end,
  -- }
}
