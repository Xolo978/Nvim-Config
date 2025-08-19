return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    lazy = true,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { 
          "lua", "python", "javascript", "typescript", "tsx", "json", "c", "cpp", "sql" 
        },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
      })
    end,
  }
}