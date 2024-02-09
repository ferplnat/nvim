--- @type LazyPluginSpec
return {
    name = 'undotree',
    [1] = 'mbbill/undotree',
    version = '*',

    config = function()
        local nvim_data_dir = vim.fn.stdpath('data')
        local undotree_dir = nvim_data_dir .. '/undotreedir'

        if vim.fn.isdirectory(undotree_dir) == 0 then
            vim.fn.mkdir(undotree_dir, 'p')
        end

        vim.o.undofile = true
        vim.g.undotree_UndoDir = undotree_dir

        require('marco.remaps.undotree').apply()
    end,
}
