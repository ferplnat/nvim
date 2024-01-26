local M = {}

M.remove_trailing_whitespace = function()
    M.execute_keep_cursor(
        function() vim.cmd([[silent! :keeppatterns %s/[ \t]\+$//ge]]) end
    )
end

M.execute_keep_cursor = function(func)
    vim.o.lazyredraw = true
    local curpos = vim.fn.getpos('.')
    func()
    vim.fn.setpos('.', curpos)
    vim.o.lazyredraw = false
end

return M
