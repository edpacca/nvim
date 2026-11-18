return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		local set = vim.keymap.set

		local function map(modes, lhs, rhs, desc)
			set(modes, lhs, rhs, { desc = "Multicursor: " .. desc })
		end

		-- Scheme: <leader>m = ADD, <leader>M = SKIP, then a direction key.
		--   j/k = line down/up, n/N = match next/prev.
		-- Everything else multicursor lives under <leader>m too.
		-- (<leader>s / <leader>n / <leader>x are taken: save, nohl, trouble.)

		-- Fast path (no leader) for the two most frequent actions.
		map({ "n", "x" }, "<C-n>", function()
			mc.matchAddCursor(1)
		end, "add next match")
		-- Needs kitty keyboard protocol (nvim >= 0.10 + kitty) and ctrl+shift+n
		-- unmapped in kitty.conf, otherwise <C-S-n> is indistinguishable from <C-n>.
		map({ "n", "x" }, "<C-S-n>", function()
			mc.matchAddCursor(-1)
		end, "add previous match")
		map({ "n", "x" }, "<up>", function()
			mc.lineAddCursor(-1)
		end, "add cursor above")
		map({ "n", "x" }, "<down>", function()
			mc.lineAddCursor(1)
		end, "add cursor below")

		-- Add cursor: lines
		map({ "n", "x" }, "<leader>mj", function()
			mc.lineAddCursor(1)
		end, "add cursor below")
		map({ "n", "x" }, "<leader>mk", function()
			mc.lineAddCursor(-1)
		end, "add cursor above")
		-- Skip a line (move main cursor without adding)
		map({ "n", "x" }, "<leader>Mj", function()
			mc.lineSkipCursor(1)
		end, "skip line below")
		map({ "n", "x" }, "<leader>Mk", function()
			mc.lineSkipCursor(-1)
		end, "skip line above")

		-- Add cursor: word/selection matches
		map({ "n", "x" }, "<leader>mn", function()
			mc.matchAddCursor(1)
		end, "add next match")
		map({ "n", "x" }, "<leader>mN", function()
			mc.matchAddCursor(-1)
		end, "add previous match")
		map({ "n", "x" }, "<leader>Mn", function()
			mc.matchSkipCursor(1)
		end, "skip next match")
		map({ "n", "x" }, "<leader>MN", function()
			mc.matchSkipCursor(-1)
		end, "skip previous match")
		map({ "n", "x" }, "<leader>ma", mc.matchAllAddCursors, "add all matches")

		-- Visual-selection tools
		map("x", "<leader>ms", mc.splitCursors, "split selection by regex")
		map("x", "<leader>m/", mc.matchCursors, "select by regex match")
		map("x", "<leader>mv", mc.visualToCursors, "visual lines to cursors")

		-- Cursor-set tools
		map({ "n", "x" }, "<leader>mm", mc.toggleCursor, "toggle (disable/enable) cursor")
		map("n", "<leader>mr", mc.restoreCursors, "restore previous cursors")
		map({ "n", "x" }, "<leader>m=", mc.alignCursors, "align cursors")
		map("x", "<leader>mt", function()
			mc.transposeCursors(1)
		end, "transpose forward")
		map("x", "<leader>mT", function()
			mc.transposeCursors(-1)
		end, "transpose backward")

		-- Add and remove cursors with control + left click.
		set("n", "<c-leftmouse>", mc.handleMouse)
		set("n", "<c-leftdrag>", mc.handleMouseDrag)
		set("n", "<c-leftrelease>", mc.handleMouseRelease)

		-- Mappings defined in a keymap layer only apply when there are
		-- multiple cursors. This lets you have overlapping mappings.
		mc.addKeymapLayer(function(layerSet)
			-- Select a different cursor as the main one.
			layerSet({ "n", "x" }, "<left>", mc.prevCursor)
			layerSet({ "n", "x" }, "<right>", mc.nextCursor)

			-- Delete the main cursor (m + x = remove).
			layerSet({ "n", "x" }, "<leader>mx", mc.deleteCursor)

			-- Enable and clear cursors using escape.
			layerSet("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end)
		end)

		-- Customize how cursors look.
		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { reverse = true })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorMatchPreview", { link = "Search" })
		hl(0, "MultiCursorDisabledCursor", { reverse = true })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
}
