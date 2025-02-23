return {
    {
      "SmiteshP/nvim-navic",
      lazy = false,
      dependencies = { "neovim/nvim-lspconfig" },
      config = function()
        require("nvim-navic").setup({
          highlight = true,
          separator = "  ",
          depth_limit = 5,
          icons = {
            File = " ",
            Module = " ",
            Namespace = " ",
            Package = " ",
            Class = " ",
            Method = " ",
            Property = " ",
            Field = " ",
            Constructor = " ",
            Enum = " ",
            Interface = " ",
            Function = " ",
          },
        })
      end,
    }
  }
  