return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "kyazdani42/nvim-web-devicons",
    },
    lazy = true,
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          group_empty = true,
          icons = {
            webdev_colors = true,
          },
        },
        filters = {
          dotfiles = false,
          exclude = { ".git", "node_modules" },
        },
      })
    end,
  },
}