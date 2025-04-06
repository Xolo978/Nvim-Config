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
        return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
      end,
    })

    local map = vim.keymap.set

    
    map("n", "<leader>ss", function() resession.load() end, { desc = "Load Last Session" })
    map("n", "<leader>sw", function() resession.save() end, { desc = "Save Current Session" })

    
    map("n", "<leader>sl", function()
      local sessions = resession.list()
      if #sessions == 0 then
        vim.notify("No saved sessions found", vim.log.levels.WARN)
        return
      end
      vim.ui.select(sessions, { prompt = "Load Session: " }, function(choice)
        if choice then
          resession.load(choice)
        end
      end)
    end, { desc = "Search Sessions" })

    
    map("n", "<leader>sd", function()
      local sessions = resession.list()
      if #sessions == 0 then
        vim.notify("No saved sessions to delete", vim.log.levels.WARN)
        return
      end
      vim.ui.select(sessions, { prompt = "Delete Session: " }, function(choice)
        if choice then
          resession.delete(choice)
          vim.notify("Deleted session: " .. choice, vim.log.levels.INFO)
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
      local workspace_path = workspace_dir .. "/" .. dir_name
      if vim.fn.filereadable(workspace_path) == 1 then
        resession.load(dir_name, { dir = "workspaces" })
      else
        vim.notify("No workspace session found for " .. dir_name, vim.log.levels.WARN)
      end
    end, { desc = "Load Current Workspace" })

    
    map("n", "<leader>wf", function()
      local workspaces = resession.list({ dir = "workspaces" })
      if #workspaces == 0 then
        vim.notify("No saved workspaces found", vim.log.levels.WARN)
        return
      end
      vim.ui.select(workspaces, { prompt = "Select Workspace: " }, function(choice)
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
      local workspaces = resession.list({ dir = "workspaces" })
      if #workspaces == 0 then
        vim.notify("No saved workspaces to delete", vim.log.levels.WARN)
        return
      end
      vim.ui.select(workspaces, { prompt = "Delete Workspace: " }, function(choice)
        if choice then
          vim.ui.select({ "Yes", "No" }, { prompt = "Delete workspace '" .. choice .. "'?" }, function(confirm)
            if confirm == "Yes" then
              resession.delete(choice, { dir = "workspaces" })
              vim.notify("Workspace '" .. choice .. "' deleted", vim.log.levels.INFO)
            end
          end)
        end
      end)
    end, {desc = "Delete Workspace" })
  end,
}
