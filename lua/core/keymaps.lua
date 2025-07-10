local map = vim.keymap.set

-- =============================
--  Essential Keybindings
-- =============================

-- Save file quickly
map("n", "<C-w>", ":w<CR>", { desc = "Save File", silent = true })

-- Close buffer
map("n", "<leader>q", ":q<CR>", { desc = "Quit Neovim", silent = true })

-- Open file explorer
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle File Explorer", silent = true })

-- Clear search highlight
map("n", "<leader>p", ":nohlsearch<CR>", { desc = "Clear Highlight", silent = true })

-- =============================
--  Fuzzy Finder (FZF)
-- =============================

map("n", "<leader>ff", ":FzfLua files<CR>", { desc = "Find Files", silent = true })
map("n", "<leader>fg", ":FzfLua live_grep<CR>", { desc = "Live Grep", silent = true })
map("n", "<leader>fs", function()
  require("fzf-lua").lines({
    prompt = "Find in File> ",
  })
end, { desc = "Find in Current File", silent = true })

local ns_id = vim.api.nvim_create_namespace("find_replace_highlight")

local function highlight_matches(pattern)
  vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1) -- Clear old highlights

  if pattern and pattern ~= "" then
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for row, line in ipairs(lines) do
      local start_idx, end_idx = line:find(pattern)
      while start_idx do
        vim.api.nvim_buf_add_highlight(0, ns_id, "Search", row - 1, start_idx - 1, end_idx)
        start_idx, end_idx = line:find(pattern, end_idx + 1)
      end
    end
  end
end

-- Floating Find-and-Replace
function FloatingFindAndReplace()
  require("snacks.input").input({
    prompt = "Find: ",
    on_change = highlight_matches
  }, function(find_text)
    vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1) -- Clear highlight after selecting

    if not find_text or find_text == "" then return end

    require("snacks.input").input({ prompt = "Replace: " }, function(replace_text)
      if replace_text == nil then return end

      -- Perform find-and-replace in the current buffer
      vim.cmd('%s/' .. vim.fn.escape(find_text, '/') .. '/' .. vim.fn.escape(replace_text, '/') .. '/g')
    end)
  end)
end

-- Keybinding for find-and-replace
map("n", "<leader>fr", FloatingFindAndReplace, { desc = "Find and Replace in Current File", silent = true })

-- =============================
--  Buffer Navigation
-- =============================

map("n", "<leader>bn", ":bnext<CR>", { desc = "Next Buffer", silent = true })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous Buffer", silent = true })

-- =============================
--  Clipboard Shortcuts
-- =============================

map({ "n", "v" }, "<C-c>", '"+y', { desc = "Copy to Clipboard" })
map({ "n", "v" }, "<C-x>", '"+d', { desc = "Cut to Clipboard" })
map({ "n", "v" }, "<C-v>", '"+p', { desc = "Paste from Clipboard" })

-- =============================
--  Git
-- =============================

map("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open LazyGit", silent = true })

-- =============================
--  Commenting (Comment.nvim)
-- =============================

map("n", "<C-_>", "gcc", { desc = "Toggle Comment", remap = true, silent = true })
map("v", "<C-_>", "gc", { desc = "Toggle Comment (Selection)", remap = true, silent = true })

-- =============================
--  Window Management
-- =============================

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

-- =============================
--  LSP Keymaps
-- =============================

map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Find References" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show Diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

-- =============================
-- Bufferline (Tabs)
-- =============================

map("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next Tab", silent = true })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous Tab", silent = true })
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Close Current Tab", silent = true })


map("n", "<C-a>", "ggVG", { desc = "Select All", silent = true })
map("v", "<C-a>", "<Esc>ggVG", { desc = "Select All", silent = true })


-- =============================
-- 🛠️ Linting Keymaps (nvim-lint)
-- =============================

-- Manually trigger linting
map("n", "<leader>ll", function()
  require("lint").try_lint()
end, { desc = "Run Linter", silent = true })


-- =============================
-- Formatting Keymaps (conform.nvim)
-- =============================

-- Manually format file
map("n", "<leader>lf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format File", silent = true })

-- Format selection in Visual mode
map("v", "<leader>lf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format Selection", silent = true })

-- =============================
--  Move Line Up/Down (Alt + Up/Down)
-- =============================

-- Move current line up
map("n", "<C-Up>", ":m .-2<CR>==", { desc = "Move Line Up", silent = true })
map("v", "<C-Up>", ":m '<-2<CR>gv=gv", { desc = "Move Selection Up", silent = true })
map("i", "<C-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move Line Up", silent = true })

-- Move current line down
map("n", "<C-Down>", ":m .+1<CR>==", { desc = "Move Line Down", silent = true })
map("v", "<C-Down>", ":m '>+1<CR>gv=gv", { desc = "Move Selection Down", silent = true })
map("i", "<C-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move Line Down", silent = true })

-- Split Creation
map("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical Split", silent = true })
map("n", "<leader>sh", ":split<CR>", { desc = "Horizontal Split", silent = true })

-- Navigate Between Splits
map("n", "<leader><Leftq", "<C-w>h", { desc = "Move Left", silent = true })
map("n", "<leader><Down>", "<C-w>j", { desc = "Move Down", silent = true })
map("n", "<leader><Up>", "<C-w>k", { desc = "Move Up", silent = true })
map("n", "<leader><Right>", "<C-w>l", { desc = "Move Right", silent = true })



-- Resize Splits
map("n", "<A-Up>", ":resize +2<CR>", { desc = "Increase Height", silent = true })
map("n", "<A-Down>", ":resize -2<CR>", { desc = "Decrease Height", silent = true })
map("n", "<A-Left>", ":vertical resize -5<CR>", { desc = "Decrease Width", silent = true })
map("n", "<A-Right>", ":vertical resize +5<CR>", { desc = "Increase Width", silent = true })

-- Equalize Splits
map("n", "<leader>se", "<C-w>=", { desc = "Equalize Split Sizes", silent = true })

-- Close Current Split
map("n", "<leader>sx", ":close<CR>", { desc = "Close Current Split", silent = true })

-- Swap Windows (rotate layout)
map("n", "<leader>sr", "<C-w>r", { desc = "Rotate Splits", silent = true })

-- Move current buffer to other split
map("n", "<leader>smh", "<C-w>H", { desc = "Move Buffer to Left Split", silent = true })
map("n", "<leader>smj", "<C-w>J", { desc = "Move Buffer to Below Split", silent = true })
map("n", "<leader>smk", "<C-w>K", { desc = "Move Buffer to Above Split", silent = true })
map("n", "<leader>sml", "<C-w>L", { desc = "Move Buffer to Right Split", silent = true })

-- Maximize/Minimize Toggle (requires 'szw/vim-maximizer' or write your own logic)
map("n", "<leader>sm", ":MaximizerToggle<CR>", { desc = "Toggle Maximize Split", silent = true })

map("n", "<leader>rr", function()
  dofile(vim.fn.stdpath("config") .. "/init.lua")
  vim.notify("🔄 Reloaded Neovim config", vim.log.levels.INFO)
end, { desc = "Reload Neovim Config", silent = true })




