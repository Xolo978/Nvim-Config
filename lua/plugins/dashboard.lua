return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    local dashboard = require("dashboard")
    
    dashboard.setup({
      theme = "doom", 
      config = {
        header = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
        },
        center = {
          {
            icon = "󰈞 ",
            icon_hl = "Title",
            desc = "Find File",
            desc_hl = "String",
            key = "f",
            key_hl = "Number", 
            action = ":FzfLua files<CR>",
          },
          {
            icon = "󰊢 ",
            icon_hl = "Title",
            desc = "Live Grep",
            desc_hl = "String",
            key = "g",
            key_hl = "Number",
            action = ":FzfLua live_grep<CR>",
          },
          {
            icon = "󰈔 ",
            icon_hl = "Title",
            desc = "New File",
            desc_hl = "String",
            key = "n",
            key_hl = "Number",
            action = ":ene <BAR> startinsert<CR>",
          },
          {
            icon = "󰁯 ",
            icon_hl = "Title",
            desc = "Restore Session",
            desc_hl = "String",
            key = "r",
            key_hl = "Number",
            action = ":<leader>ss",
          },
          {
            icon = "󰒲 ",
            icon_hl = "Title",
            desc = "Lazy",
            desc_hl = "String",
            key = "l",
            key_hl = "Number",
            action = ":Lazy<CR>",
          },
          {
            icon = "󰗼 ",
            icon_hl = "Title",
            desc = "Quit",
            desc_hl = "String",
            key = "q",
            key_hl = "Number",
            action = ":qa<CR>",
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return {"NEOVIM loaded " .. stats.count .. " plugins in " .. ms .. "ms"}
        end,
      },
      hide = {
        statusline = true,
        tabline = false,
        winbar = false,
      },
    })
  end,
}
