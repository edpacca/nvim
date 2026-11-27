vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

-- already in .vimrc
opt.relativenumber = true
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.wrap = false
opt.ignorecase = true
opt.cursorline = true
opt.termguicolors = true
opt.clipboard:append("unnamedplus")
opt.diffopt:append("algorithm:histogram")

-- tabs & indentation
opt.expandtab = true
opt.autoindent = true

-- search settings
opt.smartcase = true

-- colors
opt.background = "dark"
opt.signcolumn = "yes:2"

-- backspace
opt.backspace = "indent,eol,start"

-- split windows
opt.splitright = true
opt.splitbelow = true

-- folding (foldmethod/foldexpr set per-buffer when treesitter starts)
opt.foldlevel = 99 -- open everything by default
opt.foldlevelstart = 99
opt.foldtext = "" -- show the fold's first line with syntax highlighting
opt.fillchars:append({ fold = " " })

-- title
opt.title = true
opt.titlestring = "%{fnamemodify(getcwd(), ':t')}"

-- go templates: `helm` filetype = gotmpl + yaml injected into the text
vim.filetype.add({
	extension = { gotmpl = "gotmpl" },
	pattern = {
		[".*%.ya?ml%.gotmpl"] = "helm",
	},
})

vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	callback = function()
		-- tabdo leaves you on the last tab, so remember and restore the current one
		local current_tab = vim.api.nvim_get_current_tabpage()
		vim.cmd("tabdo wincmd =")
		vim.api.nvim_set_current_tabpage(current_tab)
	end,
})
