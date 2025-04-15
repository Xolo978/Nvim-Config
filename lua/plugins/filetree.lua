return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "echasnovski/mini.icons",
    },
    lazy = true,
    cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
    config = function()
      local width = 60
      local height = 20
      
      require("nvim-tree").setup({
        view = {
          width = width,
          side = "left",
          float = {
            enable = true,
            open_win_config = function()
              local screen_w = vim.api.nvim_list_uis()[1].width
              local screen_h = vim.api.nvim_list_uis()[1].height
              
              local window_w = width
              local window_h = height
              local window_w_int = window_w
              local window_h_int = window_h
              local center_x = (screen_w - window_w_int) / 2
              local center_y = (screen_h - window_h_int) / 4
              
              return {
                border = "rounded",
                relative = "editor",
                row = center_y,
                col = center_x,
                width = window_w_int,
                height = window_h_int,
              }
            end,
          },
        },
        renderer = {
          group_empty = true,
          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
        filters = {
          dotfiles = false,
          exclude = { ".git", "node_modules" },
        },
        hijack_netrw = false,
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")
          
          api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set('n', 'q', api.tree.close, 
            { desc = 'Close', buffer = bufnr, noremap = true, silent = true })
        end,
      })
    end,
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "echasnovski/mini.icons" },
    lazy = true,
    keys = {
      { "<leader>o", function() require("oil").open() end, desc = "Open directory in Oil" },
      { "<leader>fo", function() require("oil").open_float() end, desc = "Open Oil in float window" },
    },
    config = function()
      require("mini.icons").mock_nvim_web_devicons()
      
      require("oil").setup({
        default_file_explorer = true,
        float = {
          padding = 2,
          max_width = 60,
          max_height = 20,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-s>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-l>"] = "actions.preview",
          ["<Leader>h"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["<BS>"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
        },
        
        view_options = {
          show_hidden = false,
          is_always_hidden = function(name)
            return name == ".." or name == ".git"
          end,
        },
        
        columns = {
          "icon",
          "git",
        },
      })
      
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "oil",
        callback = function()
          vim.b.is_oil_buffer = true
        end,
      })
      
      vim.api.nvim_create_autocmd("User", {
        pattern = "OilEnter",
        callback = function()
          vim.b.directory_managed_by_oil = true
        end,
      })
    end,
  },
}