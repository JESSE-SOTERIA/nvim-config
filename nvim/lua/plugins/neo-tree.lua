-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  --TODO: make keymaps for neotree.
  keys = {
    { '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    filesystem = {
      --open the file tree on current file.
      follow_current_file =true,
      --show neo tree when netrw is opened.
      hijack_netrw_behavior = "open_current",
      --use the os level file watchers to detect changes.
      use_libuv_file_watcher = true,
      window = {
        --another laest change
        position = "right",
        width = 40,
        mappings = {
          ['\\'] = 'close_window',
          ['A'] = 'add_directory',     ["S"] = "split_with_window_picker",
      ["s"] = "vsplit_with_window_picker",
      ["t"] = "open_tabnew",
      ["w"] = "open_with_window_picker",
      ["C"] = "close_node",
      ["a"] = "add",
      ["d"] = "delete",
      ["r"] = "rename",
      ["y"] = "copy_to_clipboard",
      ["x"] = "cut_to_clipboard",
      ["p"] = "paste_from_clipboard",
      ["c"] = "copy",
      ["m"] = "move",
      ["q"] = "close_window",
      ["R"] = "refresh",
        },
      },
    },
  },
}
