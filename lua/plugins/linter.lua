return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "pylint", "flake8" },
        lua = { "luacheck" },
        c = { "cpplint" },
        cpp = { "cpplint" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        markdown = { "markdownlint" },
      }
    end,
  }
}

