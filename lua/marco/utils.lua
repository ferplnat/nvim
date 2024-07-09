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

M.prepend_func = function(func, new_func)
    return function(...)
        new_func(...)
        func(...)
    end
end

M.lspconfig_run_before_start = function(func, server_name)
    local success, lspconfig = pcall(require, 'lspconfig')
    if not success then
        return
    end

    local manager = require('lspconfig.manager')

    if server_name then
        func = M.prepend_func(func, function(this, bufnr, new_config, root_dir, single_file)
            if new_config.name ~= server_name then
                return
            end

            return func(this, bufnr, new_config, root_dir, single_file)
        end)
    end

    ---@diagnostic disable-next-line: invisible
    manager._start_new_client = lspconfig.util.add_hook_before(manager._start_new_client, func)
end

M.sort_func = function()
    vim.cmd("'[,']sort")
end

M.get_mason_bin_path = function(executable)
    local mason_bin = vim.fn.stdpath('data') .. '/mason/bin'

    if jit.os == 'Windows' then
        executable = executable .. '.cmd'
    end

    return mason_bin .. '/' .. executable
end

return M
