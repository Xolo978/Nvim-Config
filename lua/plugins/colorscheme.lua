return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background of inactive window
          shade = "dark",
          percentage = 0.15, -- percentage of the shade to apply to the background
        },
        no_italic = true, -- Force no italic
        no_bold = false, -- Force no bold
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`)
          comments = {}, -- Remove "NONE" to force no italic
          conditionals = {},
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        color_overrides = {},
        custom_highlights = {},
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          lsp_trouble = true,
          telescope = true,
          notify = false,
          mini = false,
          -- For more plugins integrations please scroll down (LSP section)
        },
      })

      vim.cmd("colorscheme catppuccin")
    end,
  },
}