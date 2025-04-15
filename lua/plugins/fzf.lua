return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    lazy = true,
    cmd = { "FzfLua" },
    config = function()
      require("mini.icons").mock_nvim_web_devicons()
      local fzf = require("fzf-lua")
      fzf.setup({
        winopts = {
          height = 0.85,
          width = 0.85,
          border = "double",
          row = 0.3,
          col = 0.5,
          preview = {
            layout = "vertical",
            vertical = "up:60%",
          },
        },
        keymap = {
          fzf = {
            ["ctrl-u"] = "preview-half-page-up",
            ["ctrl-d"] = "preview-half-page-down",
          },
        },
        fzf_opts = {
          ["--layout"] = "reverse",
          ["--border"] = "rounded",
        },
      })
    end
  }
}