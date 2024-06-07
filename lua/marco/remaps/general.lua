local utils = require('marco.utils')

local command_keep_cursor_position = function(cmd)
    return function()
        utils.execute_keep_cursor(function()
            vim.cmd(cmd)
        end)
    end
end

local command_with_count = function(cmd, mode, keep_cursor_position)
    mode = mode or ""
    cmd = mode .. vim.v.count1 .. cmd
    keep_cursor_position = keep_cursor_position or false

    return function()
        if keep_cursor_position then
            command_keep_cursor_position(cmd)()
        else
            vim.cmd(cmd)
        end
    end
end

local sort_func_map = function()
    -- I have to set the opfunc to a requirable function to avoid populating the global namespace.
    -- Local functions are not reachable from the vimscript.
    -- NOTE: Parentheses do not work here, so I have to omit them. Do not try to add them.
    vim.go.opfunc = "v:lua.require'marco.utils'.sort_func"
    return "g@V"
end

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Go to netrw (root dir)" })

vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { desc = "Move highlighted selection (J) (Indent-aware)" })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { desc = "Move highlighted selection (K) (Indent-aware)" })

vim.keymap.set("x", "<leader>sy", "\"+y", { desc = "Copy selection to system clipboard" })
vim.keymap.set("n", "<leader>syy", "\"+yy", { desc = "Copy line to system clipboard" })
vim.keymap.set({ "x", "n" }, "<leader>sp", "\"+p", { desc = "Paste selection from system clipboard" })

vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste over selection without losing default register" })
vim.keymap.set("n", "<leader>dd", "\"_dd", { desc = "Delete line without losing default register" })
vim.keymap.set("x", "<leader>d", "\"_d", { desc = "Delete selection without losing default register" })

vim.keymap.set("n", "]b", vim.cmd.bnext, { desc = "[b]uffer [n]ext" })
vim.keymap.set("n", "[b", vim.cmd.bprevious, { desc = "[b]uffer [p]revious" })

vim.keymap.set("x", "<", "<gv", { desc = "Maintain selection when indenting" })
vim.keymap.set("x", ">", ">gv", { desc = "Maintain selection when indenting" })

vim.keymap.set("n", "<leader>q", vim.cmd.copen, { desc = "Open [q]uickfix list" })
vim.keymap.set("n", "<leader>Q", vim.cmd.cclose, { desc = "Close [q]uickfix list" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "next item in quickfix list (Center viewport)" })
vim.keymap.set("n", "[q", vim.cmd.cprevious, { desc = "previous item in quickfix list (Center viewport)" })

vim.keymap.set("n", "]t", command_with_count("tabnext"), { desc = "tab next" })
vim.keymap.set("n", "[t", command_with_count("tabprevious"), { desc = "tab previous" })

vim.keymap.set("n", "]o", command_with_count("o", "normal!", false), { desc = "Insert new line below" })
vim.keymap.set("n", "[o", command_with_count("O", "normal!", false), { desc = "Insert new line above" })
vim.keymap.set("n", "]O", command_with_count("o", "normal!", true),
    { desc = "Insert new line below, keep cursor position" })
vim.keymap.set("n", "[O", command_with_count("O", "normal!", true),
    { desc = "Insert new line above, keep cursor position" })

vim.keymap.set("n", "<leader>s", sort_func_map, { expr = true, noremap = true, desc = "Sort motion" })
