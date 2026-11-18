# Neovim config

                                      ,.=,,==. ,,_
                     _ ,====, _    |I|`` ||  `|I `|
                    |`I|    || `==,|``   ^^   ``  |
                    | ``    ^^    ||_,===TT`==,,_ |
                    |,==Y``Y==,,__| \\L=_-`'   +J/`
                     \\|=_  ' -=#J/..-|=_-     =|
                      |=_   -;-='`. .|=_-     =|----T--,
                      |=/\\  -|=_-. . |=_-/^\\  =||-|-|::|____
                      |=||  -|=_-. . |=_-| |  =|-|-||::\\____
                      |=LJ  -|=_-. . |=_-|_| =||-|-|:::::::
                      |=_   -|=_-_.  |=_-     =|-|-||:::::::
                      |=_   -|=//^\\. |=_-     =||-|-|:::::::
                  ,   |/&_,_-|=||  | |=_-     =|-|-||:::::::
               ,--``8%,/    ',%||  | |=_-     =||-|-|%::::::
           ,---`_,888`  ,.'''''`-.,|,|/!,--,.&\\|&\\-,|&#:::::
          |;:;K`__,...;=\\_____,=``           %%%&     %#,---
          |;::::::::::::|       `'.________+-------\\   ``
         /8M%;:::;;:::::|                  |        `-------

## Locations

- _main entrypoint_ `init.lua`
- _plugin config dir_: `lua/edpacca/plugins`
- _plugin config entrypoint_: `lua/edpacca/plugins/init.lua`
- _core config dir_: `lua/edpacca/core`
- _core config entrypoint_: `lua/edpacca/core/init.lua`
- _lsp config dir_: `lua/edpacca/plugins/lsp`
- _keymaps_: `lua/edpacca/core/keymaps.lua`
  - plugin keymaps live in the plugin config file
- _custom logic_: `lua/edpacca/lib` (testable modules; keep plugin specs thin and require these)
- _tests_: `tests/**/*_spec.lua` (plenary-busted), run with `make test`
  - `tests/minimal_init.lua` loads only this config's `lua/` + plugins the tests need; add plugins there as required
