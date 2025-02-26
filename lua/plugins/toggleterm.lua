return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    lazy = false,
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 10
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        open_mapping = [[<leader>t]],
        shade_terminals = true,
        start_in_insert = false, -- Terminal does not open in insert mode
        direction = "horizontal",
        float_opts = {
          border = "rounded",
        },
      })
    end,
  }
}

