return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    lazy = false,
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          },
        },
        picker = "snacks",
        automatic_installation = true,
      })

      local lspconfig = require("lspconfig")

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          if server_name == "clangd" then
            lspconfig.clangd.setup({
              cmd = { "clangd", "--fallback-style=Google", "--clang-tidy=false" }, 
              on_attach = function(client, bufnr)
                vim.api.nvim_create_autocmd("BufWritePre", {
                  buffer = bufnr,
                  callback = function()
                    vim.lsp.buf.format({ async = false })
                  end,
                })
              end,
            })
          else
            lspconfig[server_name].setup({})
          end
        end
      })

      -- Diagnostic settings
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●", 
          spacing = 4,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "always",
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        position = "bottom",
        height = 10,
        icons = true,
        mode = "workspace_diagnostics",
        fold_open = "",
        fold_closed = "",
        signs = { error = "", warning = "", hint = "", information = "" },
        use_diagnostic_signs = true,
      })
    end,
  },
}

