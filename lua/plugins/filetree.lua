return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "echasnovski/mini.icons",
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
      },
      filters = {
        dotfiles = false,
        exclude = { ".git", "node_modules" },
      },
      hijack_netrw = true,
    })
  end,
}

