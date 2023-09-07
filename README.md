# nvim
My nvim config

# My binds

## General
### Normal Mode
`<leader>pv` - Open netrw

`<leader>dd` - Delete line to "Black Hole" register

`<leader>vv` - Enter visual block mode

`]b` - `:bnext` Next buffer

`[b` - `:bprev` Previous buffer

`<leader>q` - `:copen` Open quickfix list

`<leader>qe` - `:cclose` Close quickfix list

`]q` - `:cnext` Next item quickfix

`[q` - `:cprev` Previous item quickfix

`]t` - `:tabnext` Next tab

`[t` - `:tabprevious` Previous tab

### Visual Mode
`J` - Move selection down (Indent aware)

`K` - Move selection up (Indent aware)

`<leader>p` - Paste over selection (Preserve register)

`<leader>d` - Delete selection (Preserve register)

## Harpoon
### Normal Mode
`<C-h>` - Open Harpoon list

`<C-m>` - Add item to Harpoon list

`<C-j>` - Next Harpoon item

`<C-k>` - Previous Harpoon item

## Telescope
### Normal Mode
`<leader>pf` - Find files (Plain search)

`<C-p>` - Find files (Git tree)

`<leader>ps` - Find files (Live grep)

## UndoTree
### Normal Mode
`<leader>u` - Open UndoTree

## LSP
### Normal Mode
`gd` - Go to definition

`K` - Show diagnostic

`<leader>vws` - View symbol

`<leader>vd` - View diagnostic float

`[d` - Next diagnostic

`]d` - Previous diagnostic

`<leader>vca` - View code actions

`<leader>vrr` - View symbol references

`<leader>vrn` - Rename symbol

### Insert Mode
`<C-h>` - View signature

## Completion
`['<Down>']` - Next item

`['<Up>']` - Previous item

`['<Return>']` - Select item

`["<C-s>"]` - Show completion options at cursor

`["<Tab>"]` - (LuaSnip) Jump to next area. Does nothing if completion is visible.

`["<S-Tab>"]` - (LuaSnip) Jump to previous area. Does nothing if completion is visible.
