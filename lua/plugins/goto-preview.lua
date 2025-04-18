return {
    "rmagatti/goto-preview",
    lazy = true,
    keys = {
      { "<leader>gpd", function() require("goto-preview").goto_preview_definition() end, desc = "Preview Definition" },
      { "<leader>gpr", function() require("goto-preview").goto_preview_references() end, desc = "Preview References" },
      { "<leader>gP", function() require("goto-preview").close_all_win() end, desc = "Close Preview Windows" },
    },
    config = function()
      require("goto-preview").setup({
        width = 80,
        height = 15,
        border = "rounded",
        default_mappings = false,
      })
    end,
  }
