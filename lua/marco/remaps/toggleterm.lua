local M = {}

M.on_open = function(term)
    vim.keymap.set("t", "<C-n>", vim.cmd.stopinsert, { noremap = true, silent = true, buffer = term.bufnr })
end

-- Open toggleterm
M.open_mapping = '<C-\\>'

return M
