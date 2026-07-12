return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗",
            },
          },
        },
      },
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp", -- Required for autocompletion capabilities
    },
    opts = {
      -- list of servers for mason to install
      ensure_installed = {
        "ts_ls", -- Fixed from tsserver
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "basedpyright",
        "eslint",
      },
      -- ADDED: This connects Mason to your LSP config
      handlers = {
        -- Default handler for all servers
        function(server_name)
          local capabilities = require("cmp_nvim_lsp").default_capabilities()
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,

        -- Custom settings for Lua (standard in Josean's config)
        ["lua_ls"] = function()
          local capabilities = require("cmp_nvim_lsp").default_capabilities()
          require("lspconfig").lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        -- RESTORE NOTE: Commas are inside the comments here to prevent trailing comma parse errors
        -- "isort", -- python formatter disabled for ruff
        -- "black", -- python formatter disabled for ruff
        "pylint",
        "ruff",
        "eslint_d",
      },
      auto_update = true,
      run_on_start = true, -- Ensures tools are installed/ready on startup
    },
  },
}
