local opt = vim.opt
local g = vim.g
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true
opt.cursorline = true
opt.wrap = false
opt.splitright = true
opt.splitbelow = true

if vim.fn.has("wsl") == 1 then
    g.clipboard = {
        name = "win32yank",
        copy = {
            ["+"] = "win32yank -i --crlf",
            ["*"] = "win32yank -i --crlf",
        },
        paste = {
            ["+"] = "win32yank -o --lf",
            ["*"] = "win32yank -o --lf",
        },
        cache_enabled = 0,
    }
end
