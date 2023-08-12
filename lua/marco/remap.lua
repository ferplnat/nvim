vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Go to netrw (root dir)" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted selection (J) (Indent-aware)" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted selection (K) (Indent-aware)" })

vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste without losing buffer" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Keep screen centered when half-page jumping" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Keep screen centered when half-page jumping" })

vim.keymap.set("n", "<leader>vv", "<C-v>", { desc = "Visual block mode (Windows Terminal <C-v> is paste)" })

vim.keymap.set("n", "<leader>bp", ":bprevious<Return>", { desc = "[b]uffer [p]revious" })
vim.keymap.set("n", "<leader>bn", ":bnext<Return>", { desc = "[b]uffer [n]ext" })

vim.keymap.set("v", "<", "<gv", { desc = "Maintain selection when indenting" })
vim.keymap.set("v", ">", ">gv", { desc = "Maintain selection when indenting" })

vim.keymap.set("n", "<leader>q", ":copen<Return>", { desc = "Open [q]uickfix list" })
vim.keymap.set("n", "<leader>qe", ":cclose<Return>", { desc = "[e]xit [q]uickfix list" })
vim.keymap.set("n", "<leader>n", ":cnext<Return>", { desc = "[n]ext item in quickfix list" })
vim.keymap.set("n", "<leader>p", ":cprev<Return>", { desc = "[p]revious item in quickfix list" })
