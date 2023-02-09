local commands = require("neo-tree.sources.filesystem.commands")

return {
  enable_diagnostics = true,
  source_selector = {
    -- winbar = true,
    content_layout = "center",
    tab_labels = {
      filesystem = astronvim.get_icon "FolderClosed" .. " File",
      buffers = astronvim.get_icon "DefaultFile" .. " Bufs",
      git_status = astronvim.get_icon "Git" .. " Git",
      diagnostics = astronvim.get_icon "Diagnostic" .. " Diagnostic",
    },
  },
  default_component_configs = {
    indent = { padding = 0 },
    icon = {
      folder_closed = astronvim.get_icon "FolderClosed",
      folder_open = astronvim.get_icon "FolderOpen",
      folder_empty = astronvim.get_icon "FolderEmpty",
      default = astronvim.get_icon "DefaultFile",
    },
    git_status = {
      symbols = {
        added = "",
        deleted = "",
        modified = "",
        renamed = "",
        untracked = "",
        ignored = "",
        unstaged = "",
        staged = "",
        conflict = "",
      },
    },
  },
  window = {
    width = 30,
    mappings = {
      ["<space>"] = false, -- disable space until we figure out which-key disabling
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
        ["<cr>"] = "open_extended"
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
    },
  },
  event_handlers = {
    { event = "neo_tree_buffer_enter", handler = function(_) vim.opt_local.signcolumn = "auto" end },
  },
}
