-- Telescope file sorter with IDE-style "initials" matching.
-- An all-caps prompt (e.g. "MTF") matches filenames whose segment initials contain
-- the prompt as a contiguous run (MyTestFile.py, my_big_test_file.py via "BTF"),
-- ranked above a case-insensitive fzf fallback. Any other prompt is plain fzf.
local M = {}

-- split a name into snake/kebab/dot/camel/Pascal segments
-- returns lowercased initials string + 1-based byte positions of each initial
function M.segment_initials(name)
	local initials, positions = {}, {}
	for i = 1, #name do
		local c, prev, nxt = name:sub(i, i), name:sub(i - 1, i - 1), name:sub(i + 1, i + 1)
		if c:match("%w") then
			local is_start = i == 1
				or not prev:match("%w") -- after _ - . etc
				or (prev:match("[%l%d]") and c:match("%u")) -- myTest
				or (prev:match("%u") and c:match("%u") and nxt:match("%l")) -- HTTPServer
			if is_start then
				table.insert(initials, c:lower())
				table.insert(positions, i)
			end
		end
	end
	return table.concat(initials), positions
end

-- prompt of 2+ capitals (e.g. "MTF") => initials mode
function M.is_initials_prompt(prompt)
	return prompt:match("^%u%u+$") ~= nil
end

-- wraps the configured (fzf) file sorter
function M.sorter(opts)
	local sorter = require("telescope.config").values.file_sorter(opts)
	local fzf_score, fzf_highlight = sorter.scoring_function, sorter.highlighter
	sorter.discard = false -- switching modes mid-typing must not drop entries

	sorter.scoring_function = function(self, prompt, line, ...)
		if not M.is_initials_prompt(prompt) then
			return fzf_score(self, prompt, line, ...)
		end
		local query = prompt:lower()
		local initials = M.segment_initials(line:match("[^/]+$") or line)
		local at = initials:find(query, 1, true) -- contiguous run of segments
		if at then
			-- below any fzf score; earlier match first, then fewer leftover segments
			return 1e-6 * ((at - 1) * 100 + (#initials - #query + 1))
		end
		return fzf_score(self, query, line, ...)
	end

	sorter.highlighter = function(self, prompt, display)
		if not M.is_initials_prompt(prompt) then
			return fzf_highlight(self, prompt, display)
		end
		local query = prompt:lower()
		-- display is "<icon> filename dir" (filename_first): check each token
		for start, token in display:gmatch("()(%S+)") do
			local initials, positions = M.segment_initials(token)
			local at = initials:find(query, 1, true)
			if at then
				local hl = {}
				for i = 1, #query do
					hl[i] = start - 1 + positions[at + i - 1]
				end
				return hl
			end
		end
		return fzf_highlight(self, query, display)
	end

	return sorter
end

return M
