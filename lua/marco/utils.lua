local M = {}

M.remove_trailing_whitespace = function()
    -- Save cursor position
    local curpos = vim.fn.getpos('.')

    vim.cmd([[silent! :keeppatterns %s/[ \t]\+$//ge]])
    -- Restore cursor position
    vim.fn.setpos('.', curpos)
end

return M
