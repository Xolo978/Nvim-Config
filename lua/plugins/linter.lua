return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "pylint", "flake8" },
        lua = { "luacheck" },
        c = { "clang-tidy" },
        cpp = { "clang-tidy" },
        javascript = { "biome" },
        javascriptreact = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        markdown = { "markdownlint" },
        sql = {"sqruff"},
        json = { "biome" },
        jsonc = { "biome" },
      }

      lint.linters.biome = {
        name = "biome",
        cmd = "biome",
        stdin = true,
        args = {
          "lint",
          "--stdin-file-path",
          function() return vim.api.nvim_buf_get_name(0) end,
        },
        stream = "stdout",
        ignore_exitcode = true,
        parser = require("lint.parser").from_pattern(
          "([^:]+):(%d+):(%d+): (%w+) (%w+): (.+)",
          { "file", "lnum", "col", "severity", "code", "message" },
          {
            source = "biome",
            severity = {
              error = vim.diagnostic.severity.ERROR,
              warning = vim.diagnostic.severity.WARN,
              info = vim.diagnostic.severity.INFO,
              hint = vim.diagnostic.severity.HINT,
            },
          }
        ),
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  }
}