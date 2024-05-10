--- @type LazyPluginSpec
return {
    [1] = 'echasnovski/mini.nvim',
    name = 'mini',
    enabled = true,

    config = function()
        require('mini.notify').setup()
    end,
}
