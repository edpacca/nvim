vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>s", ":w<CR>", { desc = "Save" })
keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "Save and quit" })
keymap.set("n", "<leader>ww", ":w<CR>", { desc = "Just save" })
keymap.set("n", "<leader>qa", ":qa!<CR>", { desc = "Hard quit" })
keymap.set("n", "<leader>qq", ":q<CR>", { desc = "Just quit" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- macro recording on F6 instead of q (non-recursive, so it hits the builtin q)
keymap.set("n", "q", "<Nop>", { desc = "Disable macro recording" })
keymap.set("v", "q", "<Nop>", { desc = "Disable macro recording" })
keymap.set("n", "<F6>", "q", { noremap = true, desc = "Start/stop macro recording" })

keymap.set("n", "<M-z>", function()
	vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle line wrap" })

-- increment decrement
-- keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment number" })
-- keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- tab
keymap.set("i", "<S-Tab>", "<C-d>", { desc = "De-tab" })

-- splits
keymap.set("n", "<leader>\\", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>-", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>ge", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>gw", "<cmd>close<CR>", { desc = "Close current split" })
keymap.set("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase split height" })
keymap.set("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease split height" })
keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease split width" })
keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase split width" })

-- tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tw", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- utils
keymap.set("n", "<leader>yp", function()
	require("edpacca.core.utils").yank_relative_path()
end, { desc = "Yank relative path of buffer" })
keymap.set("n", "<leader>yt", function()
	require("edpacca.core.utils").yank_pytest_path()
end, { desc = "Yank pytest path string, relative path of buffer" })
keymap.set("n", "<leader>yc", function()
	require("edpacca.lib.cliphist").yank("yy")
end, { desc = "Yank line to clipboard + cliphist" })
keymap.set("x", "<leader>yc", function()
	require("edpacca.lib.cliphist").yank("y")
end, { desc = "Yank selection to clipboard + cliphist" })

-- kitty navigator
keymap.set("n", "<M-Left>", "<cmd>KittyNavigateLeft<cr>", { desc = "Navigate left (kitty)" })
keymap.set("n", "<M-Down>", "<cmd>KittyNavigateDown<cr>", { desc = "Navigate down (kitty)" })
keymap.set("n", "<M-Up>", "<cmd>KittyNavigateUp<cr>", { desc = "Navigate up (kitty)" })
keymap.set("n", "<M-Right>", "<cmd>KittyNavigateRight<cr>", { desc = "Navigate right (kitty)" })
keymap.set("n", "<M-h>", "<cmd>KittyNavigateLeft<cr>", { desc = "Navigate left (kitty)" })
keymap.set("n", "<M-j>", "<cmd>KittyNavigateDown<cr>", { desc = "Navigate down (kitty)" })
keymap.set("n", "<M-k>", "<cmd>KittyNavigateUp<cr>", { desc = "Navigate up (kitty)" })
keymap.set("n", "<M-l>", "<cmd>KittyNavigateRight<cr>", { desc = "Navigate right (kitty)" })
