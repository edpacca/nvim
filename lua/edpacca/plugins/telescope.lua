return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"nvim-telescope/telescope-live-grep-args.nvim",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		-- local transform_mod = require("telescope.actions.mt").transform_mod

		local open_with_trouble = require("trouble.sources.telescope")
		local action_state = require("telescope.actions.state")
		local lga_actions = require("telescope-live-grep-args.actions")
		local quote_iglob = lga_actions.quote_prompt({ postfix = " --iglob " })

		-- first <Tab>: quote prompt + add --iglob, second <Tab>: fill iglob with current buffer path
		local function iglob_or_current_buffer(prompt_bufnr)
			local picker = action_state.get_current_picker(prompt_bufnr)
			local prompt = picker:_get_prompt()
			if not prompt:match("%-%-iglob $") then
				return quote_iglob(prompt_bufnr)
			end
			local buf = vim.api.nvim_win_get_buf(picker.original_win_id)
			local name = vim.api.nvim_buf_get_name(buf)
			if name == "" then
				return
			end
			picker:set_prompt(prompt .. vim.fn.fnamemodify(name, ":."))
		end

		-- CAPS prompt (e.g. "MTF") also matches filename segment initials
		local function find_files()
			require("telescope.builtin").find_files({ sorter = require("edpacca.lib.telescope_initials").sorter() })
		end

		-- or create your custom action
		-- local custom_actions = transform_mod({
		--   open_trouble_qflist = function(prompt_bufnr)
		--     trouble.toggle("quickfix")
		--   end,
		-- })

		telescope.setup({
			defaults = {
				preview = {
					treesitter = false,
				},
				path_display = { "filename_first" },
				file_ignore_patterns = {
					"%.png$",
					"%.jpg$",
					"%.jpeg$",
					"%.gif$",
					"%.svg$",
					"%.ico$",
					"%.webp$",
					"%.bmp$",
					"%.tiff?$",
					"%.mp3$",
					"%.wav$",
					"%.ogg$",
					"%.flac$",
					"%.aac$",
					"%.m4a$",
					"%.mp4$",
					".test_durations",
				},
				sorting_strategy = "ascending",
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						prompt_position = "top",
						mirror = "true",
						preview_height = 0.7,
					},
				},
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--glob=!.git/**",
				},
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<Up>"] = actions.cycle_history_prev,
						["<Down>"] = actions.cycle_history_next,
						["<C-r>"] = function(prompt_bufnr)
							local picker = action_state.get_current_picker(prompt_bufnr)
							picker:refresh(picker.finder, { reset_prompt = false })
						end,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<C-x>"] = open_with_trouble,
					},
				},
			},
			pickers = {
				find_files = {
					find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
				},
				buffers = {
					sort_mru = true,
					ignore_current_buffer = true,
					mappings = {
						i = {
							["<C-d>"] = actions.delete_buffer,
						},
					},
				},
			},
			extensions = {
				live_grep_args = {
					auto_quoting = true,
					mappings = {
						i = {
							["<Tab>"] = iglob_or_current_buffer,
						},
					},
				},
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", find_files, { desc = "Fuzzy find files in cwd (CAPS = initials)" })
		keymap.set("n", "<C-p>", find_files, { desc = "Fuzzy find files in cwd (CAPS = initials)" })
		keymap.set("n", "<leader>fR", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", function()
			telescope.extensions.live_grep_args.live_grep_args()
		end, { desc = "Grep in cwd (with args)" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find open buffers" })
		keymap.set("n", "<leader>fm", "<cmd>Telescope marks mark_type=global<cr>", { desc = "Find global marks" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope resume<cr>", { desc = "Resume last telescope picker" })
	end,
}
