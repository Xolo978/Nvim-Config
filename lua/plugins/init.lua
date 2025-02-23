local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

local function load_plugins()
  local plugins = {}
  local plugin_files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/plugins/", "*.lua", false, true)

  for _, file in ipairs(plugin_files) do
    if not file:match("plugins/init.lua$") then
      local module_name = file:match("lua/(.-)%.lua$"):gsub("/", ".")
      local ok, plugin = pcall(require, module_name)
      if ok and type(plugin) == "table" then
        table.insert(plugins, plugin)
      elseif not ok then
        vim.notify("Error loading plugin: " .. module_name .. "\n" .. plugin, vim.log.levels.ERROR)
      end
    end
  end

  return plugins
end

require("lazy").setup(load_plugins(), {
  change_detection = { notify = false, automatic = true },
})
