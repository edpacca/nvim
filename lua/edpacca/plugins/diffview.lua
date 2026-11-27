return {
	"dlyongemallo/diffview-plus.nvim",
	version = "*",
	cmd = {
		"DiffviewOpen",
		"DiffviewClose",
		"DiffviewFileHistory",
		"DiffviewToggleFiles",
		"DiffviewFocusFiles",
		"DiffviewMergeFiles",
		"DiffviewDiffFiles",
	},
	keys = {
		{
			"<leader>gd",
			"<cmd>DiffviewOpen origin/main...HEAD --imply-local<cr>",
			desc = "Diff view against main",
		},
		{
			"<leader>gl",
			"<cmd>DiffviewOpen<cr>",
			desc = "Diff view against last commit",
		},
	},
	config = function()
		local diffview = require("diffview")
		diffview.setup({
			enhanced_diff_hl = true,
			use_icons = true,
			view = {
				default = { layout = "diff2_horizontal" },
				merge_tool = { layout = "diff3_horizontal" },
			},
			file_panel = {
				listing_style = "tree",
				win_config = { position = "left", width = "auto" }, -- "auto" fits content
			},
			hooks = {
				-- strip gutters in diff windows to reclaim horizontal space;
				-- window-local so normal buffers keep numbers/signs
				diff_buf_win_enter = function()
					vim.opt_local.number = false
					vim.opt_local.relativenumber = false
					vim.opt_local.signcolumn = "no"
					vim.opt_local.foldcolumn = "0"
				end,
			},
		})
	end,
}
