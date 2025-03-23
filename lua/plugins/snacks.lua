return {
    "folke/snacks.nvim",
    lazy = false,
    opts = {
      picker = { enabled = true },
      input = {enabled = true},
        dashboard = {
          dashboard = {
            enabled = true,
            buttons = {
              { "  Find File", "SPC ff", ":FzfLua files<CR>" },
              { "  Live Grep", "SPC fg", ":FzfLua live_grep<CR>" },
              { "  New File", "SPC fn", ":ene <BAR> startinsert<CR>" },
              { "  Bookmarks", "SPC fb", ":Telescope marks<CR>" },
              { "󰒲  Lazy", "SPC l", ":Lazy<CR>" },
              { "  Quit", "SPC fq", ":qa<CR>" },
            },
            footer = function()
              local stats = require("lazy").stats()
              local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
              return { "🚀 Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms" }
            end,
          },
      }
    },
  }
