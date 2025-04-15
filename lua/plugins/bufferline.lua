return {
    {
      "akinsho/bufferline.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = true,
        event = "BufWinEnter",
      config = function()
        require("bufferline").setup({
          options = {
            mode = "buffers",
            numbers = "ordinal",
            separator_style = "thick",
            always_show_bufferline = true,
            show_buffer_close_icons = true,
            show_close_icon = false,
            color_icons = true,
            diagnostics = "nvim_lsp",
            diagnostics_indicator = function(count, level, _, _)
              local icon = level:match("error") and " " or " "
              return " " .. icon .. count
            end,
            offsets = {
              {
                filetype = "NvimTree",
                text = "📁 File Explorer",
                highlight = "Directory",
                text_align = "left",
              },
            },
            indicator = {
              style = "underline", 
            },
            modified_icon = "●", 
          },
          highlights = {
            buffer_selected = {
              fg = "#ffffff",
              bold = true,
              italic = false,
            },
            buffer_visible = {
              fg = "#c0c0c0",
            },
            separator_selected = {
              fg = "#ff007c",
            },
            separator_visible = {
              fg = "#5c6370",
            },
          },
        })
  
        vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next Tab", silent = true })
        vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous Tab", silent = true })
        vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Close Current Tab", silent = true })
      end,
    }
  }
  
