-- lua/core/autocmds.lua
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "lua/plugins/*.lua",
    callback = function()
      vim.cmd("source ~/.config/nvim/init.lua | Lazy sync")
    end,
  })
  