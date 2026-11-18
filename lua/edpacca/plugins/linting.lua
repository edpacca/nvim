return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")
		local pyci = require("edpacca.core.pyci")

		-- venv binaries; cmd is evaluated with cwd set to the repo root
		for _, tool in ipairs({ "flake8", "pylint", "mypy" }) do
			lint.linters[tool].cmd = function()
				return pyci.bin(vim.fn.getcwd(), tool)
			end
		end

		-- only run linters whose binary exists (venv or PATH), else nvim-lint throws ENOENT
		local function lint_python(names)
			local root = pyci.root()
			local available = vim.tbl_filter(function(tool)
				return vim.fn.executable(pyci.bin(root, tool)) == 1
			end, names)
			if #available > 0 then
				lint.try_lint(available, { cwd = root })
			end
		end

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				if vim.bo.filetype == "python" then
					lint_python({ "flake8" })
				end
			end,
		})

		-- slow linters: on open and save (they read the file from disk, so not on edit)
		vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
			group = lint_augroup,
			pattern = "*.py",
			callback = function()
				lint_python({ "pylint", "mypy" })
			end,
		})

		-- vim.keymap.set("n", "<leader>l", function()
		-- 	lint.try_lint()
		-- end, { desc = "Trigger linting for current file" })
	end,
}
