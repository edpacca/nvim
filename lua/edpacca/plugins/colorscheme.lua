return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
			highlight_overrides = {
				all = function(colors)
					return {
						NvimTreeNormal = { fg = colors.subtext1, bg = colors.base },
						NvimTreeFolderName = { fg = colors.lavender },
						NvimTreeOpenedFolderName = { fg = colors.lavender },
						NvimTreeBookmark = { fg = colors.teal },
						NvimTreeGitDirty = { fg = colors.red },
						NvimTreeGitStaged = { fg = colors.green },
						NvimTreeGitNew = { fg = colors.sky },
						NvimTreeOpenedFile = { fg = colors.teal, bg = colors.surface1 },
					}
				end,
			},
			auto_integrations = true,
		})
		vim.cmd("colorscheme catppuccin")
	end,
}
