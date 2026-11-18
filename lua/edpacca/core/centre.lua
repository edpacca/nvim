-- centre text in wide windows by left-padding the statuscolumn

local text_width = 100 -- width of the centred block (gutter + text)
local max_pad = 38 -- nvim caps statuscolumn at ~47 cols, minus ~8 for signs + numbers
local enabled = true
local base = "%s%=%l " -- signs, right-aligned line number, space

local function is_editor_win(win)
	if vim.api.nvim_win_get_config(win).relative ~= "" then
		return false -- floats: telescope, cmp, hover
	end
	local buf = vim.api.nvim_win_get_buf(win)
	return vim.bo[buf].buftype == "" and vim.bo[buf].filetype ~= "NvimTree"
end

local function update(win)
	if not vim.api.nvim_win_is_valid(win) then
		return
	end
	local stc = ""
	if is_editor_win(win) then
		local pad = math.min(math.floor((vim.api.nvim_win_get_width(win) - text_width) / 2), max_pad)
		if enabled and pad > 0 then
			stc = string.rep(" ", pad) .. base
		end
	elseif not vim.wo[win].statuscolumn:match("^ +%%s") then
		return -- only undo padding we inherited, leave other statuscolumns alone
	end
	vim.api.nvim_set_option_value("statuscolumn", stc, { scope = "local", win = win })
end

local function update_all()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		update(win)
	end
end

vim.api.nvim_create_autocmd({ "VimEnter", "BufWinEnter", "WinNew", "WinResized", "VimResized", "FileType" }, {
	group = vim.api.nvim_create_augroup("CentreText", { clear = true }),
	callback = update_all,
})

vim.keymap.set("n", "<leader>tc", function()
	enabled = not enabled
	update_all()
end, { desc = "Toggle centred text" })
