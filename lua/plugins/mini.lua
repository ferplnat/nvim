--- @module 'lazy.types'
--- @type LazyPluginSpec
return {
    [1] = 'echasnovski/mini.nvim',
    name = 'mini',

    config = function()
        require('mini.notify').setup()

        local opts = { ERROR = { duration = 10000 } }
        vim.notify = require('mini.notify').make_notify(opts)
    end,
}
