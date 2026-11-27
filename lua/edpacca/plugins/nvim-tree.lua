return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")
		local nvimtreeapi = require("nvim-tree.api")
		-- recommended settings from nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		local width_standard = 45
		local width_wide = 90

		nvimtree.setup({
			view = {
				width = width_standard,
				relativenumber = true,
			},
			sort = {
				sorter = "case_sensitive",
			},
			-- change folder arrow icons
			renderer = {
				indent_markers = {
					enable = true,
				},
				highlight_git = "all",
				highlight_opened_files = "name",
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "", -- arrow when folder is closed
							arrow_open = "", -- arrow when folder is open
						},
					},
				},
			},
			-- disable window_picker for
			-- explorer to work well with
			-- window splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {},
			git = {
				ignore = false,
			},
		})

		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
		keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
		keymap.set(
			"n",
			"<leader>en",
			nvimtreeapi.tree.change_root_to_node,
			{ desc = "Set selected node as root folder" }
		)

		-- toggle tree width between narrow and wide
		local function toggle_tree_width()
			local winid = nvimtreeapi.tree.winid()
			if not winid then
				return
			end

			local width = vim.api.nvim_win_get_width(winid)
			local new_width = (width == width_standard) and width_wide or width_standard
			nvimtreeapi.tree.resize({ absolute = new_width })
		end

		keymap.set("n", "<leader>ew", toggle_tree_width, { desc = "Toggle file explorer width" })
	end,
}
