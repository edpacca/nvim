-- Bridge between nvim yanks and ~/scripts/cliphist.sh clipboard history
local M = {}

M.script = vim.fn.expand("~/scripts/cliphist.sh")

-- Send text to `cliphist.sh out`, which reads stdin, sets the system clipboard
-- and appends it to the history file. Runs async so the UI never blocks on xclip.
function M.add(text)
	if text == nil or text == "" then
		return
	end
	vim.system({ M.script, "out" }, { stdin = text }, function(res)
		if res.code ~= 0 then
			vim.schedule(function()
				vim.notify("cliphist.sh failed: " .. (res.stderr or ""), vim.log.levels.ERROR)
			end)
		end
	end)
end

-- Yank into the "+ register using `keys` (e.g. "yy" in normal, "y" in visual),
-- then push the yanked text into clipboard history.
function M.yank(keys)
	vim.cmd('normal! "+' .. keys)
	M.add(vim.fn.getreg("+"))
end

return M
