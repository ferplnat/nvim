# nvim
My nvim config

# My binds
## Leader
`<Space>`

## General
### Normal Mode
`<Leader>pv` - Open netrw

`<Leader>dd` - Delete line to "Black Hole" register

`<Leader>vv` - Enter visual block mode

`]b` - `:bnext` Next buffer

`[b` - `:bprev` Previous buffer

`<Leader>q` - `:copen` Open quickfix list

`<Leader>qe` - `:cclose` Close quickfix list

`]q` - `:cnext` Next item quickfix

`[q` - `:cprev` Previous item quickfix

`]t` - `:tabnext` Next tab

`[t` - `:tabprevious` Previous tab

### Visual Mode
`J` - Move selection down (Indent aware)

`K` - Move selection up (Indent aware)

`<Leader>p` - Paste over selection (Preserve register)

`<Leader>d` - Delete selection (Preserve register)

## Harpoon
### Normal Mode
`<Ctrl-h>` - Open Harpoon list

`<Ctrl-m>` - Add item to Harpoon list

`<Ctrl-j>` - Next Harpoon item

`<Ctrl-k>` - Previous Harpoon item

## Telescope
### Normal Mode
`<Leader>pf` - Find files (Plain search)

`<Ctrl-p>` - Find files (Git tree)

`<Leader>ps` - Find files (Live grep)

## UndoTree
### Normal Mode
`<Leader>u` - Open UndoTree

## LSP
### Normal Mode
`gd` - Go to definition

`K` - Show diagnostic

`<Leader>vws` - View symbol

`<Leader>vd` - View diagnostic float

`[d` - Next diagnostic

`]d` - Previous diagnostic

`<Leader>vca` - View code actions

`<Leader>vrr` - View symbol references

`<Leader>vrn` - Rename symbol

### Insert Mode
`<Ctrl-h>` - View signature

## Completion
### Only when completion float is visible
`<Down>` - Next item

`<Up>` - Previous item

`<Return>` - Select item

### Insert Mode
`<Ctrl-s>` - Show completion options at cursor

### Only when in a LuaSnip
`<Tab>` - (LuaSnip) Jump to next area. Does nothing if completion is visible.

`<Shift-Tab>` - (LuaSnip) Jump to previous area. Does nothing if completion is visible.
