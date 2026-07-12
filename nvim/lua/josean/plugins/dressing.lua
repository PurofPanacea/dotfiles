return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      enabled = true,
      default_prompt = "Input",
      trim_prompt = true,
    },
    select = {
      enabled = true,
      backend = { "telescope", "fzf_lua", "builtin" },
      -- This ensures that if Telescope is installed, Dressing will use it
      telescope = require("telescope.themes").get_cursor(),
    },
  },
}
