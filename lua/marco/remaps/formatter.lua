local M = {}

M.apply = function()
    vim.keymap.set("n", "g=", function()
        require('marco.utils').remove_trailing_whitespace()
        vim.cmd([[silent! :noautocmd FormatWrite]])
    end, { desc = "Format current buffer." })
end

return M
