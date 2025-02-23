return {
    {
      "numToStr/Comment.nvim",
        lazy = false,
        keys = { "gcc", "gcb", "gc", "gb" },
      config = function()
        require("Comment").setup({
          toggler = {
            line = "gcc", -- Toggle comment on current line
            block = "gcb", -- Toggle block comment
          },
          opleader = {
            line = "gc", -- Toggle comment on selection
            block = "gb", -- Toggle block comment on selection
          },
        })
      end,
    }
  }
  