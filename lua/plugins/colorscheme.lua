return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Best suited for dark cyber themes
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = true, 
        show_end_of_buffer = false,
        term_colors = true, 
        dim_inactive = {
          enabled = true,
          shade = "dark",
          percentage = 0.1, -- Slight dim for inactive windows
        },
        no_italic = true, -- No italics for a sharper look
        no_bold = false,

        color_overrides = {
          mocha = {
            base = "#000000", -- True black background
            mantle = "#0a0a0a",
            crust = "#111111",
            text = "#00ffff", -- Neon Cyan
            subtext1 = "#ff00ff", -- Magenta accents
            subtext0 = "#ff8800", -- Bright orange
            overlay2 = "#ff00ff",
            overlay1 = "#00ff00", -- Neon Green for Matrix-style comments
            overlay0 = "#8800ff",
            surface2 = "#00ffff",
            surface1 = "#ff0033", -- Bright red
            surface0 = "#0088ff", -- Electric blue
            lavender = "#bb00ff",
            blue = "#0088ff",
            green = "#00ff00",
            yellow = "#ffff00",
            peach = "#ff8800",
            red = "#ff0033",
            mauve = "#bb00ff",
            pink = "#ff00ff",
          },
        },

        custom_highlights = function(colors)
          return {
            Normal = { fg = colors.text, bg = "NONE" }, -- Remove any background
            Comment = { fg = colors.green, italic = false }, -- Neon green comments
            ["@variable"] = { fg = colors.blue }, -- Bright electric blue variables
            ["@property"] = { fg = colors.pink, bold = true }, -- Magenta properties
            ["@keyword"] = { fg = colors.peach, bold = true }, -- Bright orange keywords
            ["@function"] = { fg = colors.mauve, bold = true }, -- Purple neon functions
            ["@number"] = { fg = colors.red, bold = true }, -- Bright red numbers
            ["@boolean"] = { fg = colors.yellow, bold = true }, -- Neon yellow booleans
          }
        end,

        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          lsp_trouble = true,
          telescope = true,
          notify = true, -- Enable notifications
          mini = false,
        },
      })

      vim.cmd("colorscheme catppuccin")    end,
  },

  
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        variant = "auto",
        transparent = true,
        italic_comments = false,
      })
    end,
  },
}
