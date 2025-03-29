return {
  "stevearc/resession.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false,
  config = function()
    local resession = require("resession")
    local session_dir = vim.fn.stdpath("state") .. "/resession"
    local workspace_dir = session_dir .. "/workspaces"
    if vim.fn.isdirectory(session_dir) == 0 then
      vim.fn.mkdir(session_dir, "p")
    end
    
    if vim.fn.isdirectory(workspace_dir) == 0 then
      vim.fn.mkdir(workspace_dir, "p")
    end
    
    resession.setup({
      autosave = {
        enable = true,
        interval = 60,
      },
      tab_sessions = true,
      dir = session_dir,
      buf_filter = function(bufnr)
        local ok = true
        ok = ok and vim.api.nvim_buf_is_valid(bufnr)
        ok = ok and vim.bo[bufnr].buflisted
        return ok
      end,
    })
    
    local map = vim.keymap.set
    
    map("n", "<leader>ss", resession.load, { desc = "Load Last Session" })
    map("n", "<leader>sw", resession.save, { desc = "Save Current Session" })
    
    map("n", "<leader>sl", function()
      require("fzf-lua").files({
        prompt = "Load Session > ",
        cwd = session_dir,
        actions = {
          ["default"] = function(selected)
            local session = selected[1]
            if session then
              -- Extract just the filename without path
              local filename = vim.fn.fnamemodify(session, ":t")
              resession.load(filename)
            end
          end,
        },
      })
    end, { desc = "Search Sessions", silent = true })
    
    map("n", "<leader>sd", function()
      vim.ui.select(resession.list(), {
        prompt = "Delete Session: ",
      }, function(choice)
        if choice then
          resession.delete(choice)
        end
      end)
    end, { desc = "Delete a Session" })
    
    map("n", "<leader>ws", function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      resession.save(dir_name, { dir = "workspaces" })
      vim.notify("Workspace '" .. dir_name .. "' saved", vim.log.levels.INFO)
    end, { desc = "Save Workspace" })
    
    map("n", "<leader>wl", function()
      local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      if vim.fn.filereadable(workspace_dir .. "/" .. dir_name) == 1 then
        resession.load(dir_name, { dir = "workspaces" })
      else
        vim.notify("No workspace for " .. dir_name, vim.log.levels.WARN)
      end
    end, { desc = "Load Current Workspace" })
    
    map("n", "<leader>wf", function()
      vim.ui.select(resession.list({ dir = "workspaces" }), {
        prompt = "Select Workspace: ",
      }, function(choice)
        if choice then
          resession.load(choice, { dir = "workspaces" })
        end
      end)
    end, { desc = "Find Workspace" })
    map("n", "<leader>wr", function()
      vim.ui.input({ prompt = "Rename Workspace: " }, function(new_name)
        if new_name then
          resession.rename(new_name, { dir = "workspaces" })
          vim.notify("Workspace renamed to '" .. new_name .. "'", vim.log.levels.INFO)
        end
      end)
    end, { desc = "Rename Workspace" })
    map("n", "<leader>wd", function()
      vim.ui.select(resession.list({ dir = "workspaces" }), {
        prompt = "Delete Workspace: ",
      }, function(choice)
        if choice then
          vim.ui.select({ "Yes", "No" }, {
            prompt = "Delete workspace '" .. choice .. "'?",
          }, function(confirm)
            if confirm == "Yes" then
              resession.delete(choice, { dir = "workspaces" })
              vim.notify("Workspace '" .. choice .. "' deleted", vim.log.levels.INFO)
            end
          end)
        end
      end)
    end, { desc = "Delete Workspace" })
  end,
}