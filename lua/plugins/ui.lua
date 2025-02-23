return {
    {
      "folke/noice.nvim",
      dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
      event = "VeryLazy",
      config = function()
        require("noice").setup({
          lsp = {
            override = {
              ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
              ["vim.lsp.util.stylize_markdown"] = true,
              ["cmp.entry.get_documentation"] = true,
            },
          },
          presets = {
            command_palette = true, 
            long_message_to_split = true, 
            inc_rename = true, 
            lsp_doc_border = true,
          },
        })
      end,
    },
    {
      "rcarriga/nvim-notify",
      lazy = false,
      config = function()
        vim.notify = require("notify")
        require("notify").setup({
          background_colour = "#000000",
          render = "minimal",
          stages = "slide",
          timeout = 3000,
        })
      end,
    }
  }