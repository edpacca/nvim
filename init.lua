vim.cmd("source ~/.vimrc")
require("edpacca.core")
require("edpacca.lazy")
-- load local specific config
pcall(require, "local")
