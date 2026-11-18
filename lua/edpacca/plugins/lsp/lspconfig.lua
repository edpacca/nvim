return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				vim.keymap.set(
					"n",
					"gR",
					"<cmd>Telescope lsp_references<CR>",
					{ buffer = ev.buf, silent = true, desc = "Show LSP references" }
				)
				vim.keymap.set(
					"n",
					"gD",
					vim.lsp.buf.declaration,
					{ buffer = ev.buf, silent = true, desc = "Go to declaration" }
				)
				vim.keymap.set(
					"n",
					"gd",
					"<cmd>Telescope lsp_definitions<CR>",
					{ buffer = ev.buf, silent = true, desc = "Show LSP definitions" }
				)
				vim.keymap.set(
					"n",
					"gi",
					"<cmd>Telescope lsp_implementations<CR>",
					{ buffer = ev.buf, silent = true, desc = "Show LSP implementations" }
				)
				vim.keymap.set(
					"n",
					"gt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					{ buffer = ev.buf, silent = true, desc = "Show LSP type definitions" }
				)
				vim.keymap.set(
					{ "n", "v" },
					"<leader>;",
					vim.lsp.buf.code_action,
					{ buffer = ev.buf, silent = true, desc = "See available code actions" }
				)
				vim.keymap.set(
					"n",
					"<leader>rn",
					vim.lsp.buf.rename,
					{ buffer = ev.buf, silent = true, desc = "Smart rename" }
				)
				vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", {
					buffer = ev.buf,
					silent = true,
					desc = "Show buffer diagnostics",
				})
				vim.keymap.set(
					"n",
					"<leader>d",
					vim.diagnostic.open_float,
					{ buffer = ev.buf, silent = true, desc = "Show line diagnostics" }
				)
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1 })
				end, { buffer = ev.buf, silent = true, desc = "Go to previous diagnostic" })
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1 })
				end, { buffer = ev.buf, silent = true, desc = "Go to next diagnostic" })
				vim.keymap.set(
					"n",
					"<leader>rs",
					":LspRestart<CR>",
					{ buffer = ev.buf, silent = true, desc = "Restart LSP" }
				)
			end,
		})

		-- basedpyright: hover/navigation/completion/semantic tokens/implementations
		-- + import and undefined-name errors only.
		-- Type checking is mypy's job (via nvim-lint), so it is switched off here.
		vim.lsp.config("basedpyright", {
			capabilities = capabilities,
			settings = {
				python = {},
				basedpyright = { analysis = { typeCheckingMode = "off" } },
			},
			before_init = function(_, config)
				local python = (config.root_dir or vim.fn.getcwd()) .. "/.venv/bin/python"
				if vim.fn.executable(python) == 1 then
					config.settings.python.pythonPath = python
				end
			end,
		})
		vim.lsp.enable("basedpyright")

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")
	end,
}
