vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "lua/plugins/*.lua",
  callback = function()
    vim.cmd("source ~/.config/nvim/init.lua | Lazy sync")
  end,
})

local function open(data)
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
      return
  end

  vim.cmd.cd(data.file)
  local api = require("nvim-tree.api")
  pcall(api.tree.close)
  api.tree.toggle({
    focus = true,
    find_file = false,
  })
  
  vim.defer_fn(function()
    if api.tree.is_tree_buf() then
      api.tree.reload()
    end
  end, 10)
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open })

local macro_recording_notification = nil

vim.api.nvim_create_autocmd("RecordingEnter", {
callback = function()
  local register = vim.fn.reg_recording()
  if register ~= "" then
    macro_recording_notification = vim.notify("Recording macro @" .. register, "info", {
      title = "Macro Recording Started",
      icon = "󰑋",
      timeout = false,
    })
  end
end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
callback = function()
  if macro_recording_notification then
    macro_recording_notification = vim.notify("Macro recording finished", "info", {
      title = "Macro Recording Ended",
      icon = "✓",
      replace = macro_recording_notification,
      timeout = 3000,
    })
  end
end,
})