return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")
      local function detect_formatters(filetype)
        local available = conform.list_formatters(filetype)
        local names = {}
        for _, formatter in ipairs(available) do
          table.insert(names, formatter.name)
        end
        return #names > 0 and names or nil
      end

      conform.setup({
        formatters_by_ft = setmetatable({}, {
          __index = function(_, filetype)
            return detect_formatters(filetype)
          end,
        }),
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 500,
        },
      })
    end,
  }
}

