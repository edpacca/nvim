vim.cmd("source ~/.vimrc")
require("edpacca.core")
require("edpacca.lazy")
-- load local specific config
pcall(dofile, vim.fn.expand("~/.host/nvim.lua"))
