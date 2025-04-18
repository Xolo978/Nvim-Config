local M = {}

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
end

return M