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

M.ui_select_sync = function(items, prompt, label_fn)
    label_fn = label_fn or function(item)
        return item
    end

    local choices = { prompt }
    for i, item in ipairs(items) do
        table.insert(choices, string.format('%d: %s', i, label_fn(item)))
    end
    local choice = vim.fn.inputlist(choices)
    if choice < 1 or choice > #items then
        return nil
    end
    return items[choice]
end

M.extend_func = function(func, new_func)
    return function(...)
        func(...)
        new_func(...)
    end
end

return M
