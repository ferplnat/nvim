vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Go to netrw (root dir)" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted selection (J) (Indent-aware)" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted selection (K) (Indent-aware)" })

vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste over selection without losing buffer" })
vim.keymap.set("n", "<leader>dd", "\"_dd", { desc = "Delete line without losing buffer" })
vim.keymap.set("x", "<leader>d", "\"_d", { desc = "Delete selection without losing buffer" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Keep screen centered when half-page jumping" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Keep screen centered when half-page jumping" })

vim.keymap.set("n", "<leader>vv", "<C-v>", { desc = "Visual block mode (Windows Terminal <C-v> is paste)" })

vim.keymap.set("n", "]b", ":bnext<Return>", { desc = "[b]uffer [n]ext" })
vim.keymap.set("n", "[b", ":bprevious<Return>", { desc = "[b]uffer [p]revious" })

vim.keymap.set("v", "<", "<gv", { desc = "Maintain selection when indenting" })
vim.keymap.set("v", ">", ">gv", { desc = "Maintain selection when indenting" })

vim.keymap.set("n", "<leader>q", ":copen<Return>", { desc = "Open [q]uickfix list" })
vim.keymap.set("n", "<leader>qe", ":cclose<Return>", { desc = "[q]uickfix list [e]xit" })
vim.keymap.set("n", "]q", ":cnext<Return>zz", { desc = "next item in quickfix list (Center viewport)" })
vim.keymap.set("n", "[q", ":cprev<Return>zz", { desc = "previous item in quickfix list (Center viewport)" })

vim.keymap.set("n", "]t", ":tabnext<Return>", { desc = "tab next" })
vim.keymap.set("n", "[t", ":tabprevious<Return>", { desc = "tab previous" })
