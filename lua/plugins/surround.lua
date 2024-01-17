--- @type LazyPluginSpec
return {
    name = 'surround',
    [1] = 'kylechui/nvim-surround',

    config = function()
        local surround = require('nvim-surround')

        surround.setup({
        })
    end,
}
