-- nvim-treesitter `main` branch: only installs parsers + queries.
-- Highlighting itself is neovim's built-in vim.treesitter.start().
-- Requires tree-sitter-cli >= 0.26.1 and a C compiler on PATH.
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- does not support lazy-loading
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"bash",
			"diff",
			"gitcommit",
			"gotmpl",
			"helm",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"regex",
			"toml",
			"vim",
			"vimdoc",
			"yaml",
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("UserTreesitter", {}),
			callback = function(ev)
				-- no-op for filetypes without an installed parser
				pcall(vim.treesitter.start, ev.buf)
			end,
		})
	end,
}
