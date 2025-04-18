return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    lazy = true,
    config = function()
      local blink = require("blink.cmp")
      blink.setup({
        fuzzy = {
          implementation = "lua",
        },
        appearance = {
          nerd_font_variant = "mono",
        },
        completion = {
          accept = {
            auto_brackets = {
              enabled = true,
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
          },
        },
        sources = {
          default = { "lsp", "path", "buffer" },
        },
        keymap = {
          preset = "enter",
          ["<C-y>"] = { "select_and_accept" },
        },
      })
    end,
  },
}
