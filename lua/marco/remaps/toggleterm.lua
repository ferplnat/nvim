local M = {}

M.on_open = function(term)
    vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-n>", "<cmd>stopinsert!<Return>",
        { noremap = true, silent = true })
end

-- Open toggleterm
M.open_mapping = '<C-\\>'

return M
