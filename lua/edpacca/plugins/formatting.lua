return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		local pyci = require("edpacca.core.pyci")

		-- venv binaries, run from the repo root so project config is found
		for _, tool in ipairs({ "isort", "black", "docformatter" }) do
			conform.formatters["ci_" .. tool] = {
				inherit = tool,
				command = function(_, ctx)
					return pyci.bin(pyci.root(ctx.buf), tool)
				end,
				cwd = function(_, ctx)
					return pyci.root(ctx.buf)
				end,
				require_cwd = false,
			}
		end
		conform.formatters.ci_isort.prepend_args = { "--profile", "black" }

		conform.setup({
			formatters_by_ft = {
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				lua = { "stylua" },
				python = { "ci_isort", "ci_black" }, -- add "ci_docformatter" if wanted
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 5000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<S-M-f>", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
