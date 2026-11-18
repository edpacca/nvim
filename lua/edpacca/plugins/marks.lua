return {
	"chentoast/marks.nvim",
	event = "VeryLazy",
	opts = {
		default_mappings = true, -- m, to set next free mark, dm<x> to delete, dm- to clear line, etc.
		sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
	},
}
