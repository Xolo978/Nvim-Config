return {
    {
      "numToStr/Comment.nvim",
        lazy = false,
        keys = { "gcc", "gcb", "gc", "gb" },
      config = function()
        require("Comment").setup({
          toggler = {
            line = "gcc", 
            block = "gcb", 
          },
          opleader = {
            line = "gc", 
            block = "gb", 
          },
        })
      end,
    }
  }
  