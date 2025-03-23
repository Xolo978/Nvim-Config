return {
      {
    "echasnovski/mini.icons",
    version = "*",
    config = function()
      require("mini.icons").setup()
      require("mini.icons").mock_nvim_web_devicons()
    end,
  },    
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "echasnovski/mini.icons" },
    lazy = false, 
    config = function()
      require("lualine").setup({
        options = {
          theme = "molokai",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true, 
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } }, 
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        extensions = {"toggleterm"}
      })
    end,
  }
}
