# Neovim Keymaps

> Leader key: `<Space>`

---

## General

| Key          | Mode   | Action                  |
| ------------ | ------ | ----------------------- |
| `jk`         | Insert | Exit insert mode        |
| `<leader>ww` | Normal | Save                    |
| `<leader>wq` | Normal | Save and quit           |
| `<leader>qa` | Normal | Hard quit (`:qa!`)      |
| `<leader>qq` | Normal | Quit (`:q`)             |
| `<leader>nh` | Normal | Clear search highlights |
| `<leader>yp` | Normal | Yank relative path of buffer |
| `<M-z>`      | Normal | Toggle line wrap        |
| `<S-Tab>`    | Insert | De-indent (de-tab)      |
| `q`          | Normal / Visual | Disabled (no macro recording) |

---

## Window Splits

| Key          | Mode   | Action                                  |
| ------------ | ------ | --------------------------------------- |
| `<leader>\`  | Normal | Split vertically                        |
| `<leader>-`  | Normal | Split horizontally                      |
| `<leader>se` | Normal | Make splits equal size                  |
| `<leader>sw` | Normal | Close current split                     |
| `<leader>gm` | Normal | Maximize/minimize split (vim-maximizer) |

### Split Navigation (vim-kitty-navigator)

| Key                    | Mode   | Action         |
| ---------------------- | ------ | -------------- |
| `<M-Left>` / `<M-h>`   | Normal | Navigate left  |
| `<M-Down>` / `<M-j>`   | Normal | Navigate down  |
| `<M-Up>` / `<M-k>`     | Normal | Navigate up    |
| `<M-Right>` / `<M-l>`  | Normal | Navigate right |

---

## Tabs

| Key          | Mode   | Action                         |
| ------------ | ------ | ------------------------------ |
| `<leader>to` | Normal | Open new tab                   |
| `<leader>tw` | Normal | Close current tab              |
| `<leader>tn` | Normal | Next tab                       |
| `<leader>tp` | Normal | Previous tab                   |
| `<leader>tf` | Normal | Open current buffer in new tab |

---

## File Explorer (nvim-tree)

| Key          | Mode   | Action                         |
| ------------ | ------ | ------------------------------ |
| `<leader>ee` | Normal | Toggle file explorer           |
| `<leader>ef` | Normal | Focus explorer on current file |
| `<leader>ec` | Normal | Collapse file explorer         |
| `<leader>er` | Normal | Refresh file explorer          |
| `<leader>en` | Normal | Set selected node as root      |

---

## Telescope (Fuzzy Finding)

| Key                    | Mode   | Action                 |
| ---------------------- | ------ | ---------------------- |
| `<leader>ff` / `<C-p>` | Normal | Find files in cwd      |
| `<leader>fR`           | Normal | Find recent files      |
| `<leader>fs`           | Normal | Live grep in cwd (with args) |
| `<leader>fc`           | Normal | Find word under cursor |
| `<leader>ft`           | Normal | Find TODOs             |
| `<leader>fb`           | Normal | Find open buffers      |
| `<leader>fm`           | Normal | Find global marks      |
| `<leader>fr`           | Normal | Resume last picker     |

### Telescope (inside picker)

| Key      | Mode   | Action                                          |
| -------- | ------ | ----------------------------------------------- |
| `<C-k>`  | Insert | Previous result                                 |
| `<C-j>`  | Insert | Next result                                     |
| `<Up>`   | Insert | Previous history entry                          |
| `<Down>` | Insert | Next history entry                              |
| `<C-q>`  | Insert | Send selected to quickfix list                  |
| `<C-x>`  | Insert | Open in Trouble                                 |
| `<C-d>`  | Insert | Delete buffer (buffers picker)                  |
| `<Tab>`  | Insert | Append ` --iglob ` (live grep args picker)      |

---

## Harpoon

| Key             | Mode   | Action                                   |
| --------------- | ------ | ---------------------------------------- |
| `<leader>a`     | Normal | Add file to harpoon list                 |
| `<leader>fh`    | Normal | Toggle harpoon quick menu                |
| `<leader>u`     | Normal | Jump to harpoon file 1                   |
| `<leader>i`     | Normal | Jump to harpoon file 2                   |
| `<leader>o`     | Normal | Jump to harpoon file 3                   |
| `<leader>p`     | Normal | Jump to harpoon file 4                   |
| `<leader>hu`    | Normal | Replace harpoon slot 1 with current file |
| `<leader>hi`    | Normal | Replace harpoon slot 2 with current file |
| `<leader>ho`    | Normal | Replace harpoon slot 3 with current file |
| `<leader>hp`    | Normal | Replace harpoon slot 4 with current file |

---

## LSP

| Key          | Mode            | Action                              |
| ------------ | --------------- | ----------------------------------- |
| `gR`         | Normal          | Show references (Telescope)         |
| `gD`         | Normal          | Go to declaration                   |
| `gd`         | Normal          | Show definitions (Telescope)        |
| `gi`         | Normal          | Show implementations (Telescope)    |
| `gt`         | Normal          | Show type definitions (Telescope)   |
| `<leader>;`  | Normal / Visual | Code actions                        |
| `<leader>rn` | Normal          | Rename symbol                       |
| `<leader>D`  | Normal          | Show buffer diagnostics (Telescope) |
| `<leader>d`  | Normal          | Show line diagnostics (float)       |
| `[d`         | Normal          | Go to previous diagnostic           |
| `]d`         | Normal          | Go to next diagnostic               |
| `<leader>rs` | Normal          | Restart LSP                         |

---

## Diagnostics & Trouble

| Key          | Mode   | Action                                 |
| ------------ | ------ | -------------------------------------- |
| `<leader>xw` | Normal | Toggle workspace diagnostics (Trouble) |
| `<leader>xd` | Normal | Toggle document diagnostics (Trouble)  |

---

## Git (Gitsigns)

| Key          | Mode              | Action                    |
| ------------ | ----------------- | ------------------------- |
| `<leader>hb` | Normal            | Blame line (full)         |
| `<leader>hB` | Normal            | Toggle line blame         |
| `<leader>hd` | Normal            | Diff this                 |
| `<leader>hD` | Normal            | Diff this `~`             |
| `<leader>lg` | Normal            | Open LazyGit              |

---

## Completion (nvim-cmp)

| Key         | Mode   | Action                   |
| ----------- | ------ | ------------------------ |
| `<C-k>`     | Insert | Previous suggestion      |
| `<C-j>`     | Insert | Next suggestion          |
| `<Tab>`     | Insert | Next suggestion          |
| `<S-Tab>`   | Insert | Previous suggestion      |
| `<C-b>`     | Insert | Scroll docs up           |
| `<C-f>`     | Insert | Scroll docs down         |
| `<A-Enter>` | Insert | Trigger completion       |
| `<C-e>`     | Insert | Abort / close completion |
| `<CR>`      | Insert | Confirm selection        |

---

## Formatting

| Key       | Mode            | Action                              |
| --------- | --------------- | ----------------------------------- |
| `<S-M-f>` | Normal / Visual | Format file or range (conform.nvim) |

---

## Sessions (auto-session)

| Key          | Mode   | Action                  |
| ------------ | ------ | ----------------------- |
| `<leader>wr` | Normal | Restore session for cwd |
| `<leader>ws` | Normal | Save session for cwd    |

---

## Commenting (Neovim built-in)

| Key   | Mode   | Action              |
| ----- | ------ | ------------------- |
| `gcc` | Normal | Toggle line comment |
| `gc`  | Visual | Toggle comment      |

---

## Marks (marks.nvim, default mappings)

| Key    | Mode   | Action                |
| ------ | ------ | --------------------- |
| `m,`   | Normal | Set next free mark    |
| `dm{x}`| Normal | Delete mark `x`       |
| `dm-`  | Normal | Delete marks on line  |

---

## Sneak (vim-sneak)

| Key         | Mode   | Action                          |
| ----------- | ------ | ------------------------------- |
| `s{ab}`     | Normal | Jump to next `ab` match         |
| `S{ab}`     | Normal | Jump to previous `ab` match     |

---

## Surround (nvim-surround)

| Key                | Mode   | Action             |
| ------------------ | ------ | ------------------ |
| `ys{motion}{char}` | Normal | Add surround       |
| `ds{char}`         | Normal | Delete surround    |
| `cs{old}{new}`     | Normal | Change surround    |
| `S{char}`          | Visual | Surround selection |
