local M = {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  -- 👇 ADD THIS LINE: Tells lazy.nvim to make the command available instantly on startup
  cmd = { "Prettier" },
}

function M.config()
  local conform = require("conform")

  conform.setup({
    formatters_by_ft = {
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      svelte = { "prettier" },
      css = { "prettier" },
      html = { "prettier" },
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },
      liquid = { "prettier" },
      lua = { "stylua" },
      -- RESTORE NOTE: Python formatters handled by ruff, comment out to disable
      -- python = { "isort", "black" },
      dart = { "dart_format" },
    },
    format_on_save = {
      lsp_fallback = true,
      async = false,
      timeout_ms = 3000,
    },
  })

  -- Keymap shortcut configuration
  vim.keymap.set({ "n", "v" }, "<leader>mp", function()
    conform.format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 1000,
    })
  end, { desc = "Format file or range (in visual mode)" })

  -- Global command registration
  vim.api.nvim_create_user_command("Prettier", function()
    require("conform").format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 3000,
    })
  end, { desc = "Format current buffer using Conform" })
end

return M
