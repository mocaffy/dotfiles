-- Modify which-key registration (Use this with mappings table in the above.)
return {
  -- Add bindings which show up as group name
  register = {
    -- first key is the mode, n == normal mode
    n = {
      -- second key is the prefix, <leader> prefixes
      ["<leader>"] = {
        -- third key is the key to bring up next level and its displayed
        -- group name in which-key top level menu
        ["b"] = { name = "Buffer" },
        ["tt"] = { name = "Tmux" },
      },
    },
  },
}
