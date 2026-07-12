return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    -- Look at the global theme setting
    -- Make sure this matches the string you set in your colorscheme.lua file!
    local active_theme = "gruvbox"

    local lualine_theme
    if active_theme == "gruvbox" or active_theme == "catppuccin" then
      lualine_theme = "auto" -- Automatically extracts colors straight from your active theme!
    else
      -- Josean's original custom Tokyo Night hex setup
      local colors = {
        blue = "#65D1FF",
        green = "#3EFFDC",
        violet = "#FF61EF",
        yellow = "#FFDA7B",
        red = "#FF4A4A",
        fg = "#c3ccdc",
        bg = "#112638",
        inactive_bg = "#2c3043",
      }

      lualine_theme = {
        normal = {
          a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        insert = {
          a = { bg = colors.green, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        visual = {
          a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        command = {
          a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        replace = {
          a = { bg = colors.red, fg = colors.bg, gui = "bold" },
          b = { bg = colors.bg, fg = colors.fg },
          c = { bg = colors.bg, fg = colors.fg },
        },
        inactive = {
          a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
          b = { bg = colors.inactive_bg, fg = colors.semilightgray },
          c = { bg = colors.inactive_bg, fg = colors.semilightgray },
        },
      }
    end

    -- Configure lualine
    lualine.setup({
      options = {
        theme = lualine_theme, -- Swaps seamlessly based on active_theme!
      },
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          { "fileformat", symbols = { unix = "" } },
          { "filetype" },
        },
      },
    })
  end,
}
