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

	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open })
