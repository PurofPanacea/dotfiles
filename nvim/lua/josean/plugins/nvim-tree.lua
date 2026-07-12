return {
  "nvim-tree/nvim-tree.lua",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup({
      view = {
        width = 50,
        relativenumber = true,
      },
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          -- NEW: Forces nvim-tree to respect colorscheme/devicon colors
          web_devicons = {
            folder = {
              color = true,
            },
          },
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
          -- OLD CONFIG (Commented out to restore if needed):
          -- glyphs = {
          --   folder = {
          --     arrow_closed = "",
          --     arrow_open = "",
          --   },
          -- },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer

    -- NEW: Gruvbox Highlight Fixes
    -- Links folder icons and names to Gruvbox's signature Aqua and Yellow
    vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { link = "GruvboxAqua" })
    vim.api.nvim_set_hl(0, "NvimTreeFolderName", { link = "GruvboxAqua" })
    vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { link = "GruvboxYellow", bold = true })
  end,
}
