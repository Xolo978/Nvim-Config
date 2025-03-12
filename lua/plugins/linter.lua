return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        python = { "pylint", "flake8" },
        lua = { "luacheck" },
        c = { "cppcheck" },
        cpp = { "cppcheck" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        markdown = { "markdownlint" },
      }
    end,
  }
}

