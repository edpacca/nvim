return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	lazy = false,
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup({
			settings = {
				save_on_toggle = true,
			},
		})

		-- quick menu: 1-9 select the corresponding item
		harpoon:extend({
			UI_CREATE = function(cx)
				for idx = 1, 9 do
					vim.keymap.set("n", tostring(idx), function()
						if idx > vim.api.nvim_buf_line_count(cx.bufnr) then
							return
						end
						vim.api.nvim_win_set_cursor(cx.win_id, { idx, 0 })
						harpoon.ui:select_menu_item()
					end, { buffer = cx.bufnr })
				end
			end,
		})

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<leader>fh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		-- switch to harpooned files
		vim.keymap.set("n", "<leader>u", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<leader>i", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<leader>o", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<leader>p", function()
			harpoon:list():select(4)
		end)
		vim.keymap.set("n", "<leader>hu", function()
			harpoon:list():replace_at(1)
		end)
		vim.keymap.set("n", "<leader>hi", function()
			harpoon:list():replace_at(2)
		end)
		vim.keymap.set("n", "<leader>ho", function()
			harpoon:list():replace_at(3)
		end)
		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():replace_at(4)
		end)

		-- <leader>1-9 switch to, <leader>h1-9 replace at
		for idx = 1, 9 do
			vim.keymap.set("n", "<leader>" .. idx, function()
				harpoon:list():select(idx)
			end)
			vim.keymap.set("n", "<leader>h" .. idx, function()
				harpoon:list():replace_at(idx)
			end)
		end
	end,
}
