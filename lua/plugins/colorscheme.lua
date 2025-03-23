return{
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nightfox").setup({
      options = {
        transparent = false, -- No transparency
        terminal_colors = true, -- Proper terminal colors
        styles = {
          comments = "NONE", -- No italics
          keywords = "bold", -- Bold keywords
          functions = "bold",
        },
      },
    })

    vim.cmd("colorscheme duskfox") -- High contrast & colorful variant
  end,
}
