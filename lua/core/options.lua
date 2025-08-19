local opt = vim.opt
local g = vim.g
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoindent = true
opt.expandtab = true
opt.smartindent = true
opt.cursorline = true
opt.wrap = true
opt.splitright = true
opt.splitbelow = true
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
if vim.fn.has("wsl") == 1 then
    g.clipboard = {
        name = "win32yank",
        copy = {
            ["+"] = "win32yank.exe -i --crlf",
            ["*"] = "win32yank.exe -i --crlf",
        },
        paste = {
            ["+"] = "win32yank.exe -o --lf",
            ["*"] = "win32yank.exe -o --lf",
        },
        cache_enabled = 0,
    }
end
