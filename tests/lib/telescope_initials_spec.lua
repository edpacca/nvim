local initials = require("edpacca.lib.telescope_initials")

describe("segment_initials", function()
	local cases = {
		{ "my_test_file.py", "mtfp" },
		{ "MyTestFile.py", "mtfp" },
		{ "myTestFile.py", "mtfp" },
		{ "my-test-file.lua", "mtfl" },
		{ "HTTPServerThing.go", "hstg" },
		{ "parseJSON.ts", "pjt" },
		{ "v2Parser.py", "vpp" },
		{ "__init__.py", "ip" },
		{ "Makefile", "m" },
	}
	for _, case in ipairs(cases) do
		it(case[1] .. " -> " .. case[2], function()
			assert.are.equal(case[2], (initials.segment_initials(case[1])))
		end)
	end

	it("returns byte positions of each initial", function()
		local _, positions = initials.segment_initials("my_test_file.py")
		assert.are.same({ 1, 4, 9, 14 }, positions)
	end)
end)

describe("is_initials_prompt", function()
	it("needs 2+ capitals only", function()
		assert.is_true(initials.is_initials_prompt("MTF"))
		assert.is_true(initials.is_initials_prompt("TF"))
		assert.is_false(initials.is_initials_prompt("M"))
		assert.is_false(initials.is_initials_prompt("mtf"))
		assert.is_false(initials.is_initials_prompt("MTf"))
		assert.is_false(initials.is_initials_prompt("MT F"))
		assert.is_false(initials.is_initials_prompt(""))
	end)
end)

describe("sorter", function()
	local sorter

	before_each(function()
		sorter = initials.sorter()
		sorter:_init()
	end)

	after_each(function()
		sorter:_destroy()
	end)

	local function score(prompt, line)
		return sorter:scoring_function(prompt, line)
	end

	it("matches initials regardless of naming style", function()
		for _, line in ipairs({ "src/MyTestFile.py", "src/my_test_file.py", "src/my-test-file.py" }) do
			assert.is_true(score("MTF", line) > 0, line)
		end
	end)

	it("matches contiguous segment runs anywhere in the name", function()
		local line = "src/my_big_test_file.py"
		for _, prompt in ipairs({ "MBT", "BT", "BTF", "TF" }) do
			assert.is_true(score(prompt, line) > 0, prompt)
		end
	end)

	it("only uses the filename for initials, not the directories", function()
		-- dir initials only reach the (lower ranked) fuzzy fallback
		assert.is_true(score("MD", "x/my_dir.lua") < score("MD", "my_dir/other.lua"))
	end)

	it("ranks initials matches above the fuzzy fallback", function()
		assert.is_true(score("MTF", "src/my_test_file.py") < score("MTF", "a/mtf.lua"))
	end)

	it("falls back to case-insensitive fuzzy when initials skip a segment", function()
		local s = score("MTF", "src/my_big_test_file.py")
		assert.is_true(s > 0)
		assert.is_true(s > score("MBT", "src/my_big_test_file.py"))
	end)

	it("ranks a match at the start above one later in the name", function()
		assert.is_true(score("TF", "src/TestFile.py") < score("TF", "src/my_big_test_file.py"))
	end)

	it("ranks fewer leftover segments higher", function()
		assert.is_true(score("MTF", "my_test_file.py") < score("MTF", "my_test_file_extra.py"))
	end)

	it("filters out non-matches", function()
		assert.are.equal(-1, score("MTF", "lua/other.lua"))
	end)

	it("leaves lowercase prompts to plain fzf", function()
		local fzf = require("telescope.config").values.file_sorter()
		fzf:_init()
		assert.are.equal(fzf:scoring_function("mtf", "src/my_test_file.py"), score("mtf", "src/my_test_file.py"))
		fzf:_destroy()
	end)

	it("highlights the matched initials in the display", function()
		-- display as rendered with filename_first + devicon prefix
		assert.are.same({ 6, 10, 15 }, sorter:highlighter("BTF", "  my_big_test_file.py src"))
	end)
end)
