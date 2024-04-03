local M = {}

M.apply = function()
    vim.keymap.set("n", "g=", function()
        require('marco.utils').remove_trailing_whitespace()
        require('conform').format({ bufnr = vim.api.nvim_get_current_buf() })
    end, { desc = "Format current buffer." })
end

return M
