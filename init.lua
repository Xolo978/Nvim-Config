-- Force leader key to be set
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.init")    -- Load core settings
require("plugins.init") -- Load plugins
