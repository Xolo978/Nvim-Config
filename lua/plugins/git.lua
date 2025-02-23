return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        numhl = true, 
        linehl = false,
        current_line_blame = true,
        current_line_blame_opts = {
          delay = 500,
          virt_text_pos = "right_align",
        },
      })
    end,
  }
}
