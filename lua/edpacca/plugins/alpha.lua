return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Set header
		dashboard.section.header.val = {
			" ",
			"                                       ,.=,,==. ,,_",
			"                      _ ,====, _    |I|`` ||  `|I `|",
			"                     |`I|    || `==,|``   ^^   ``  |",
			"                     | ``    ^^    ||_,===TT`==,,_ |",
			"                     |,==Y``Y==,,__| \\L=_-`'   +J/`",
			"                      \\|=_  ' -=#J/..-|=_-     =|",
			"                       |=_   -;-='`. .|=_-     =|----T--,",
			"                       |=/\\  -|=_-. . |=_-/^\\  =||-|-|::|____",
			"                       |=||  -|=_-. . |=_-| |  =|-|-||::\\____",
			"                       |=LJ  -|=_-. . |=_-|_| =||-|-|:::::::",
			"                       |=_   -|=_-_.  |=_-     =|-|-||:::::::",
			"                       |=_   -|=//^\\. |=_-     =||-|-|:::::::",
			"                   ,   |/&_,_-|=||  | |=_-     =|-|-||:::::::",
			"                ,--``8%,/    ',%||  | |=_-     =||-|-|%::::::",
			"            ,---`_,888`  ,.'''''`-.,|,|/!,--,.&\\|&\\-,|&#:::::",
			"           |;:;K`__,...;=\\_____,=``           %%%&     %#,---",
			"           |;::::::::::::|       `'.________+-------\\   ``",
			"          /8M%;:::;;:::::|                  |        `-------",
		}

		-- Set menu
		dashboard.section.buttons.val = {
			-- dashboard.button("a", "  > New File", "<cmd>ene<CR>"),
			-- dashboard.button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			-- dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			-- dashboard.button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			-- dashboard.button("SPC sr", "󰁯  > Restore Session For Current Directory", "<cmd>AutoSession restore<CR>"),
			-- dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
