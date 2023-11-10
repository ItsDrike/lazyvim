# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## Shortcut Cheatsheet

| Key               | Action                      |
| ----------------- | --------------------------- |
| `<leader><space>` | Fuzzy find files (root dir) |
| `<C-n>`           | Toggle Neoree               |
| `<C-/>`           | Toggle floating terminal    |
| `<leader>qq`      | Quit all (:qa)              |
| `<leader>sr`      | Spectre search & replace    |
| `<leader>p`       | Open yank history           |

LSP / Linting / Formatting

| Key          | Action                        |
| ------------ | ----------------------------- |
| `<leader>cf` | Format                        |
| `<leader>cd` | Line diagnostics              |
| `]d`         | Next diagnostic               |
| `[d`         | Prev diagnostic               |
| `]e`         | Next error                    |
| `[e`         | Prev error                    |
| `]w`         | Next warning                  |
| `[w`         | Prev warning                  |
| `<leader>ss` | Jump to LSP symbol in file    |
| `<leader>sS` | Jump to LSP symbol in project |
| `<leader>uf` | Toggle auto format (global)   |
| `<leader>uF` | Toggle auto format (buffer)   |
| `<leader>us` | Toggle spellcheck             |
| `<leader>uw` | Toggle word wrap              |
| `<leader>cl` | Lsp Info                      |
| `gd`         | Go to definition              |
| `gD`         | Go to declaration             |
| `gI`         | Go to implementation          |
| `gy`         | Go to type definition         |
| `gr`         | Show references (telescope)   |
| `K`          | Hover                         |
| `gK`         | Signature help                |
| `<C-k>`      | Signature help                |
| `<leader>ca` | Code action                   |
| `<leader>cA` | Source action                 |
| `<leader>cr` | Rename                        |

Buffers

| Key          | Action                        |
| ------------ | ----------------------------- |
| `<leader>,`  | Fuzzy find open buffers       |
| `<leader>bd` | Close buffer                  |
| `<leader>bp` | Pin buffer                    |
| `<leader>bP` | Delete all non-pinned buffers |
| `<leader>bo` | Delete all other buffers      |
| `<leader>\`` | Switch to other buffer        |
| `<S-h>`      | Previous buffer               |
| `<S-l>`      | Next buffer                   |
| `[b`         | Previous buffer               |
| `]b`         | Next buffer                   |

Visuals

| Key          | Action                                          |
| ------------ | ----------------------------------------------- |
| `<leader>ui` | Inspect position under cursor (show highlights) |
| `<leader>ud` | Toggle diagnostics                              |
| `<leader>uh` | Toggle inlay hints                              |
| `<leader>uc` | Toggle conceal                                  |
| `<leader>uT` | Toggle treesitter highlight                     |

Surround bindings

| Key   | Action                    |
| ----- | ------------------------- |
| `S`   | Treesitter based surround |
| `gsa` | Add surrounding           |
| `gsd` | Delete surrounding        |
