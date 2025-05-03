local M = {}

M.terminal = {
  buf = nil,
  win = nil,
  job_id = nil,
  is_open = false
}

function M.create_floating_terminal()
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local opts = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded"
  }

  if not M.terminal.buf or not vim.api.nvim_buf_is_valid(M.terminal.buf) then
    M.terminal.buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_option(M.terminal.buf, "bufhidden", "hide")
    vim.api.nvim_buf_set_option(M.terminal.buf, "filetype", "terminal")
  end

  if not M.terminal.win or not vim.api.nvim_win_is_valid(M.terminal.win) then
    M.terminal.win = vim.api.nvim_open_win(M.terminal.buf, true, opts)
    vim.api.nvim_win_set_option(M.terminal.win, "winblend", 0)
    vim.api.nvim_win_set_option(M.terminal.win, "winhl", "Normal:NormalFloat,FloatBorder:FloatBorder")
    vim.api.nvim_win_set_option(M.terminal.win, "cursorline", true)
    vim.api.nvim_win_set_option(M.terminal.win, "sidescrolloff", 5)
    vim.api.nvim_win_set_option(M.terminal.win, "scrolloff", 3)
  end

  if not M.terminal.job_id then
    local shell = vim.o.shell
    
    local env = vim.fn.environ()
    env.TERM = "xterm-256color"
    env.NEOVIM_TERMINAL = "1"
    env.POSH_THEME = ""
    env.POSH_DISABLED = "1"
    
    M.terminal.job_id = vim.fn.termopen(shell, {
      on_exit = function(_, _, _)
        M.terminal.job_id = nil
        if M.terminal.is_open then
          M.toggle_terminal()
        end
      end,
      env = env
    })
    vim.cmd("startinsert")
  else
    vim.cmd("startinsert")
  end

  M.terminal.is_open = true
  
  vim.api.nvim_buf_set_keymap(M.terminal.buf, "t", "<Esc>", [[<C-\><C-n>]], {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(M.terminal.buf, "t", "<C-h>", [[<C-\><C-n><C-W>h]], {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(M.terminal.buf, "t", "<C-j>", [[<C-\><C-n><C-W>j]], {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(M.terminal.buf, "t", "<C-k>", [[<C-\><C-n><C-W>k]], {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(M.terminal.buf, "t", "<C-l>", [[<C-\><C-n><C-W>l]], {noremap = true, silent = true})
  vim.api.nvim_buf_set_keymap(M.terminal.buf, "n", "q", ":lua require('core.terminal').toggle_terminal()<CR>", {noremap = true, silent = true})
end

function M.toggle_terminal()
  if M.terminal.is_open then
    if M.terminal.win and vim.api.nvim_win_is_valid(M.terminal.win) then
      vim.api.nvim_win_hide(M.terminal.win)
    end
    M.terminal.is_open = false
  else
    M.create_floating_terminal()
  end
end

function M.setup()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
      border = "rounded",
      max_width = 80,
      max_height = 20,
    }
  )
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
      border = "rounded",
      max_width = 80,
      max_height = 20,
    }
  )
  
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if not client then return end
      
      vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
      end, { buffer = bufnr, desc = "Show documentation" })
      
      vim.keymap.set("i", "<C-k>", function()
        vim.lsp.buf.signature_help()
      end, { buffer = bufnr, desc = "Show signature help" })
    end,
  })
  
  vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.cmd("startinsert")
    end,
  })
  
  vim.api.nvim_create_autocmd("VimResized", {
    pattern = "*",
    callback = function()
      if M.terminal.is_open and M.terminal.win and vim.api.nvim_win_is_valid(M.terminal.win) then
        local width = math.floor(vim.o.columns * 0.8)
        local height = math.floor(vim.o.lines * 0.8)
        local row = math.floor((vim.o.lines - height) / 2)
        local col = math.floor((vim.o.columns - width) / 2)
        
        vim.api.nvim_win_set_config(M.terminal.win, {
          relative = "editor",
          width = width,
          height = height,
          row = row,
          col = col
        })
      end
    end,
  })
  
  if package.loaded["lualine"] then
    local function terminal_name()
      local shell_name = vim.fn.fnamemodify(vim.o.shell, ":t")
      return " " .. shell_name
    end
    
    local function terminal_dir()
      local cwd = vim.fn.getcwd()
      local home = os.getenv("HOME")
      if home and cwd:sub(1, #home) == home then
        cwd = "~" .. cwd:sub(#home + 1)
      end
      return " " .. cwd
    end
    
    local function terminal_mode()
      return vim.api.nvim_get_mode().mode == "n" and "NORMAL" or "INSERT"
    end
    
    local lualine_extension = {
      sections = {
        lualine_a = { 
          { terminal_name, color = { fg = "black", bg = "#a3be8c" } }
        },
        lualine_b = { 
          { terminal_dir, color = { fg = "#eceff4", bg = "#4c566a" } }
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = { 
          { terminal_mode, color = { fg = "#eceff4", bg = "#5e81ac" } }
        },
        lualine_z = { 
          { "location", color = { fg = "#eceff4", bg = "#434c5e" } }
        }
      },
      filetypes = { "terminal" }
    }
    
    local extensions = require("lualine").get_config().extensions or {}
    table.insert(extensions, lualine_extension)
    require("lualine").setup({ extensions = extensions })
  end
end

return M