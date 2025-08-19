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


function M.pick_sqlite_db()
  local cwd = vim.fn.getcwd()
  vim.system({ "find", cwd, "-type", "f", "-name", "*.db" }, { text = true }, function(result)
    vim.schedule(function()
      if result.code ~= 0 or result.stdout == "" then
        vim.notify("No .db files found", vim.log.levels.WARN)
        return
      end

      local db_files = vim.split(result.stdout, "\n", { trimempty = true })
      require("snacks.picker").select(db_files, { prompt = "Select SQLite DB:" }, function(choice)
        if not choice then return end

        local path = vim.fn.fnamemodify(choice, ":p")
        local uri = "sqlite:///" .. path

        -- Just show the URI
        vim.fn.setreg("+", uri)  -- copy to system clipboard
        vim.notify("Copied to clipboard:\n" .. uri, vim.log.levels.INFO)
      end)
    end)
  end)
end


return M
