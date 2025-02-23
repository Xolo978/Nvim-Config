local map = vim.keymap.set

-- Save file quickly
map("n", "<leader>w", ":w<CR>", { desc = "Save File", silent = true })

-- Close buffer
map("n", "<leader>q", ":q<CR>", { desc = "Quit Neovim", silent = true })

-- Open file explorer (assuming nvim-tree is installed)
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer", silent = true })

-- Fuzzy finder (assuming fzf-lua is installed)
map("n", "<leader>ff", ":FzfLua files<CR>", { desc = "Find Files", silent = true })
map("n", "<leader>fg", ":FzfLua live_grep<CR>", { desc = "Live Grep", silent = true })

-- Buffer Navigation
map("n", "<leader>bn", ":bnext<CR>", { desc = "Next Buffer", silent = true })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous Buffer", silent = true })

-- Clear search highlight
map("n", "<leader>h", ":nohlsearch<CR>", { desc = "Clear Highlight", silent = true })

-- Clipboard Shortcuts
map({ "n", "v", "i" }, "<C-a>", "<Esc>ggVG", { desc = "Select All" })
map({ "n", "v" }, "<C-c>", '"+y', { desc = "Copy to Clipboard" })
map({ "n", "v" }, "<C-x>", '"+d', { desc = "Cut to Clipboard" })
map({ "n", "v", "i" }, "<C-v>", '"+p', { desc = "Paste from Clipboard" })

-- Git
map("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open LazyGit", silent = true })

-- Commenting
map("n", "<C-_>", "gcc", { desc = "Toggle Comment", remap = true, silent = true })
map("v", "<C-_>", "gc", { desc = "Toggle Comment (Selection)", remap = true, silent = true })

-- Window Navigation
map("n", "<C-h>", function()
  if vim.bo.filetype == "NvimTree" then
    vim.cmd("wincmd l")
  else
    vim.cmd("wincmd h")
  end
end, { desc = "Switch Between Explorer & Editor", silent = true })

-- Resize Window
map("n", "<C-Left>", ":vertical resize -5<CR>", { desc = "Decrease Window Width", silent = true })
map("n", "<C-Right>", ":vertical resize +5<CR>", { desc = "Increase Window Width", silent = true })

-- LSP Keymaps
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show Diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

--BufferLine Keymaps
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next Tab", silent = true })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous Tab", silent = true })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Close Current Tab", silent = true })
