return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("kanagawa").setup({
      compile = false,
      undercurl = true,
      commentStyle = { italic = false },
      functionStyle = { italic = false },
      keywordStyle = { italic = false },
      statementStyle = { italic = false },
      typeStyle = { italic = false },
      variablebuiltinStyle = { italic = false },
      specialReturn = false,
      specialException = false,
      dimInactive = false,
      globalStatus = false,
      colors = {
        theme = {
          all = {
            ui = {
              fg = "#C5A678",
              bg = "#16161D",
              bg_p1 = "#1F1F28",
              float = "#1F1F28",
              bg_visual = "#3A3A56",
              bg_search = "#5A4A78",
              bg_cursor = "#3A3A56",
            },
          },
        },
        palette = {
          fujiWhite = "#C5A678",
          sumiInk0 = "#16161D",
          sumiInk1 = "#1F1F28",
          sumiInk2 = "#2A2A37",
        },
      },
    })
    vim.cmd("colorscheme kanagawa")
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#5C5C73", bg = "NONE" }) 
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#C5A678", bg = "NONE" }) 
  end,
}
