-- Minimal init for the test suite: this config's lua/ + only the plugins tests need.
-- Avoids loading the full config (lazy update checker, LSPs, UI plugins).
local config_dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h:h")
local lazy_dir = vim.fn.stdpath("data") .. "/lazy"

vim.opt.rtp:prepend(config_dir)
for _, plugin in ipairs({ "plenary.nvim", "telescope.nvim", "telescope-fzf-native.nvim" }) do
	local path = lazy_dir .. "/" .. plugin
	if not vim.uv.fs_stat(path) then
		error("missing plugin for tests: " .. path .. " (open nvim once so lazy installs it)")
	end
	vim.opt.rtp:append(path)
end

vim.cmd("runtime plugin/plenary.vim") -- defines :PlenaryBustedDirectory

require("telescope").setup({})
require("telescope").load_extension("fzf")
